## Programming assignment 2 - Lexical Scoping

## makeCacheMatrix function ---------------------------------------------------

## This function creates a special "matrix" object that can cache its inverse.

## This "matrix" is a list containing a function to:

## 1. set the value of the matrix.
## 2. get the value of the matrix.
## 3. set the value of the inverse matrix.
## 4. get the value of the inverse matrix.


makeCacheMatrix <- function(x = matrix(rnorm(4),2,2)) {
        s <- NULL
        set <- function(y) {
                x <<- y
                s <<- NULL
        }
        get <- function() x
        setsolve <- function(solve) s <<- solve
        getsolve <- function() s
        list(set = set, get = get,
             setsolve = setsolve,
             getsolve = getsolve)
}

## cacheSolve funtion --------------------------------------------------------

##  This function computes the inverse of the special "matrix" returned by 
## makeCacheMatrix above. If the inverse has already been calculated (and the
## matrix has not changed), then the cachesolve should retrieve the inverse 
## from the cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        s <- x$getsolve()
        if(!is.null(s)) {
                message("getting inverse matrix")
                return(s)
        }
        data <- x$get()
        s <- solve(data, ...)
        x$setsolve(s)
        s
}

## Example ------------------------------------------------------------------

m <- matrix(rnorm(16),4,4)
m1 <- makeCacheMatrix(m)
cacheSolve(m1)

## For this assignment i read the code of the examples, it was difficult to
## understand at the first time. Later, i changed the m value by s (solve) and 
## the mean function by the solve function (including their references along
## the function).  

