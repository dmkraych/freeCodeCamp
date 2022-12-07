#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=number_guess --tuples-only -c"

# echo $($PSQL "TRUNCATE users CASCADE;")

TO_GUESS=" $((1 + RANDOM % 1000 ))"
echo $TO_GUESS

echo "Enter your username:"
read USERNAME

# check user against sql
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME';")

# if username empty
if [[ -z $USER_ID ]]
then
  NEW=True
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  USERNAME_INSERT_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME');")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'";)
else
  # get data from guess_stats
  GUESS_STATS=$($PSQL "SELECT * FROM users FULL JOIN guess_stats USING(user_id) WHERE users.user_id=$USER_ID;")
  echo "$GUESS_STATS" | while read USER_ID BAR USERNAME BAR GAMES_PLAYED BAR BEST_GAME
  do
    echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
  done
fi
# prompt input
echo "Guess the secret number between 1 and 1000:"
read GUESS
# check input
COUNTER=1
while (( $GUESS != $TO_GUESS ))
do

# if not integer
  if ! [[ $GUESS =~ ^[0-9]+$ ]]
  then
    echo "That is not an integer, guess again:"
# elif guess greater
  elif (( $GUESS > $TO_GUESS ))
  then
    echo "It's lower than that, guess again:"
  # elif guess less
  elif (( $GUESS < $TO_GUESS ))
  then
    echo "It's higher than that, guess again:"
  fi
  read GUESS
  ((COUNTER++))
done

# check if user is new
if [[ $NEW == True ]]
then
  # insert user and stats into tables
  STATS_INSERTION_RESULT=$($PSQL "INSERT INTO guess_stats VALUES($USER_ID, 1, $COUNTER);")
else
  # update user stats in guess_stats table
  echo "$GUESS_STATS" | while read USER_ID BAR USERNAME BAR GAMES_PLAYED BAR BEST_GAME
  do
    GAMES_UPDATE_RESULT=$($PSQL "UPDATE guess_stats SET games_played=games_played + 1 WHERE user_id=$USER_ID;")
    # check whether best game and update if necessary
    if (( COUNTER < BEST_GAME ))
    then
      BEST_UPDATE_RESULT=$($PSQL "UPDATE guess_stats SET best_game=$COUNTER WHERE user_id=$USER_ID;")
    fi
  done
fi

# output win message
echo "You guessed it in $COUNTER tries. The secret number was $TO_GUESS. Nice job!"

