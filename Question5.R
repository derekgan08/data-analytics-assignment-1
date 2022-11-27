is_valid <- function(board, nrow, ncol, valid) {
  
  # Determine which 2*3 box
  box_x <- floor((nrow - 1) / 2) + 1
  box_y <- floor((ncol - 1) / 3) + 1
  
  # Create 2*3 matrix box from sudoku_matrix
  box <- board[(2 * box_x - 1):(2 * box_x), (3 * box_y - 2):(3 * box_y)]
  
  for(i in 1:6){
    # Check if any cell in the same row has value = i
    if(!(any(board[nrow, ] == i))){
      cat(i, "is missing from row: ", nrow, "\n")
      if(valid) {valid <- FALSE}
    }
    
    # Check if any cell in the same column has value = i
    if(!(any(board[, ncol] == i))){
      cat(i, "is missing from col: ", ncol, "\n")
      if(valid) {valid <- FALSE}
    }
    
    # Check if i appears elsewhere in its box
    if(!(any(box == i))){
      cat(i, "is missing from box: ", box_x, box_y, "\n")
      if(valid) {valid <- FALSE}
    }
  }
  
  return(valid)
}


valid <-TRUE
# Initialize a matrix of 6-row and 6-column, read csv in STATED LOCATION
sudoku_matrix <- as.matrix(read.csv("D:\\Download\\testSudoku.csv", header=FALSE))

# Print sudoku with 2*3 matrix
print(sudoku_matrix)

for(i in 1:6){
  valid <- is_valid(sudoku_matrix, i, i, valid)
}

# Check whether sudoku is feasible or infeasible
if(valid) print("Feasible Puzzle") else print("Infeasible Puzzle")
