# To turn off warnings:
options(warn=-1)

### Part 1: Load "PB_IN.txt" and "PB_OUT.txt" into dataframe ###

# Import necessary library
library("dplyr")

# Create a vector to read all the input files ('PB_IN.txt' & 'PB_OUT.txt')
files <- c('PB_IN.txt', 'PB_OUT.txt')

# Create a dataframe "complete" to store all the State Code and State Name
complete = data.frame()

# Create for loop to read all the input files
for(i in 1:length(files)){
    # Store the inputFile name into the variable
    inputFile <- files[i]

    # Count how many lines in the input file
    nRow <- length(readLines(inputFile, warn = FALSE))

    # Read and process the input file line by line
    for(skipRow in 0:(nRow - 1)){
        
        # Read all the elements in the first row and put into dataframe "dataRow1"
        dataRow1 <- read.table(inputFile, header = F, fill = TRUE,
                               sep = ' ', quote="", nrows = 1, skip = skipRow)

        # Concatenate the State Name (if more than one word) 
        # into one word by reading the last word (element):
        lastCol <- ncol(dataRow1)
        columnStateName <- select(dataRow1, lastCol)

        # Counter is used to locate which column to read next
        lastCol = lastCol - 1
        # reading the second last element
        dataAdjacentLastColumn <- select(dataRow1, lastCol)

        # Check if the State Name is more than one word by checking the second
        # last element (dataAdjacentLastColumn) whether it is a numeric or character.
        # If it is not numeric, that means it is another word in State Name,
        # so concatenate the word:
        # However, it if it is a numeric, then we need to check whether the numeric has how many characters,
        # If it is not 2 characters, that means it is not a State Code, so concatenate the word:
        while(mode(unlist(dataAdjacentLastColumn)) != "numeric" || 
        ((mode(unlist(dataAdjacentLastColumn)) == "numeric") && (nchar(dataAdjacentLastColumn) != 2))){
            # "unlist()" is used to unlist the list
            # and then, concatenate both words:
            columnStateName <- data.frame(paste(unlist(dataAdjacentLastColumn), unlist(columnStateName),sep=" "))
            colnames(columnStateName) <- ("State Name")
            # and then you need to check whether the element before the word it is still a word or not
            # aka to check whether the State Name has more than 2 words:
            lastCol = lastCol - 1

            dataAdjacentLastColumn <- select(dataRow1, lastCol)
            # If the State Name has more than 2 words, then repeat this loop again to 
            #   concatenate the words into a single element until no more words is detected
        }

        ## Now, we will append the State Name adjacent to the State Code ##
        
        # Read the State Code from the data frame
        columnStateCode <- select(dataRow1, lastCol)

        # Bind the State Name adjacent to State Code in the same row using cbind()
        completeRow <- cbind(columnStateCode, columnStateName)
        # Rename the Column Name of the dataframe
        colnames(completeRow) <- c("State Code", "State Name")

        # Bind the row just now to dataframe "complete" vertically
        complete <- rbind(complete, completeRow)
        # Rename the columns in the dataframe "complete"
        colnames(complete) <- c("State Code", "State Name")

        lastCol = lastCol - 1

        # If the last column is 0, we can repeat this loop again to process the next row from input file.
        # Else, we will append all the State Code to the State Name for every State Code instance
        if(lastCol <= 0){
            
        } else{
            # Select the State Code and put into dataframe
            dataAdjacentLastColumn <- select(dataRow1, lastCol)
            lastCol = lastCol - 1

            
            # Repeat this loop if the State has more than one State Code:
            while(mode(unlist(dataAdjacentLastColumn)) == "numeric"){
                # Bind the State Code with State Name using cbind()
                newRow <- cbind(dataAdjacentLastColumn, columnStateName)
                # Rename the columns of this dataframe
                colnames(newRow) <- c("State Code", "State Name")
                # Bind the dataframe just now with the dataframe "complete" using rbind()
                complete <- rbind(newRow, complete)
                # Read the previous column again to check if it has another State Code or not
                dataAdjacentLastColumn <- select(dataRow1, lastCol)
                # counter is used to read the previous column
                lastCol = lastCol - 1
            }    
        }
    }
}





### Part 2: Prompt the User for IC Number and Determine the Date and Place of Birth ###

