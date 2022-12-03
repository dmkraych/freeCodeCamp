#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ MY SALON ~~~~~\n"

echo -e "Welcome to My Salon, how can I help you?\n"
APPOINTMENT_MENU() {
    if [[ $1 ]]
    then
        echo -e "\n$1"
    fi

    # Identify user
        # prompt user to choose a service
    


    SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")
    echo "$SERVICES" | while read SERVICE_ID BAR NAME 
    do
        echo -e "$SERVICE_ID) $NAME"
    done
    # read in response
    read SERVICE_ID_SELECTED

    # if response not valid
    if [[ ! $SERVICE_ID_SELECTED =~ ^[1-5]$ ]]
    then
        APPOINTMENT_MENU "\nI could not find that service. What would you like today?"
    else
        CHOSEN_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_SELECTED';")
        CHOSEN_SERVICE_FORMATTED=$(echo $CHOSEN_SERVICE | sed -r 's/^ *| *$//')

        echo -e "\nWhat's your phone number?"
        read CUSTOMER_PHONE
        if [[ $CUSTOMER_PHONE =~ [0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9] ]]
        then
          CUSTOMER_PHONE=$(echo $CUSTOMER_PHONE | sed -r 's/-//g')
        fi

        CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
        CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//')
        if [[ -z $CUSTOMER_NAME ]]
        then
            echo "I don't have a record for that phone number, what's your name?"
            read CUSTOMER_NAME
            CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//')

            # insert new customer
            INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
        fi

    # get user's customer id
        CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

        echo -e "\nWhat time would you like your $CHOSEN_SERVICE_FORMATTED, $CUSTOMER_NAME_FORMATTED?"
        read SERVICE_TIME


        INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time)  VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME');")
        if [[ $INSERT_APPOINTMENT_RESULT == 'INSERT 0 1' ]]
        then
            echo -e "\nI have put you down for a $CHOSEN_SERVICE_FORMATTED at $SERVICE_TIME, $CUSTOMER_NAME_FORMATTED."
        else
            APPOINTMENT_MENU "An error has occurred. Please try again."
        fi
    fi
}

APPOINTMENT_MENU


