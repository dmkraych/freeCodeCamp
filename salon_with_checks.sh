#! /bin/bash
PSQL="psql -X --username=derik --dbname=salon --tuples-only -c"

echo -e "\n~~~ Welcome to my Salon! ~~~\n"

MAIN_MENU() {
    if [[ $1 ]]
    then
        echo -e "\n$1"
    fi
    # display menu of salon options


    echo "How can I help you today?"
    echo -e "\n1. Book an appointment\n2. Cancel an appointment\n3. Exit"

    read MAIN_MENU_SELECTION
    case $MAIN_MENU_SELECTION in
        1) APPOINTMENT_MENU ;;
        2) CANCELLATIONS_MENU ;;
        3) EXIT ;;
        *) MAIN_MENU "Please enter a valid option."
    esac
}    

APPOINTMENT_MENU() {
    if [[ $1 ]]
    then
        echo -e "\n$1"
    fi

    # Identify user
    echo -e "\nPlease enter your 10-digit phone number:"
    read CUSTOMER_PHONE
    if [[ $CUSTOMER_PHONE =~ [0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9] ]]
    then
        CUSTOMER_PHONE=$(echo $CUSTOMER_PHONE | sed -r 's/-//g')
    fi
    while [[ ! $CUSTOMER_PHONE =~ ^[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]$ ]]
    do
        echo "That format is not accepted. Please enter your phone in the format xxx-xxx-xxxx:"
        read CUSTOMER_PHONE
        CUSTOMER_PHONE=$(echo $CUSTOMER_PHONE | sed -r 's/-//g')
        echo 
    done
    CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")
    CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//')
    if [[ -z $CUSTOMER_NAME ]]
    then
        echo "We don't have your number on file. Please enter your name:"
        read CUSTOMER_NAME
        CUSTOMER_NAME_FORMATTED=$(echo $CUSTOMER_NAME | sed -r 's/^ *| *$//')

        # insert new customer
        INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$CUSTOMER_PHONE');")
        echo -e "\nThanks, $CUSTOMER_NAME_FORMATTED! It's great to have you with us."
    else
        echo -e "\nHello, $CUSTOMER_NAME_FORMATTED! It's good to have you back again."
    fi

    # get user's customer id
    CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

    # prompt user to choose a service
    
    echo -e "\nWhat service would you like to book today?"

    AVAILABLE_SERVICES=$($PSQL "SELECT service_id, name FROM services ORDER BY service_id;")
    echo "$AVAILABLE_SERVICES" | while read SERVICE_ID BAR NAME 
    do
        echo "$SERVICE_ID) $NAME"
    done
    echo "6) Cancel"
    # read in response
    read SERVICE_ID_TO_BOOK

    # if response not valid
    if [[ ! $SERVICE_ID_TO_BOOK =~ ^[1-6]$ ]]
    then
        APPOINTMENT_MENU "Please choose a valid option from the list."
    elif [[ $SERVICE_ID_TO_BOOK == 6 ]] 
    then
        EXIT
    else
        CHOSEN_SERVICE=$($PSQL "SELECT name FROM services WHERE service_id='$SERVICE_ID_TO_BOOK';")
        CHOSEN_SERVICE_FORMATTED=$(echo $CHOSEN_SERVICE | sed -r 's/^ *| *$//')
        
        echo -e "Excellent, a $CHOSEN_SERVICE_FORMATTED.\nWhat time would you like to come in?"
        read APPOINTMENT_TIME
        
        # Check if time is in either XX:XX or XX format 
        while [[ ! $APPOINTMENT_TIME =~ ^(0?[1-9]|1[0-2]):[0-5][0-9]([AaPp][Mm])?$ && ! $APPOINTMENT_TIME =~ ^(0?[1-9]|1[0-2])([AaPp][Mm])?$  ]]
        do
            echo "Please provide a 12-hour time using the XX:XX format."
            read APPOINTMENT_TIME
        done
        # check if user provided am or pm
        if [[ ! $APPOINTMENT_TIME =~ ^(0?[1-9]|1[0-2]):[0-5][0-9]?[AaPp][Mm]$ && ! $APPOINTMENT_TIME =~ ^(0?[1-9]|1[0-2])?[AaPp][Mm]$  ]]
        then
            #get am or pm
            echo "Please designate AM or PM:"
            read DAY_OR_NIGHT
            while [[ ! $DAY_OR_NIGHT =~ ^[AaPp][Mm]$ ]]
            do
                echo "That is not a valid option. Please enter AM for a morning appointment or PM for an afternoon appointment:"
                read DAY_OR_NIGHT
            done
        fi
        if [[ -z $DAY_OR_NIGHT ]]
        then
            if [[ $APPOINTMENT_TIME =~ ([0-9]*:)?[0-9][Aa][Mm]$ ]]
            then
                DAY_OR_NIGHT='am'
                echo '$DAY_OR_NIGHT'
            elif [[ $APPOINTMENT_TIME =~ ([0-9]*:)?[0-9][Pp][Mm]$ ]]
            then
                DAY_OR_NIGHT='pm'
            else
                APPOINTMENT_MENU "There has been an error. Please start over."
            fi
        fi
        if [[ $APPOINTMENT_TIME =~ [0-9]+:[0-9]+[AaPp][Mm]$ ]]
        then 
            APPOINTMENT_TIME_FORMATTED=$(echo $APPOINTMENT_TIME | sed -r 's/[A-Za-z]+//g')
        elif [[ $APPOINTMENT_TIME =~ [0-9]+[AaPp][Mm]$ ]]
        then
            APPOINTMENT_TIME_FORMATTED=$(echo $APPOINTMENT_TIME | sed -r 's/[A-Za-z]+/:00/g')
        elif [[ $APPOINTMENT_TIME =~ [0-9]+$ ]]
        then
            APPOINTMENT_TIME_FORMATTED="${APPOINTMENT_TIME}:00"
        else
            APPOINTMENT_TIME_FORMATTED=$APPOINTMENT_TIME

        fi

        INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time, meridiem) VALUES($CUSTOMER_ID, $SERVICE_ID_TO_BOOK, '$APPOINTMENT_TIME_FORMATTED', '$DAY_OR_NIGHT');")
        if [[ $INSERT_APPOINTMENT_RESULT == 'INSERT 0 1' ]]
        then
            echo -e "I have put you down for a $CHOSEN_SERVICE_FORMATTED at $APPOINTMENT_TIME_FORMATTED$DAY_OR_NIGHT, $CUSTOMER_NAME_FORMATTED."
        else
            echo "nah bitch"
        fi

        
    fi
    EXIT
}

EXIT() {
    echo -e "\nThanks for stopping in!"
}


MAIN_MENU
