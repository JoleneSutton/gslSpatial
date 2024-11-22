#' Manually format a prediction grid
#'
#' Returns a data frame
#' @importFrom stats sd
#' @param grid A prediction grid in which each row is unique
#' @param rep.var A variable by which to repeat the rows of the grid, e.g., year
#' @param depth.var If the grid needs a column for 'depth_scaled', depth.var is the depths used in the original scaling, e.g., from a data set fitted with a model
#' @param median.var If the grid needs a column with the most common level of a predictor, median.var comes from the original data that the model was fitted to
#' @seealso format_grid()
#' @examples
#' tmp<-pgrid4[1:3,]
#' set.seed(678)
#' mv<-sample(c('a','b'),3,replace=TRUE)
#' names(sort(table(mv),decreasing=TRUE)[1])
#' dv<-sample(100:500,50)
#' format_grid_manually(tmp,rep.var=c(2002,2003),median.var=mv,depth.var=dv)
#' @export
format_grid_manually<-function(grid, rep.var=NULL, depth.var=NULL, median.var=NULL){

  if(length(rep.var)>0){
    x<-rep.var
    var<-rep(unique(x),each=nrow(grid))
    grid<-grid[rep(seq_len(nrow(grid)), length(unique(x))), ]
    grid<-cbind(grid,var)
    names(grid)[ncol(grid)]<-'rep.var'
  }

  if(length(median.var)>0){
    x<-median.var
    x<-names(sort(table(x),decreasing=TRUE)[1])
    grid$median.var<-factor(x)
  }

  if(length(depth.var)>0){
    x<-depth.var
    grid$depth_scaled <- (grid$depth - mean(x) )/ sd(x)
  }

  return(grid)
}

