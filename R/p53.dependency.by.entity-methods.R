setMethod(f = "p53.dependency.by.entity",
          signature = "RNAi",
          definition = function(object, entityName, geneName, p53 = "all", type = "box"){

            geneIndex <- which(object@genes == geneName)
            geneNames.number <- paste(geneName, 1:length(geneIndex), sep = "_")
            geneNames <- paste(geneName, object@sequences[geneIndex], sep = "_")

            valuesDF <- object@values

            if(entityName == "all"){
              cancerIndex <- 1:length(object@cancers)

            } else if (length(grep(entityName, object@cancers, ignore.case = T)) > 0) {
              cancerIndex <- grep(entityName, object@cancers, ignore.case = T)

            } else {
              cat("The cancer entity/type chosen not recognised.")
              stop
            }

            annotations <- object@cancersP53[cancerIndex]
            subsetDF <- t(valuesDF[geneIndex, cancerIndex])
            colnames(subsetDF) <- geneNames.number

            meltedDF <- melt(subsetDF, id = "Index")

            # Include annotations
            meltedDF2 <- cbind(meltedDF, rep(annotations, times = length(geneIndex)))
            colnames(meltedDF2) <- c("cancer", "gene", "value", "p53")

            if(p53 == "all") {
              status <- c("MUT", "WT", "NA")
            } else {
              status <- type
            }

            if(type == "line") {

              plot(ggplot(meltedDF2[which(meltedDF2$p53 %in% status),],
                     aes(x = as.factor(gene), y = value)) +
                geom_point(alpha = 0.8,
                           aes(colour = p53, group = p53, shape = cancer), size = 2) +
                geom_line(alpha = 0.8, aes(colour = p53, group = cancer), size = 0.15) +
                scale_shape_manual(name = "Cell line",
                  values = 1:nlevels(meltedDF2[which(meltedDF2$p53 %in% status),]$cancer),
                  labels = sub("_[A-z ]*", "", meltedDF2[which(meltedDF2$p53 %in% status),]$cancer)) +
                scale_color_manual(name = "p53 status", values = c("MUT"="red", "NA"="gray", "WT"="limegreen")) +
                theme_bw() +
                xlab(paste(geneName, "shRNAs")) + theme(axis.text.x = element_text(angle = 90)) +
                ylab("FC") +
                ggtitle(paste("p53 dependency of", entityName, "cell lines")) +
                theme)
              
              output.df <- data.frame(shRNA = geneNames.number, sequence = geneNames)
              print.data.frame(output.df)

            } else if (type == "box") {

              # Remove non available values
              meltedDF3 <- meltedDF2[which(meltedDF2$p53 != "NA"),]

              plot(ggplot(meltedDF3, aes(x = gene, y = value, fill = p53)) +
                geom_boxplot(alpha = 0.8) +
                theme_bw() +
                theme(axis.ticks = element_blank(), axis.text.x = element_blank()) +
                facet_grid(.~gene, scales = "free") +
                scale_fill_manual(name = "p53 status", values = c("red", "limegreen")) +
                xlab(paste(geneName, "shRNAs")) +
                ylab("FC") +
                ggtitle(paste("p53 dependency of", entityName, "cell lines")) +
                theme)
              
              output.df <- data.frame(shRNA = geneNames.number, sequence = geneNames)
              print.data.frame(output.df)

            } else {
              cat("The type of plot chosen must be one of: line or box.")
            }

          }
)