analyseICNumber <- function(){
    for(i in 1:5){
        ICNumber <- as.character(readline(prompt = "Please enter the IC Number (without '-'): "))

        # Input Validation
        repeat{
            # Count the number of digits of the input IC and reject if not 12 digits and
            #   reject the input if contains any invalid characters

            # Create a function with regex to determine whether the input are all numbers or not
            numbers_only <- function(x) !grepl("\\D", x)        

            while ((nchar(ICNumber) != 12) || (!numbers_only(ICNumber))){
                ICNumber <- as.character(readline(prompt = "Error! IC number must be exactly 12 digits. Please reinput the IC Number: "))
            }
            
            # Get the number for Year, Month and Day of Birth
            year <- as.character(substr(ICNumber, 1, 2))
            month <- as.numeric(substr(ICNumber, 3, 4))
            day <- as.numeric(substr(ICNumber, 5, 6))

            # Append leading 2 digit number to the current Year (e.g. 99 → 1999; 00 → 2000)
            currentYear <- format(Sys.Date(), "%Y")
            currentYearLastTwoDigit <- as.character(substr(currentYear, 3, 4))
            
            if(year > currentYearLastTwoDigit){
                # That means the person is born in between year 1923 and 1999.
                # So, append "19" in front of the year
                
                # Get the first two digit of current year
                currentYearFirstTwoDigit <- as.integer(substr(currentYear, 1, 2))
                # Minus 1 and then append the first two digit of current year to 
                # the last two digit of the born year of the IC while removing white space
                year <- gsub(" ", "", paste(currentYearFirstTwoDigit - 1, year))
            } else {
                # The person is born in between year 2000 and 2022
                # So, append "20" in front of the year
                
                # Get the first two digit of current year
                currentYearFirstTwoDigit <- as.character(substr(currentYear, 1, 2))
                # Append the first two digit of current year to 
                # the last two digit of the born year of the IC while removing white space
                year <- gsub(" ", "", paste(currentYearFirstTwoDigit, year))
            }

            # Check if the Date is valid or not. Reject if not valid
            if(month < 1){
                ICNumber <- as.character(readline(prompt = "Error! The month of birth cannot be less than 1. Please reinput the IC Number: "))
            } else if(month > 12){
                ICNumber <- as.character(readline(prompt = "Error! The month of birth cannot be more than 12. Please reinput the IC Number: "))
            } else if(day < 1){
                ICNumber <- as.character(readline(prompt = "Error! The day of birth cannot be less than 1. Please reinput the IC Number: "))
            } else if((month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) && (day > 31)){
                ICNumber <- as.character(readline(prompt = "Error! The day of birth cannot be more than 31. Please reinput the IC Number: "))
            } else if((month == 4 || month == 6 || month == 9 || month == 11) && (day > 30)){
                ICNumber <- as.character(readline(prompt = "Error! The day of birth cannot be more than 30. Please reinput the IC Number: "))
            } else if(month == 2 && (as.numeric(year) %% 4 == 0) && day > 29){
                ICNumber <- as.character(readline(prompt = "Error! The day of birth cannot be more than 29. Please reinput the IC Number: "))
            } else if(month == 2 && (as.numeric(year) %% 4 != 0) && day > 28){
                ICNumber <- as.character(readline(prompt = "Error! The day of birth cannot be more than 28. Please reinput the IC Number: "))
            } else{
                break
            }
        }
        
        # Concatenate the Day, Month and Year of Birth together while removing white space:
        # DateofBirth <- gsub(" ", "", paste(day,"/", month,"/", year))
        DateofBirth <- paste(day, month.name[month], year)
        # Print the date of Birth
        print(paste("Date of Birth is:", DateofBirth))

        # Get the code for Place of Birth
        place <- as.numeric(substr(ICNumber, 7, 8))
        # Search the State Code in the dataframe "complete"
        stateCode <- which(complete$`State Code` == place)
        
        if(any(complete==place)){
            # If the State Code found from the datafram (means it is not unknown)
            # Print the place of Birth
            print(paste("Place of Birth is:", complete[stateCode, 2]))
        } else{
            print("The place of birth is unidentified. Please ensure you did not type wrongly the IC number.")
        }
    }
}

# Call the function
analyseICNumber()