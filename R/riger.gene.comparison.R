setMethod(f = "riger.gene.comparison",
          signature = "data.frame",
          definition = function(object, geneName, entityName = "all"){

            index <- grep(entityName, colnames(object), ignore.case = T)[1]

            if(length(index) == 1) {
              df <- object[ , c(1, index, index + 1)]

            } else {
              cat("Entity name not recognised.")
              stop
            }

            colnames(df) <- c("Gene", "Score", "Rank")
            df <- arrange(df, Score)
            df$Rank <- rev(df$Rank)
            
            col <- ifelse(df$Score[which(df$Gene == geneName)] < 0,
                          'red4', 'green4')

            if(geneName %in% df$Gene){

              ggplot(df, aes(x = Rank, y = Score)) +

                geom_point(alpha = 0.8, colour = "grey69", size = 0.5) +

                geom_point(aes_string(x = df$Rank[which(df$Gene == geneName)],
                                      y = df$Score[which(df$Gene == geneName)]),

                           colour = ifelse(df$Score[which(df$Gene == geneName)] < 0,
                                           'red2', 'green3'), size = 3) +

                ggtitle(paste("RIGER scores for", entityName, "cell lines")) +
                annotate("text", 
                         label = paste(geneName, "\n",
                                       "Rank = ", df$Rank[which(df$Gene == geneName)], "\n",
                                       "Score = ", df$Score[which(df$Gene == geneName)], sep = ""), 
                            x = 500, y = 0.8, size = 5, colour = col, hjust = 0) +
                theme

            } else {
              cat("Gene not found in chosen dataset.")
            }
          }
)
