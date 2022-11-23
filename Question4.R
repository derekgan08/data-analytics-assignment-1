# To turn off warnings:
options(warn=-1)

# Import necessary libraries
library(plyr)
library(dplyr)

# Set the working directory
# setwd("C:/Users/Derek/Documents/CPC351_CPM351_Group33_ A01")

# Read the input file
inputFile <- 'data-final.txt'
data <- read.table(inputFile, header=T, fill=TRUE, sep='\t')

# Declaring the variables
index <- 1
totalRows <- nrow(data)
totalCols <- ncol(data)
splitRow <- 250000
splitCol <- 10
skipRow <- 0

##### Part 1: Split the Original Dataset into 44 txt files #####
repeat{
  
  # read 250000 rows from input file.
  dataRow <- read.table(inputFile, header=TRUE, fill = TRUE, sep='\t', 
                        nrows = splitRow, skip = skipRow)
  
  skipCol <- 0
  
  # read 10 columns from the 250000 rows
  repeat{
    lastColumnToRead = skipCol + splitCol
    if((lastColumnToRead) < totalCols){
      # Read for 10 columns
      dataChunk <- select(dataRow, ((skipCol + 1):(lastColumnToRead)))
    } else{
      # Read until the last column
      dataChunk <- select(dataRow, ((skipCol + 1):totalCols))
    }
    
    # Write to txt file
    write.table(dataChunk, file = paste0("PT_",sprintf('%02d', index),".txt"),
                row.names = FALSE, col.names = FALSE, quote=FALSE, sep = '\t')
    
    # Increase the counter
    skipCol = skipCol + ncol(dataChunk)
    
    # check if the input file has reached the last column and break from repeat
    if(skipCol >= totalCols){
      break
    }
    
    # increment the file index to write to the next txt file (part)
    index = index+1
  }
  
  # check if has reached the last row of the chunk and break from repeat
  skipRow = skipRow + nrow(dataChunk)

  if(skipRow >= totalRows){
    break
  } else if((totalRows - skipRow) < (splitRow*2)){
    splitRow = totalRows - skipRow
  }
  
  # increment the file index to write to the next txt file (part)
  index = index + 1
}


###### Part 2: Import all the txt file and combine into a single dataframe. #####

## bind dataframe horizontally in the initial row ##
index <- 1

# to create a dataframe and bind the first two chunks #
readFile <- paste0("PT_",sprintf('%02d', index),".txt")
initialRowInitialColumn <- read.table(readFile, header=FALSE, fill=TRUE, sep='\t')

index = index + 1

readFile <- paste0("PT_",sprintf('%02d', index),".txt")
initialRowCurrentColumn <- read.table(readFile, header=FALSE, fill=TRUE, sep='\t')

# bind the first two chunks (part) horizontally using cbind()
complete <- cbind(initialRowInitialColumn,initialRowCurrentColumn)

index = index + 1

# repeat loop to bind the rest of the chunks across the row #
repeat{
  readFile <- paste0("PT_",sprintf('%02d', index),".txt")
  initialRowCurrentColumn <- read.table(readFile, header=FALSE, fill=TRUE, sep='\t')
  
  complete <- cbind(complete, initialRowCurrentColumn)

  # increase the index to read next txt file
  index = index + 1
  
  # check if the data frame has reached the last column and break from repeat
  if(ncol(complete) >= totalCols){
    break
  }
}

repeat{
    ## bind dataframe horizontally in the next row ##
    # to create a dataframe and bind the first two chunks #

    readFile <- paste0("PT_",sprintf('%02d', index),".txt")
    if(file.exists(readFile)){
      currentRowInitialColumn <- read.table(readFile, header=FALSE, fill=TRUE, sep='\t')
  
      index = index + 1
  
      readFile <- paste0("PT_",sprintf('%02d', index),".txt")
      currentRowCurrentColumn <- read.table(readFile, header=FALSE, fill=TRUE, sep='\t')
  
      currentRowBindColumn <- cbind(currentRowInitialColumn,currentRowCurrentColumn)
  
      index = index + 1
  
      # repeat loop to bind the rest of the chunks across the row #
      repeat{
          readFile <- paste0("PT_",sprintf('%02d', index),".txt")
          currentRowCurrentColumn <- read.table(readFile, header=FALSE, fill=TRUE, sep='\t')
  
          currentRowBindColumn <- cbind(currentRowBindColumn, currentRowCurrentColumn)
  
          # increase the index to read next txt file
          index = index + 1
  
          #check if file end has been reached and break from repeat
          if(ncol(currentRowBindColumn) >= totalCols){
              break
          }
      }
  
      ## To bind previous row and current row ##
      complete <- rbind(complete, currentRowBindColumn)
  
      # check if file end has been reached and break from repeat
      if(nrow(complete) >= totalRows){
          break
      }
    }else{
      break
    }
}

# Rename the column names of dataframe "complete"
colnames(complete) <- colnames(data)