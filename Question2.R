library(combinat)

# Function to find the tour length
find_tour_length <- function(tour){
  tour_length <- 0
  
  # Calculate tour length for 1st city to 10th city
  for(j in 2:10){
    tour_length <- tour_length + dist_matrix[tour[[1]][j-1], tour[[1]][j]]
  }
  
  # Calculate tour length for travelling from last city to starting city
  tour_length <- tour_length + dist_matrix[tour[[1]][10], tour[[1]][1]]
  
  # Return the tour length
  return(tour_length)
}

# Function to find shortest path for round trip travel using Brutal Force method
find_using_brutal_force_method <- function(tours) {
  
  # Store total number of all possible tours
  n <- length(tours)
  
  # Initialize the shortest path variable
  minimum_tour_brutal_force <- tours[1]
  minimum_tour_length_brutal_force <- find_tour_length(tours[1])
  tour_length <- find_tour_length(tours[1])
  
  # Loop for all possible permutations to find shortest path and length
  for(i in 1:n){
    
    # For each permutation find its tour length
    tour_length <- find_tour_length(tours[i])
    
    # Store the latest shortest tour discovered 
    if(tour_length <= minimum_tour_length_brutal_force){
      minimum_tour_brutal_force <- tours[i]
      minimum_tour_length_brutal_force <- tour_length
    }
    tour_length <- 0
  }
  
  # Go back to starting city
  minimum_tour_brutal_force[[1]] <- append(minimum_tour_brutal_force[[1]], minimum_tour_brutal_force[[1]][1])
  
  # Return shortest path and tour length
  return(c(minimum_tour_brutal_force, minimum_tour_length_brutal_force))
}

# Function to find nearest neighbor for a selected point(city)
find_nearest_neighbour <- function(point, tour){
  
  # Initialize nearest neighbor 
  nearest_point <- tour[1]
  distance <- 0.0
  shortest_distance <- dist_matrix[1, point]
  n <- length(tour)

  # Search for nearest neighbor from in available cities 
  for (i in 1:n){
    distance <- dist_matrix[tour[i], point]
    
    if(distance<shortest_distance){
      shortest_distance <- distance
      nearest_point <- tour[i]
      
    }else if(distance == shortest_distance){
      # If met a tie, break the tie using random rule
      nearest_point <- sample(c(nearest_point, tour[i]), 1)
    }
    
    distance <- 0.0
  }
  
  # Return nearest city
  return(nearest_point)
}

# Function to find shortest path for round trip travel using Heuristic method
find_using_heuristic_method <- function(){
  
  # Initialize variable to store shortest result
  minimum_tour_length_heuristic <- 100000
  minimum_tour_heuristic <- list()
  
  # Generate from 10 different cities
  for(starting_point in 1:10){
    
    # Generate list of not-visited cities
    next_available_city <- 1:10
    next_available_city <- next_available_city[! next_available_city %in% starting_point]
    visited_point <- c(starting_point)
    nearest_point <- starting_point[1]
    
    # Check for nearest city while still have un-visited city
    while(length(next_available_city) != 0){
      
      # Find nearest city and append to visited city
      nearest_point <- find_nearest_neighbour(nearest_point, next_available_city)
      visited_point <- append(visited_point, nearest_point)
      
      # Remove nearest city from available city
      next_available_city <- next_available_city[! next_available_city %in% nearest_point]
    }
    
    # Find total length for visited tour 
    visited_tour_length <- find_tour_length(list(visited_point))
    
    # Print every path and tour length
    cat("Path", starting_point, "searched using Heuristic Method: ", visited_point, starting_point, ", with tour length of: ", visited_tour_length, "\n")
    
    # Save shortest path
    if(visited_tour_length < minimum_tour_length_heuristic){
      minimum_tour_length_heuristic <- visited_tour_length
      minimum_tour_heuristic <- visited_point
    }
  }
  
  # Go back to starting city
  minimum_tour_heuristic <- append(minimum_tour_heuristic, minimum_tour_heuristic[1])
  
  # Return shortest path
  return(c(list(minimum_tour_heuristic), minimum_tour_length_heuristic))
}

# Generate data frame from 10 points
points <- data.frame(x=c(60, 180,  80, 140, 20, 100, 200, 140, 40, 100), y=c(200, 200, 180, 180, 160, 160, 160, 140, 120, 120))

# Generate distance matrix
dist_matrix <- as.matrix(dist(points))

# Print to user: 10 points and distance matrix
print(points)
print(dist_matrix)

# ----------------------------------------------------------------------
# USING BRUTAL FORCE METHOD

# Starting time for brutal force method
start_time_brutal_force_method <- Sys.time()

# Generate all permutations
tours <- permn(seq(1, 10))

# Print result of brutal force method
result_brutal_force_method = find_using_brutal_force_method(tours)

# Calculate elapsed time for brutal force method
end_time_brutal_force_method <- Sys.time()
elapsed_time_brutal_force_method = difftime(end_time_brutal_force_method, start_time_brutal_force_method, units = "secs")[[1]]

# ----------------------------------------------------------------------
# USING HEURISTIC METHOD

# Starting time for heuristic method
start_time_heuristic_method <- Sys.time()

# Print result of heuristic method
result_heuristic_method <- find_using_heuristic_method()

# Calculate elapsed time for heuristic method
end_time_heuristic_method <- Sys.time()
elapsed_time_heuristic_method = difftime(end_time_heuristic_method, start_time_heuristic_method, units = "secs")[[1]]

# ----------------------------------------------------------------------
# Analyzing Brutal Force Method and Heuristic Method
cat("Shortest path found using Brutal Force Method: ", result_brutal_force_method[[1]], ", with tour length of: ", result_brutal_force_method[[2]], "\n")
cat("Shortest path found using Heuristic Method: ", result_heuristic_method[[1]], ", with tour length of: ", result_heuristic_method[[2]], "\n")
cat("Elapsed Time for Brutal Force Method: ", elapsed_time_brutal_force_method, " seconds\nElapsed Time for Heuristic Method: ", elapsed_time_heuristic_method, " seconds\n")