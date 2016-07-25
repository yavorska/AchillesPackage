setMethod(f = "variation.within.entity",
          signature = "RNAi",
          definition = function(object, entityName, geneName){

            geneIndex <- which(object@genes == geneName)
            geneNames.number <- paste(geneName, 1:length(geneIndex), sep = "_")
            geneNames <- paste(geneName, object@sequences[geneIndex], sep = "_")

            gene_subset <- object@values[geneIndex,]
            cancer_subset <- gene_subset[,grep(entityName, object@cancers, ignore.case = T)]
            cell_line_names <- colnames(cancer_subset)

            col <- rep(geneNames.number,
                       times = length(cell_line_names))

            melted_data <- cbind(col,
                                 suppressMessages(melt(cancer_subset)))

            output.df <- data.frame(shRNA = geneNames.number, sequence = geneNames)

            .plot <- ggplot(melted_data, aes(x = variable, y = value, colour = as.factor(col))) +
                     geom_hline(yintercept = 0, color = "red", linetype = "dashed", alpha = 0.3) +
                     geom_boxplot(alpha = 0.2, colour = "gray68", fill = "gray70") +
                     geom_point(alpha = 1, size = 2) +
                     theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
                     labs(color = "shRNA") +
                     scale_x_discrete(labels = cell_line_names) +
                     xlab(paste(entityName, "Cell Lines")) +
                     ylab("FC") +
                     ggtitle(paste(geneName, "shRNAs grouped by cell line")) +
                     theme

            return(list(shRNAs = output.df, Plot = .plot))
          }
)
