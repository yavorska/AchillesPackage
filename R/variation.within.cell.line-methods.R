setMethod(f = "variation.within.cell.line",
          signature = "RNAi",
          definition = function(object, cancerID, geneName, type = "all"){

            geneIndex <- which(object@genes == geneName)
            ngenes <- length(geneIndex)

            cancerIndex <- grep(cancerID, object@cancers, ignore.case = TRUE)

            valuesDF <- object@values

            sortedData <- data.frame(lon = rank(valuesDF[,cancerIndex])[geneIndex],
                                     lat = valuesDF[geneIndex,cancerIndex])

            valuesDF <- object@values[,cancerIndex]
            valuesDF <- data.frame(Value = valuesDF, Rank = rank(valuesDF))
            valuesDF <- valuesDF[complete.cases(valuesDF),]


            if(type == "all"){
              ggplot(valuesDF, aes(x = Rank,
                                   y = Value)) +

                geom_point(colour = "grey63", size = 0.75) +
                geom_point(data = sortedData, alpha = 0.9, aes(x = lon, y = lat), colour="dodgerblue4", size = 2) +
                geom_segment(data = sortedData, aes(x = lon, xend = lon, y = lat, yend = 0), colour = "dodgerblue4") +
                ggtitle(paste(geneName, "shRNA ranks within the ", object@cancers[cancerIndex], "cell line")) +
                xlab("Ranked shRNAs") +
                ylab("shRNA FC Score") +
                theme

            } else if (type == "median") {

              ggplot(valuesDF, aes(x = Rank,
                                   y = Value)) +

                geom_point(colour = "grey63", size = 0.75) +
                geom_point(alpha = 0.9, aes(x = median(lon), y = median(lat)), data = sortedData, colour = ifelse(median(sortedData$lat) > 0, "green", "red"), size = 2) +
                geom_segment(aes(x = median(lon), xend = median(lon), y = median(lat), yend = 0), data = sortedData, colour = ifelse(median(sortedData$lat) > 0, "green", "red")) +
                ggtitle(paste(geneName, "shRNA median rank within the", object@cancers[cancerIndex], "cell line")) +
                xlab("Ranked shRNAs") +
                ylab("shRNA FC Score") +
                theme

            } else {

              cat("\"type\" must be one of : \"all\" or \"median\".")
            }

})
