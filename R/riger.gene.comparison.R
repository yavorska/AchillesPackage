setMethod(f = "riger.gene.comparison",
          signature = "data.frame",
          definition = function(object, geneName, entityName = "all"){

            index <- grep(entityName, colnames(object), ignore.case = T)[1]

            stopifnot(length(index) > 0)

            if(length(index) == 1) {
              df <- object[ , c(1, index, index + 1)]

            } else {
              cat("Entity name not recognised.")
              stop
            }

            colnames(df) <- c("Gene", "Score", "Rank")
            df <- arrange(df, Score)
            df$Rank <- rev(df$Rank)

            if(geneName %in% df$Gene){

              ggplot(df, aes(x = Rank, y = Score)) +

                geom_point(alpha = 0.8, colour = "grey69", size = 0.5) +

                geom_point(aes_string(x = df$Rank[which(df$Gene == geneName)],
                                      y = df$Score[which(df$Gene == geneName)]),

                           colour = ifelse(df$Score[which(df$Gene == geneName)] < 0,
                                           'red2', 'green3'), size = 3) +

                ggtitle(paste("RIGER scores for", entityName, "cell lines")) +
                theme

            } else {
              cat("Gene not found in chosen dataset.")
            }
          }
)
