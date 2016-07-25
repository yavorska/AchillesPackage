setMethod(f = "variation.within.cell.line",
          signature = "RNAi",
          definition = function(object, cancerID, geneName, type = "all"){

            geneIndex <- which(object@genes == geneName)
            ngenes <- length(geneIndex)

            cancerIndex <- grep(cancerID, object@cancers, ignore.case = TRUE)

            valuesDF <- object@values
            newDF <- data.frame(Gene = object@genes, Value = valuesDF[,cancerIndex])
            newDF <- newDF[complete.cases(newDF),]
            newDF$Rank <- rank(newDF$Value)
            geneIndex <- which(newDF$Gene == geneName)
            ngenes <- length(geneIndex)

            sortedData <- data.frame(lon = newDF$Rank[geneIndex],
                                     lat = newDF$Value[geneIndex])

            if(type == "all"){
              ggplot(newDF, aes(x = Rank,
                                y = Value)) +

                geom_point(colour = "grey63", size = 0.75) +
                geom_point(data = sortedData, alpha = 0.9, aes(x = lon, y = lat), colour="dodgerblue4", size = 2) +
                geom_segment(data = sortedData, aes(x = lon, xend = lon, y = lat, yend = 0), colour = "dodgerblue4") +
                ggtitle(paste(geneName, "shRNA ranks within", object@cancers[cancerIndex])) +
                xlab("Ranked shRNAs") +
                ylab("shRNA FC Score") +
                theme

            } else if (type == "median") {

              x.val <- round(median(sortedData$lon))
              y.val <- newDF$Value[which(newDF$Rank == x.val)]

              ggplot(newDF, aes(x = Rank,
                                y = Value)) +
                geom_point(colour = "grey63", size = 0.75) +
                geom_point(alpha = 0.9, aes(x = x.val, y = y.val),
                           data = NULL, colour = ifelse(y.val > 0, "green", "red"), size = 2) +
                geom_segment(aes(x = x.val, xend = x.val, y = y.val, yend = 0),
                             data = NULL, colour = ifelse(y.val > 0, "green", "red")) +
                ggtitle(paste(geneName, "shRNA median rank within", object@cancers[cancerIndex])) +
                xlab("Ranked shRNAs") +
                ylab("shRNA FC Score") +
                theme

            } else {

              cat("\"type\" must be one of : \"all\" or \"median\".")
            }

})
