setMethod(f = "riger.gene.comparison.datasets",
          signature = c("data.frame", "data.frame"),
          definition = function(object1, object2,

                                object1Name = "Dataset1",
                                object2Name = "Dataset2",
                                geneName = "MDM4",
                                entityName = "all",
                                percentage = 5,
                                plotName = "Dataset Comparisson Plot"){

            index1 <- grep(entityName, colnames(object1), ignore.case = T)[1]
            index2 <- grep(entityName, colnames(object2), ignore.case = T)[1]

            stopifnot(length(index1) == length(index2))

            commonGenes <- intersect(object1$Gene, object2$Gene)

            stopifnot(geneName %in% commonGenes)

            nGenes <- length(commonGenes)

            df <- data.frame(Gene = commonGenes,
                             Ach1 = object1[which(object1$Gene %in% commonGenes), index1],
                             Ach2 = object2[which(object2$Gene %in% commonGenes), index2])

            df$Ach1.rank <- rank(df$Ach1)
            df$Ach2.rank <- rank(df$Ach2)

            df$top1 <- ifelse(df$Ach1.rank > (1 - percentage/100)*nGenes, T, F)
            df$top2 <- ifelse(df$Ach2.rank > (1 - percentage/100)*nGenes, T, F)

            df$bottom1 <- ifelse(df$Ach1.rank < (percentage/100)*nGenes, T, F)
            df$bottom2 <- ifelse(df$Ach2.rank < (percentage/100)*nGenes, T, F)

            ggplot(data = df,
                   aes(x = Ach1, y = Ach2)) +
              geom_point(alpha = 0.2, color = "gray69", size = 1) +

              # Add in the top1 and top2
              # Add in topBoth
              # Green
              geom_point(data = df[which(df$top1 == TRUE | df$top2 == TRUE),],
                         aes(x = Ach1, y = Ach2), color = "lawngreen", size = 1, shape = 3, alpha = 0.5) +
              geom_point(data = df[which(df$top1 == TRUE & df$top2 == TRUE),],
                         aes(x = Ach1, y = Ach2), color = "green4", shape = 8, size = 2, alpha = 0.7) +
              # Add in bottom1 and bottom2
              # Add in bottomBoth
              # Red
              geom_point(data = df[which(df$bottom1 == TRUE | df$bottom2 == TRUE),],
                         aes(x = Ach1, y = Ach2), color = "red", size = 1, shape = 4, alpha = 0.5) +
              geom_point(data = df[which(df$bottom1 == TRUE & df$bottom2 == TRUE),],
                         aes(x = Ach1, y = Ach2), color = "red4", shape = 8, size = 2, alpha = 0.7) +

              # Add in the gene
              geom_point(data = df[which(df$Gene == geneName),],
                         aes(x = Ach1, y = Ach2), color = "blue", shape = 0, size = 4) +

              # Add labels
              xlab(object1Name) +
              ylab(object2Name) +
              ggtitle(plotName) +
              # Add theme
              theme
          }
)
