# CPC351 Assignment 1: Principles of Data Analytics Assignment 1

This repository contains the solutions to CPC351 - Principles of Data Analytics course Assignment 1. This assignment consists of 5 distinct questions, each focusing on different aspects of R programming and data analysis techniques.

## Table of Contents 

1. [Question 1: Malaysian Identity Card Number Analysis](#toc1)
2. [Question 2: Solving the Traveling Salesman Problem (TSP) Using Brute-Force and Heuristic Methods](#toc2)
3. [Question 3: Calculation of Surface Area and Volume for Geometric Shapes](#toc3)
4. [Question 4: Splitting and Combining Large Dataset in R](#toc4)
5. [Question 5: 6×6 Sudoku Puzzle Validator in R](#toc5)

## Question 1: Malaysian Identity Card Number Analysis<a name="toc1"></a>
### Description
In this question, I was tasked with writing an R function to analyze Malaysian identity card numbers. Specifically, the solution required reading a set of identity card numbers, determining the date of birth, and identifying the place of birth for each individual based on their card number. The solution involves working with two external datasets—![PB_IN.txt](PB_IN.txt) and ![PB_OUT.txt](PB_OUT.txt)—that contain state codes and corresponding state names, which are used to identify the place of birth. The process includes validating input, extracting the birth date, and matching the state code from the card number to the state name.

### Key R Functions Used

- `read.table()`: Used for reading external text files into R.
- `substr()`: Extracts substrings from a given string, used to isolate birth date and place code from the identity card number.
- `as.numeric()`, `as.character()`: For type conversion when working with data.
- `grepl()`: Utilized for pattern matching to validate inputs.
- `which()`: Searches for the index of the state code within the dataset.
- `paste()`: Used for combining date components and forming the output strings.
- `select()`, `rbind()`, `cbind()`: Employed for manipulating and organizing the data into a coherent format.

### Explanation

The solution first loads the necessary datasets (![PB_IN.txt](PB_IN.txt) and ![PB_OUT.txt](PB_OUT.txt)) into a dataframe for easy access to state codes and their corresponding names. The function then prompts the user to input Malaysian identity card numbers in a specific format. Each identity card number contains a date of birth (YYMMDD), a place of birth code (PB), and a four-digit unique identifier.

The logic behind this solution is to extract the year, month, and day of birth from the first six digits, and append the correct century to the year based on the current year. The state code (7th and 8th digits) is then used to retrieve the place of birth from the pre-loaded state dataset. Input validation is applied to ensure that the birth date is realistic (e.g., ensuring correct day ranges for different months, and accounting for leap years). If the state code is valid, the corresponding state name is displayed; otherwise, a message is shown indicating an invalid or unidentified place of birth.

### Screenshots

1. **State Code and State Name Part 1:**
    <p align="center">
    <img src="readme-assets/01 State Code and State Name Part 1.png" alt="state code and state name part 1"/>
    <br/>
    <i>Figure 1: State Code and State Name Part 1</i>
    </p>

2. **State Code and State Name Part 2:**
    <p align="center">
    <img src="readme-assets/02 State Code and State Name Part 2.png" alt="state code and state name part 2"/>
    <br/>
    <i>Figure 2: State Code and State Name Part 2</i>
    </p>

3. **State Code and State Name Part 3:**
    <p align="center">
    <img src="readme-assets/03 State Code and State Name Part 3.png" alt="state code and state name part 3"/>
    <br/>
    <i>Figure 3: State Code and State Name Part 3</i>
    </p>

4. **State Code and State Name Part 4:**
    <p align="center">
    <img src="readme-assets/04 State Code and State Name Part 4.png" alt="state code and state name part 4"/>
    <br/>
    <i>Figure 4: State Code and State Name Part 4</i>
    </p>

5. **Consolidated State Code and State Name:**
    <p align="center">
    <img src="readme-assets/05 Consolidated State Code and State Name.png" alt="consolidated state code and state name"/>
    <br/>
    <i>Figure 5: Consolidated State Code and State Name</i>
    </p>

6. **Input Validation:**
    <p align="center">
    <img src="readme-assets/06 Input Validation.png" alt="input validation"/>
    <br/>
    <i>Figure 6: Input Validation</i>
    </p>

    In the Figure 6, input validation (from the first until the last one) is done correctly according to the sequence below:
    - Reject the input if it is not exactly 12 digits
    - Reject the input if it contains any invalid characters including dash
    - Reject the input if the month is less than 1
    - Reject the input if the month is more than 12.
    - Reject the input if the day is less than 1
    - Reject the input if the day is more than 31 on January, March, May, July, August, October and December
    - Reject the input if the day is more than 30 on April, June, September and November
    - Reject the input if the day is more than 29 on February of a leap year
    - Reject the input if the day is more than 28 on February of an ordinary year

7. **Sample Input and Output:**
    <p align="center">
    <img src="readme-assets/07 Sample Input and Output.png" alt="sample input and output"/>
    <br/>
    <i>Figure 7: Sample Input and Output</i>
    </p>


## Question 2: Solving the Traveling Salesman Problem (TSP) Using Brute-Force and Heuristic Methods<a name="toc2"></a>
### Description
In this question, I was tasked with solving the Traveling Salesman Problem (TSP) for a set of 10 points on a Cartesian plane. Ahmad has planned a round trip that starts and ends at the same point while visiting each point exactly once. The solution involves two different approaches: a brute-force approach and a heuristic (nearest neighbor) approach.

1. **Brute-Force Approach:** This method calculates all possible permutations of the cities, computes the length of each possible round trip, and selects the one with the minimum length.

2. **Heuristic Approach:** This method starts at a randomly chosen point, then iteratively chooses the nearest unvisited city until all cities are visited. In case of a tie (same distance to multiple cities), a random rule is used to break the tie.

I implemented both methods in R, measured the computational time for each approach, and analyzed the results.

### Key R Functions Used
- `combinat::permn():` Generates all permutations of the cities for the brute-force method.
- `dist():` Calculates the Euclidean distance between two points.
- `Sys.time():` Used to track the start and end time of each approach for performance analysis.
- `sample():` Used for random selection in case of ties in the nearest neighbor heuristic.
- `cat():` Outputs results to the console, including the shortest paths and the time taken for each method.

### Explanation
The goal of this question was to compare two approaches to solving the Traveling Salesman Problem:

1. **Brute-Force Method:**
- First, I generate all possible permutations of the 10 cities.
- I then calculate the total tour length for each permutation by summing the distances between consecutive cities.
- Finally, I identify the permutation with the minimum total distance.

2. **Heuristic Method:**
- I start at a random city and iteratively select the nearest unvisited city to the current city, updating the visited cities list at each step.
- If two cities are at the same distance, I break the tie randomly.
- Once all cities are visited, I calculate the total length of the round trip, and repeat the process for all possible starting points.

After implementing both methods, I measured the time taken by each approach and compared the results in terms of the shortest round-trip length and computational efficiency. This allowed me to assess the trade-offs between the two approaches in terms of accuracy and performance.

**Distance Between Points:**
    <p align="center">
    <img src="readme-assets/08 Distance Between Points.png" alt="distance between points"/>
    <br/>
    <i>Figure 8: Distance Between Points</i>
    </p>

**Execution Time Interval Between the 2 Methods:**
    <p align="center">
    <img src="readme-assets/09 Execution Time Interval Between the 2 Methods.png" alt="execution time interval between the 2 methods"/>
    <br/>
    <i>Figure 9: Execution Time Interval Between the 2 Methods</i>
    </p>

The elapsed time for Brutal force method is much longer than Heuristic method (≈173019% longer than Heuristic method). But the tour calculated by using Brutal force method is smaller than Heuristic method (which is the optimum solution). 

### Discussion
Although the Brutal Force method take much longer time compared to Heuristic method to calculate the tour with the shortest tour length, but it is guaranteed to have the smallest and correct output. But when the number of input increases linearly, the number of permutations increases exponentially. Thus, Brutal Force is not encouraged when number of inputs is large. On the other hand, although Heuristic method take very fast time to calculate the tour with, but the result is not always the optimum or smallest tour length, because it does not foresee in the future tour length. We could use other algorithm, that can use shortest time to calculate the most optimum result, for example Dijkstra Algorithm. 


## Question 3: Calculation of Surface Area and Volume for Geometric Shapes<a name="toc3"></a>
### Description
In this question, I was tasked with constructing a set of user-defined functions in R to calculate the total surface area and volume of various geometric shapes, including a cuboid, cube, right circular cylinder, right circular cone, sphere, and hemisphere.

The solution involves defining six functions, one for each shape, that take the necessary parameters as inputs and return both the surface area and the volume of the shape. The formulas used for the calculations are standard geometric formulas, and each function outputs the results as a list containing the surface area and volume.

### Key R Functions Used
- `list():` Used to return the surface area and volume as a list.
- `pi:` The constant π, used in calculations for circles, spheres, and cylinders.

### Explanation
The goal of this question was to define functions that compute the surface area and volume for a variety of common geometric shapes. Below is a breakdown of the functions I implemented:

1. **Cuboid** (`cuboid`):
- Takes three parameters: length (`l`), width (`w`), and height (`h`).
- Surface area is calculated as **2*lw* + 2*lh* + 2*wh***, and volume is calculated as **_l_ × _w_ × _h_**.

2. **Cube** (`cube`):
- Takes one parameter: the side length (`a`).
- Surface area is calculated as **6*a*²**, and volume is calculated as ***a*³**.

3. **Right Circular Cylinder** (`cir_cylinder`):
- Takes two parameters: radius (`r`) and height (`h`).
- Surface area is calculated as **2*πr*² + 2*πrh***, and volume is calculated as ***πr*²*h***.

4. **Right Circular Cone** (`cir_cone`):
- Takes three parameters: radius (`r`), slant height (`s`), and height (`h`).
- Surface area is calculated as ***πrs* + *πr*²**, and volume is calculated as **⅓*πr*²*h***.

5. **Sphere** (`sphere`):
- Takes one parameter: radius (`r`).
- Surface area is calculated as **4*πr*²**, and volume is calculated as **4×⅓*πr*³**.

6. **Hemisphere** (`hemi_sphere`):
- Takes one parameter: radius (`r`).
- Surface area is calculated as **3*πr*²**, and volume is calculated as **⅔*πr*³**.

Each function returns a list containing both the surface area and volume, providing an efficient way to retrieve the results of the calculations.

### Screenshots

**Input and Output for Different Geometric Shape:**
<p align="center">
<img src="readme-assets/10 Input and Output for Different Geometric Shape.png" alt="input and output for different geometric shape"/>
<br/>
<i>Figure 10: Input and Output for Different Geometric Shape</i>
</p>

## Question 4: Splitting and Combining Large Dataset in R<a name="toc4"></a>
### Description
For this question, I was tasked with handling a large dataset containing 1,015,341 rows and 110 columns. The dataset was stored in a file named `data-final.txt`, and I needed to split it into 44 smaller text files, each containing a specific subset of the original data. After splitting the dataset, I was also required to import these text files back into R and combine them into a single data frame.

#### The solution involves:

1. **Splitting** the original dataset into multiple smaller files based on rows and columns.
2. **Reading** these smaller text files back into R.
3. **Combining** the imported files into a single large data frame.

The overall goal was to handle large datasets efficiently in R by breaking them into manageable chunks and later reassembling them into a unified structure.

### Key R Functions Used
- `read.table()`: Used to read in data from the text files, both for the initial split and later when importing the smaller files back into R.
- `write.table()`: Used for writing the split data into separate text files.
- `select()` (from the `dplyr` package): Used to select specific columns from the dataset when splitting it.
- `cbind()`: Used to combine the data horizontally when combining the smaller text files into a single data frame.
- `rbind()`: Used to combine data frames vertically when assembling the final data frame from the split text files.

### Explanation
**Step-by-Step Logic:**

1. **Data Splitting:**
- First, I read the input dataset `data-final.txt` into R.
- Then, I split the data into smaller chunks based on a pre-defined number of rows (250,000) and columns (10). This was done by iterating over the rows and columns of the original data and writing them into separate text files, named `PT_01.txt`, `PT_02.txt`, and so on.

2. **Recombining Data:**
- After splitting the dataset, I imported the smaller text files back into R.
- I started by reading the first two text files and binding them horizontally using `cbind()`.
- Then, I continued reading the subsequent files and used `cbind()` to combine them into a single data frame, ensuring that the data was correctly aligned by columns.
- Finally, I used `rbind()` to vertically stack all the rows into one final data frame, `complete`.

This approach helped me to efficiently handle the large dataset by splitting it into smaller, more manageable parts and then recombining them. It is an effective way to work with large datasets in R, especially when dealing with memory constraints.

## Question 5: 6×6 Sudoku Puzzle Validator in R<a name="toc5"></a>
### Description
For this question, I was tasked with creating a solution to validate a 6×6 Sudoku puzzle using R. The puzzle is represented by a 6×6 matrix, where each number from 1 to 6 must appear only once in each row, each column, and each 2×3 block. I needed to write a program that reads an input Sudoku grid from a file, checks for rule violations, and determines if the puzzle is feasible or infeasible.
**The solution involves:**
1. **Reading an input file** containing a 6×6 Sudoku puzzle.
2. **Validating the puzzle** by checking if each number from 1 to 6 appears exactly once in each row, column, and 2×3 block.
3. **Identifying and explaining violations** if any of the Sudoku rules are violated.
4. **Determining** whether the Sudoku puzzle is feasible or infeasible based on the validation results.

### Key R Functions Used
- `read.csv()`: Used to read the input file ![testSudoku.csv](testSudoku.csv), which contains the Sudoku grid, and convert it into a matrix.
- `as.matrix()`: Converts the data read from the file into a matrix format for easier manipulation and validation.
- `any()`: Checks whether a specific value exists in a row, column, or 2×3 box to verify if the Sudoku rule is violated.
- `floor()`: Calculates the appropriate block position (2×3) of the Sudoku grid by converting the row and column indices.
- `cat()`: Used for printing descriptive messages about any rule violations found during validation.

### Explanation
The logic behind the solution revolves around breaking down the 6×6 Sudoku grid into its fundamental validation components: rows, columns, and 2×3 blocks.

1. **Validation Function:** The function `is_valid()` performs the core validation by checking if:
- Each number from 1 to 6 appears at least once in the specified row.
- Each number from 1 to 6 appears at least once in the specified column.
- Each number from 1 to 6 appears at least once in its corresponding 2×3 block.

2. **2×3 Block Calculation:** For each row and column, the function calculates the 2×3 block using `floor()` to find the correct block coordinates, then extracts the corresponding block from the Sudoku grid.

3. **Violation Reporting:** If any number is missing from a row, column, or block, the program prints the violation with a descriptive message indicating the missing number and its position.

4. **Feasibility Check:** If all the validation checks pass without any violations, the program will print "Feasible Puzzle." Otherwise, it will print "Infeasible Puzzle" along with the details of the violations.

By following this approach, the program ensures that the Sudoku puzzle adheres to all the required rules and provides clear feedback for rule violations.

### Results
**Sudoku Output:**
    <p align="center">
    <img src="readme-assets/11 Sudoku Output.png" alt="sudoku output"/>
    <br/>
    <i>Figure 11: Sudoku Output</i>
    </p>

The program finally finds out 6 and 2 is missing from column 1 and 2 respectively. Hence, this sudoku is infeasible.