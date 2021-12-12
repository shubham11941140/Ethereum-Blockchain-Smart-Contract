// Create a smart contract
contract Tender{

    // Specified number of bidders
    uint256 NO_OF_BIDDERS = MAX_BIDDERS;

    // Infeasible large quotation to replace with smaller values
    uint256 MAX_VAL = 100000000000000000000000000000000;

    // OPEN = 1, CLOSED = 2, FINISHED = 3
    // Only valid order is 1 -> 2 -> 3
    // Initially Tender is OPEN
    uint Tenderstate = 1;

    // Stores the lowest quotation entered by an individual/organization
    uint256[] quote;

    // Mark that all the bidders have not put a quotation
    for (uint256 i = 0; i < NO_OF_BIDDERS; i++){

        // Infeasible large quotation which will be replaced with smaller values
        quote.push(MAX_VAL);
    }

    // Function for individual/organization/bidder to put his lowest quotation
    function bidding(uint256 quotation, address bidder){

        // Requirements

        // Tender be OPEN to submit lowest quotation
        require Tenderstate == 1;

        // Revised quotation must be lower than the previous
        // Initial quotation will always be accepted as quote[bidder] is set to INFINITE in the beginning
        // Any quotation will be less than INFINITE, so it will be accepted
        require quotation < quote[bidder];

        // Set/Revise the quotation of the bidder
        quote[bidder] = quotation;
    }

    // Announce the contract awardee
    function contract(){

        // As the contract awardee is being computed, we cannot consider more quotations
        // Tender is CLOSED
        changestate(2):

        // Tender must be CLOSED to evaluate the contract awardee
        require Tenderstate == 2;

        // Set the value of the lowest quotation to an infeasible large value
        // It will be replaced with smaller values
        uint256 lowest_quotation = MAX_VAL;

        // A simple loop to calculate the minimum value in a loop

        // Traverse through quotations of all the individuals/organizations
        for (uint256 i = 0; i < NO_OF_BIDDERS; i++){

            // Check if their quotations than the current lowest quotation
            if (quote[i] < lowest_quotation){

                // Replace the current lowest quotation with a lower quotation
                lowest_quotation = quote[i];
            }
        }

        // Since we have replaced the current lowest quotation with lower values, at the end
        // We have no value lower than this (otherwise it would have been replaced)
        // lowest_quotation contains the least quotation among all the bidders

        // To store the addresses of all the bidders who bid the lowest quotation
        address[] awardees;

        // Traverse through quotations of all the individuals/organizations
        for (uint256 i = 0; i < NO_OF_BIDDERS; i++){

            // The condition when the bidder bid the lowest quotation
            if (quote[i] == lowest_quotation){

                // Add to the list of lowest quotations
                awardees.push(i);
            }
        }

        // We have a list of all bidders who gave the lowest quotation value

        // Base case
        // If there is only a single bidder with lowest quotation
        if (awardees.length == 1){

            // Contract is awarded to that bidder
            uint256 tender_given = 0;
        }

        // Case where 2 or more bidders with the lowest quotation
        // We need to randomly generate the contract awardee among all possibilities
        // This gives an equal probability of awarding the contract for all the bidders
        // Ensures a contract is awarded is declared in this situation
        else{

            // Generate an integral random number using any function within the range
            uint256 tender_given = generaterandomnumber(0, awardees.length);

            // Verification within the indices
            require 0 <= tender_given <= awardees.length;
        }

        // Obtain the address of the contract awardee from index
        address contractor = awardees[tender_given];

        // Give the contract to the contract awardee
        // Payment of the contract money to the awardee
        payable(contractor.transfer(lowest_quotation));

        // Contract awardee is displayed
        return contractor;

        // As the contract awardee has been computed and the payment has been made
        // Contract Tender process is FINISHED
        changestate(3);
    }

    // Valid change of the Tender state
    function changestate(uint state){

        // Either we can move 1 -> 2 or 2 -> 3
        require (Tenderstate == 1 && state == 2) ||
                (Tenderstate == 2 && state == 3);

        // Change the current Tender state
        Tenderstate = state;
    }
}