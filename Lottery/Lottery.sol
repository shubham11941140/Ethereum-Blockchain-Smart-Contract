// Create a smart contract
contract Lottery{

    // Specified fee value
    uint FEES = OWNER_SPECIFIED_FEES;
    uint WIN_MONEY = OWNER_SPECIFIED_WINNING_FEES;

    // To store the winning index
    uint256 ans;

    // OPEN = 1, CLOSED = 2, FINISHED = 3, TERMINATED = 4
    // Only valid order is 1 -> 2 -> 3 -> 4
    // Initially Lottery is OPEN
    uint Lotterystate = 1;

    // Contains an array pair, number and user address
    store = [];

    // Function to give ticket to user
    function ticket(uint fees, uint256 num, address user){

        // Requirements

        // Lottery must be OPEN to give tickets
        require Lotterystate == 1;

        // The user must pay the full fees
        require fees == FEES;

        // The input number must be valid
        require num NOT present in the first value of pairs in store array;

        // Give ticket
        store.push((num, user));

        // Payment
        payable(owner().transfer(fees));
    }

    // Get the winner evaluation
    function evaluation(){

        // As the evaluation has started, no more tickets can be given
        // Lottery is CLOSED
        changestate(2);

        // Lottery must be CLOSED to evaluate the winner
        require Lotterystate == 2;

        // Generate an integral random number using any function within the range
        ans = generaterandomnumber(0, store.length);

        // Verification within the indices
        require 0 <= ans <= store.length;

        // As the index for the winner has been computed,
        // lottery is FINISHED
        changestate(3);
    }

    // Pay the money to the winner
    function winner(uint256 ans){

        // Lottery must be FINISHED to pay the winner
        require Lotterystate == 3;

        // Obtain the winner from index
        num, user = store[ans];

        // Payment to the winner
        payable(user.transfer(WIN_MONEY));

        // Winner is displayed
        return user;

        // As the winner has been announced,
        // lottery is TERMINATED
        changestate(4);
    }

    // Valid change of the Lottery state
    function changestate(uint state){

        // Either we can move 1 -> 2 or 2 -> 3 or 3 -> 4
        require (Lotterystate == 1 && state == 2) ||
                (Lotterystate == 2 && state == 3) ||
                (Lotterystate == 3 && state == 4);

        // Change the current Lottery state
        Lotterystate = state;
    }
}