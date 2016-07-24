setMethod(f = "consistency.of.phenotypes",
          signature = "RNAi",
          definition = function(object, entityName, geneName, type = "box"){

            geneIndex <- which(object@genes == geneName)
            ngenes <- length(geneIndex)

            valuesDF <- object@values

            # A dataframe with cancers as rows (either just the entity in question or all)
            # and the gene shRNAs as columns
            # A dataframe with cancers as rows (either just the entity in question or all)
            # and the gene shRNAs as columns
            if(entityName == "all"){

              subsetDF <- data.frame(t(valuesDF[which(object@genes == geneName), ]))

            } else if (length(grep(entityName, object@cancers, ignore.case = T))>1) {

              subsetDF <- data.frame(t(valuesDF[which(object@genes == geneName),
                                                grep(entityName, object@cancers, ignore.case = T)]))

            } else {
              cat("The cancer entity/type chosen not recognised.")
              stop
            }

            colnames(subsetDF) <- paste(geneName, object@sequences[which(object@genes == geneName)], sep = "_")

            subsetDF <- cbind(CellLine = rownames(subsetDF), subsetDF)

            # CellLine is the name of the CellLine
            # variable is the gene name
            # value is the FC
            meltedDF <- suppressMessages(melt(subsetDF, id = "CellLine"))

            if(type == "box"){

              ggplot(meltedDF, aes(x = variable, y = value, fill = variable)) +
                geom_hline(yintercept = 0, alpha = 0.3, linetype = "dashed", color = "red") +
                geom_boxplot(alpha = 0.4) +
                xlab(paste(geneName, "shRNAs")) + theme(axis.text.x = element_blank()) +
                ylab("FC") +
                ggtitle(paste("Consistency of shRNAs across", entityName, "cell lines")) +
                scale_fill_discrete(name = "shRNAs") +
                theme

            } else if (type == "line") {

              ggplot(meltedDF, aes(x = variable, y = value)) +
                geom_line(alpha = 0.7, aes(colour = CellLine, group = CellLine)) +
                stat_summary(fun.y = median, geom = "line", colour = "red", size = 1,
                             aes(group = 1)) +
                xlab(paste(geneName, "shRNAs")) + theme(axis.text.x = element_text(angle = 90)) +
                ylab("FC") +
                ggtitle(paste("Consistency of shRNAs across", entityName, "cell lines")) +
                theme

            } else {
              cat("The type of plot chosen must be one of : box or line.")
            }

          })
