setClass(Class = "RNAi",

         representation = representation(genes = "factor",
                                         sequences = "factor",
                                         cancers = "character",
                                         cancersP53 = "character",
                                         values = "data.frame"),
         validity = function(object){
           if(length(object@genes) != nrow(object@values)) {
             cat("The number of rows in the FC matrix does not match the number of shRNAs.")
             stop

           } else if (length(object@cancersP53) != ncol(object@values)) {
             cat("The number of columns in the FC matrix does not match the number of cancers being studied.")
             stop

           } else if (length(object@cancers) != length(object@cancersP53)) {
             cat("The number of p53 allocations does not match the number of cancers being studied.")
             stop

           } else {
             return(TRUE)
           }
         }
)
