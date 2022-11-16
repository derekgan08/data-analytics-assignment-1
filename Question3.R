#Function to calculate total surface area and volume of cuboid
cuboid <- function(l,w,h) {
  surface_area <- (2*l*w) + (2*l*h) + (2*w*h)
  volume <- l*w*h
  
  value <- list(surface_area, volume)
  return(value)
}

#Function to calculate total surface area and volume of cube
cube <- function(a) {
  surface_area <- 6*a*a
  volume <- a*a*a
  
  value <- list(surface_area, volume)
  return(value)
}

#Function to calculate total surface area and volume of right circular cylinder
cir_cylinder <- function(r,h) {
  surface_area <- (2*pi*r*r) + (2*pi*r*h)
  volume <- pi*r*r*h
  
  value <- list(surface_area, volume)
  return(value)
}

#Function to calculate total surface area and volume of right circular cone
cir_cone <- function(s,h,r) {
  surface_area <- (pi*r*s) + (pi*r*r)
  volume <- (pi*r*r*h) / 3
  
  value <- list(surface_area, volume)
  return(value)
}

#Function to calculate total surface area and volume of sphere
sphere <- function(r) {
  surface_area <- 4*pi*r*r
  volume <- (4/3)*(pi*r*r*r)
  
  value <- list(surface_area, volume)
  return(value)
}

#Function to calculate total surface area and volume of hemi-sphere
hemi_sphere <- function(r) {
  surface_area <- (3*pi*r*r)
  volume <- (2/3)*(pi*r*r*r)
  
  value <- list(surface_area, volume)
  return(value)
}