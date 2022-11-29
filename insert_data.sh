#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS

# Populate teams table
do
    # Skip header line
    if [[ $WINNER != 'winner' ]]
    then
    # Get team (country) name
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # Check if WINNER_ID is empty
        if [[ -z $WINNER_ID ]]
        then
            # Insert winner
            INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
            if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
            then
                echo Inserted into teams, $WINNER
            fi
        fi
        # Check if OPP_ID is empty
        if [[ -z $OPP_ID ]]
        then
            # Insert OPPONENT
            INSERT_OPP_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
            if [[ $INSERT_OPP_RESULT == "INSERT 0 1" ]]
            then
                echo Inserted into teams, $OPPONENT
            fi
        fi
        
        WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        OPP_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")


        INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPP_ID, $WINNER_GOALS, $OPPONENT_GOALS);")
        echo $INSERT_GAME_RESULT
    fi
done


