setMethod(f = "variation.within.entities",
          signature = "RNAi",
          definition = function(object, geneName, type = "value", statistic = "mean"){

            geneIndex <- which(object@genes == geneName)
            geneNames.number <- paste(geneName, 1:length(geneIndex), sep = "_")
            geneNames <- paste(geneName, object@sequences[geneIndex], sep = "_")

            ngenes <- length(geneIndex)

            cancerNames <- unique(sub("^.*?_", "", object@cancers))
            ncancers <- length(cancerNames)

            resultMatrix <- matrix(nrow = ngenes,
                                   ncol = ncancers)

            colnames(resultMatrix) <- cancerNames
            rownames(resultMatrix) <- geneNames.number

            for (k in 1:length(cancerNames))
            {
              ## Cycle through each of the cancers of a certain entity
              cancerIndex <- grep(cancerNames[k], object@cancers)
              ncancer <- length(cancerIndex)

              values <- numeric(ncancer)

              #For each shRNA, calculate the average (or median) rank
              for (j in 1:ngenes)
              {
                for (i in 1:ncancer)
                {
                  values[i] <- ifelse(type == "rank",
                                      rank(object@values[, cancerIndex[i]])[geneIndex[j]],
                                      object@values[geneIndex[j], cancerIndex[i]])
                }

                resultMatrix[j,k] <- ifelse(statistic == "median",
                                            median(values),
                                            mean(values))
              }
            }

            # Var1 is gene
            # Var2 is cancer
            # value is the FC
            meltedResultMatrix <- melt(resultMatrix)

            plot(ggplot(meltedResultMatrix, aes(x = Var2, y = value, group = as.factor(Var1), color = as.factor(Var1))) +
              geom_line() +
              geom_hline(yintercept = 0, alpha = 0.3, linetype = "dashed", color = "red") +
              theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 10)) +
              labs(color = "shRNA") +
              xlab("Entity") +
              ylab(paste(geneName, "FC")) +
              ggtitle(paste("Variation of", geneName, "shRNAs within entities")) +
              theme)

            output.df <- data.frame(shRNA = geneNames.number, sequence = geneNames)
            print.data.frame(output.df)

          }
)
