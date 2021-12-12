// Create a smart contract
contract Voting{

    // Store the addresses of contenders
    address address0 = ADDRESS_0;
    address address1 = ADDRESS_1;

    // Store the initial vote count of contenders
    uint256 person0 = 0;
    uint256 person1 = 0;

    // The total number of voters
    uint256 NO_OF_VOTERS = MAX_VOTERS;

    // Stores whether the voter has voted or not
    bool[] voted;

    // Mark that all the voters have not voted
    for (uint256 i = 0; i < NO_OF_VOTERS; i++){

        // Not voted
        voted.push(false);
    }

    // OPEN = 1, CLOSED = 2, FINISHED = 3
    // Only valid order is 1 -> 2 -> 3
    // Initially Voting is OPEN
    uint Votingstate = 1;

    // Function for voter to put his ballet
    function ballet(bool val, address voter){
        // Requirements

        // Voting must be OPEN to vote
        require Votingstate == 1;

        // Voter must have not have voted before (no revoting)
        // Case of the first and only vote
        require voted[voter] == false;

        // Vote is given to person1
        if (val){

            // Vote count of person1 is incremented
            person1++;
        }

        // Vote is given to person0
        else{

            // Vote count of person0 is incremented
            person0++;
        }

        // The voter has completed voting, cannot be allowed to revote
        voted[voter] = true;
    }

    // Announce the winner
    function winner(){

        // As the winner is being computed, we cannot consider more votes
        // Voting is CLOSED
        changestate(2);

        // Voting must be CLOSED to evaluate the winner
        require Votingstate == 2;

        // Person0 has more votes than Person1, he is declared the winner
        if (person0 > person1){

            // The winner is displayed
            return address0;
        }

        // Person1 has more votes than Person0, he is declared the winner
        if (person1 > person0){

            // The winner is displayed
            return address1;
        }

        // Since both the contenders have equal votes, the situation of tie arises
        if (person0 == person1){

            // Use a random function to select the address of the winning person among the 2
            // Random function gives an equal probability of 0.5 for both the contenders
            // Ensures a winner is declared in the tie situation
            return generaterandomamong(address0, address1);
        }

        // As the winner has been computed,
        // Voting is FINISHED
        changestate(3);
    }

    // Valid change of the Voting state
    function changestate(uint state){

        // Either we can move 1 -> 2 or 2 -> 3
        require (Votingstate == 1 && state == 2) ||
                (Votingstate == 2 && state == 3);

        // Change the current Voting state
        Votingstate = state;
    }
}