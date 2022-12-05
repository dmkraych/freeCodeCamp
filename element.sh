#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
FULL_JOIN="SELECT * FROM elements INNER JOIN properties ON elements.atomic_number=properties.atomic_number INNER JOIN types ON properties.type_id=types.type_id"

# Prompt user

if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  ELEMENT=$1


  # Check if response was a_number, name, or symbol
  if [[ $ELEMENT =~ ^[0-9]+$ ]]
  then
    # select element based on atomic number
    ELEMENT_FACTS=$($PSQL "$FULL_JOIN where elements.atomic_number='$ELEMENT';")
  elif [[ $ELEMENT =~ ^[A-Z]$ ]] || [[ $ELEMENT =~ ^[A-Z][a-z]$ ]]
  then
    # select element based on atomic symbol
    ELEMENT_FACTS=$($PSQL "$FULL_JOIN where symbol='$ELEMENT';")
  elif [[ $ELEMENT =~ ^[A-Za-z]+$ ]]
  then
    # select element based on name
    ELEMENT_FACTS=$($PSQL "$FULL_JOIN where elements.name='$ELEMENT';")
  fi

  # Check if input produced a result
  if [[ -z $ELEMENT_FACTS ]]
  then
    echo "I could not find that element in the database."
  else
    # Separate into variables and output final message
    echo "$ELEMENT_FACTS" | while read ATOMIC_NUMBER BAR SYMBOL BAR NAME BAR ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID BAR TYPE_ID BAR TYPE
    do
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    done
  fi
fi

