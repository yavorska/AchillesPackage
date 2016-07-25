setMethod(f = "consistency.of.phenotypes",
          signature = "RNAi",
          definition = function(object, entityName, geneName, type = "box"){

            geneIndex <- which(object@genes == geneName)
            geneNames.number <- paste(geneName, 1:length(geneIndex), sep = "_")
            geneNames <- paste(geneName, object@sequences[geneIndex], sep = "_")
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

            colnames(subsetDF) <- geneNames.number

            subsetDF <- cbind(CellLine = rownames(subsetDF), subsetDF)

            # CellLine is the name of the CellLine
            # variable is the gene name
            # value is the FC
            meltedDF <- suppressMessages(melt(subsetDF, id = "CellLine"))

            if(type == "box"){

              plot(ggplot(meltedDF, aes(x = variable, y = value, fill = variable)) +
                geom_hline(yintercept = 0, alpha = 0.3, linetype = "dashed", color = "red") +
                geom_boxplot(alpha = 0.4) +
                xlab(paste(geneName, "shRNAs")) + theme(axis.text.x = element_blank()) +
                ylab("FC") +
                ggtitle(paste("Consistency of shRNAs across", entityName, "cell lines")) +
                scale_fill_discrete(name = "shRNAs") +
                theme)

              output.df <- data.frame(shRNA = geneNames.number, sequence = geneNames)
              print.data.frame(output.df)

            } else if (type == "line") {

              plot(ggplot(meltedDF, aes(x = variable, y = value)) +
                geom_line(alpha = 0.7, aes(colour = CellLine, group = CellLine)) +
                stat_summary(fun.y = median, geom = "line", colour = "red", size = 1,
                             aes(group = 1)) +
                xlab(paste(geneName, "shRNAs")) + theme(axis.text.x = element_text(angle = 90)) +
                ylab("FC") +
                ggtitle(paste("Consistency of shRNAs across", entityName, "cell lines")) +
                theme)

              output.df <- data.frame(shRNA = geneNames.number, sequence = geneNames)
              print.data.frame(output.df)

            } else {
              cat("The type of plot chosen must be one of : box or line.")
            }

          })
