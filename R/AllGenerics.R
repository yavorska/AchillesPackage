#' Consistency of phenotypes plot
#'
#' Generate a plot comparing the LFC values of each shRNA of a given gene for each cell line of a given entity.
#'
#' @param object An RNAi object.
#' @param entityName A character string giving the name of the entity in question, e.g. "BONE".
#' @param geneName A character string giving the name of the gene in question, e.g. "MDM4".
#' @param type The style of plot one wishes to show, can be one of "box" or "line".
#' @param ... Any other additions to the ggplot. One can change the theme, plot name, etc. as desired.
#'
#' @return A ggplot object.
#'
#' @examples
#' data("Achilles2.4_Data")
#' data("Achilles2.4_annotation")
#'
#' RNAiObject <- new(Class = "RNAi", genes = Achilles2.4_Data$Gene,
#'                   sequences = Achilles2.4_Data$Name,
#'                   cancers = colnames(Achilles2.4_Data)[-(1:2)],
#'                   cancersP53 = Achilles2.4_annotation,
#'                   values = Achilles2.4_Data[,-(1:2)])
#'
#' consistency.of.phenotypes(object = RNAiObject, entityName = "BONE", geneName = "MDM4", type = "line")
#'
#' @export

setGeneric(name = "consistency.of.phenotypes",
           def = function(object, entityName, geneName, type = "box", ...)
             {standardGeneric("consistency.of.phenotypes")})

#-------------------------------------------------------------------------------------------------------------

#' P53 dependency by entity
#'
#' Generate a plot comparing the dependency of various shRNAs on the mutation status of p53 for the cells lines of a given entity.
#'
#' @param object An RNAi object.
#' @param entityName A character string giving the name of the entity in question, e.g. "BONE".
#' @param geneName A character string giving the name of the gene in question, e.g. "MDM4".
#' @param p53 The types of cell lines to include. Can be "all", "MUT", "WT", or "NA".
#' @param type The style of plot one wishes to show, can be one of "box" or "line".
#' @param ... Any other additions to the ggplot. One can change the theme, plot name, etc. as desired.
#'
#' @return A ggplot object.
#'
#' @examples
#' data("Achilles2.4_Data")
#' data("Achilles2.4_annotation")
#'
#' RNAiObject <- new(Class = "RNAi", genes = Achilles2.4_Data$Gene,
#'                   sequences = Achilles2.4_Data$Name,
#'                   cancers = colnames(Achilles2.4_Data)[-(1:2)],
#'                   cancersP53 = Achilles2.4_annotation,
#'                   values = Achilles2.4_Data[,-(1:2)])
#'
#' p53.dependency.by.entity(object = RNAiObject, entityName = "Lung", geneName = "MDM4", p53 = "all", type = "line")
#'
#' @export

setGeneric(name = "p53.dependency.by.entity",
           def = function(object, entityName, geneName, p53 = "all", type = "all", ...)
             {standardGeneric("p53.dependency.by.entity")})

#-------------------------------------------------------------------------------------------------------------

#' Variation within cell line
#'
#' Generate a plot comparing the LFC values of each shRNA of a given gene within a chosen cell line.
#'
#' @param object An RNAi object.
#' @param cancerID a character string indicating the cell line of interest (partial string matching is sufficient).
#' @param geneName A character string giving the name of the gene in question, e.g. "MDM4".
#' @param type The style of plot one wishes to show, can be one of "all" or "median".
#' @param ... Any other additions to the ggplot. One can change the theme, plot name, etc. as desired.
#'
#' @return A ggplot object.
#'
#' @examples
#' data("Achilles2.4_Data")
#' data("Achilles2.4_annotation")
#'
#' RNAiObject <- new(Class = "RNAi", genes = Achilles2.4_Data$Gene,
#'                   sequences = Achilles2.4_Data$Name,
#'                   cancers = colnames(Achilles2.4_Data)[-(1:2)],
#'                   cancersP53 = Achilles2.4_annotation,
#'                   values = Achilles2.4_Data[,-(1:2)])
#'
#' variation.within.cell.line(object = RNAiObject, cancerID = "SLR24", geneName = "MDM4", type = "all")
#'
#' @export

setGeneric(name = "variation.within.cell.line",
           def = function(object, cancerID, geneName, type = "all", ...)
             {standardGeneric("variation.within.cell.line")})

#-------------------------------------------------------------------------------------------------------------

#' Variation within entity
#'
#' Generate a plot comparing the LFC values of each shRNA of a given gene within the cell lines of a chosen entity.
#'
#' @param object An RNAi object.
#' @param entityName A character string giving the name of the entity in question, e.g. "BONE".
#' @param geneName A character string giving the name of the gene in question, e.g. "MDM4".
#' @param ... Any other additions to the ggplot. One can change the theme, plot name, etc. as desired.
#'
#' @return A ggplot object.
#'
#' @examples
#' data("Achilles2.4_Data")
#' data("Achilles2.4_annotation")
#'
#' RNAiObject <- new(Class = "RNAi", genes = Achilles2.4_Data$Gene,
#'                   sequences = Achilles2.4_Data$Name,
#'                   cancers = colnames(Achilles2.4_Data)[-(1:2)],
#'                   cancersP53 = Achilles2.4_annotation,
#'                   values = Achilles2.4_Data[,-(1:2)])
#'
#' variation.within.entity(object = RNAiObject, entityName = "BONE", geneName = "MDM4")
#'
#' @export

setGeneric(name = "variation.within.entity",
           def = function(object, entityName, geneName, ...)
             {standardGeneric("variation.within.entity")})

#-------------------------------------------------------------------------------------------------------------

#' Variation within entities
#'
#' Generate a plot comparing the LFC values of each shRNA of a given gene within all entities. The entity scores are calculated based on the mean or median of the relevant cell line scores.
#'
#' @param object An RNAi object.
#' @param geneName A character string giving the name of the gene in question, e.g. "MDM4".
#' @param type The type of values one wishes to show. Either "rank" or "value" (for the LFC scores).
#' @param statistic A statistic used to group the cell line scores, can either be "mean" or "median".
#' @param ... Any other additions to the ggplot. One can change the theme, plot name, etc. as desired.
#'
#' @return A ggplot object.
#'
#' @examples
#' data("Achilles2.4_Data")
#' data("Achilles2.4_annotation")
#'
#' RNAiObject <- new(Class = "RNAi", genes = Achilles2.4_Data$Gene,
#'                   sequences = Achilles2.4_Data$Name,
#'                   cancers = colnames(Achilles2.4_Data)[-(1:2)],
#'                   cancersP53 = Achilles2.4_annotation,
#'                   values = Achilles2.4_Data[,-(1:2)])
#'
#' variation.within.entities(object = RNAiObject, geneName = "MDM4", type = "value", statistic = "mean")
#'
#' @export

setGeneric(name = "variation.within.entities",
           def = function(object, geneName, type = "value", statistic = "mean", ...)
             {standardGeneric("variation.within.entities")})

#-------------------------------------------------------------------------------------------------------------

#' RIGER gene score comparison
#'
#' Generate a plot comparing the LFC values of each shRNA of a given gene within entities. The entity scores are calculated based on the mean or median of the relevant cell line scores.
#'
#' @param object A RIGER type object, see vignette for details.
#' @param geneName A character string giving the name of the gene in question, e.g. "MDM4".
#' @param entityName A character string giving the name of the entity in question, e.g. "BONE". Can also be "all".
#' @param ... Any other additions to the ggplot. One can change the theme, plot name, etc. as desired.
#'
#' @return A ggplot object.
#'
#' @examples
#' data("Achilles2.4")
#'
#' riger.gene.comparison(object = Achilles2.4, geneName = "MDM4", entityName = "all")
#'
#' @export

setGeneric(name = "riger.gene.comparison",
           def = function(object, geneName, entityName = "all", ...)
             {standardGeneric("riger.gene.comparison")})

#-------------------------------------------------------------------------------------------------------------

#' RIGER gene score comparison for two datasets
#'
#' Generate a plot comparing the LFC values of each shRNA of a given gene within entities for two different datasets.
#'
#' @param object1 A RIGER type object, see vignette for details.
#' @param object2 A RIGER type object, see vignette for details.
#' @param object1Name A character string giving the name of object1.
#' @param object2Name A character string giving the name of object2.
#' @param geneName A character string giving the name of the gene in question, e.g. "MDM4".
#' @param entityName A character string giving the name of the entity in question, e.g. "BONE". Can also be "all".
#' @param percentage The percentage of scores which should be considered toxic or enriching.
#' @param plotName A character string gicing the name of the final plot.
#' @param ... Any other additions to the ggplot. One can change the theme, plot name, etc. as desired.
#'
#' @return A ggplot object.
#'
#' @examples
#' data("Achilles2.0")
#' data("Achilles2.4")
#'
#' riger.gene.comparison.datasets(object1 = Achilles2.0, object2 = Achilles2.4,
#'                                object1Name = "Ach1", object2Name = "Ach2",
#'                                geneName = "MDM4",entityName = "Colon",
#'                                percentage = 1, plotName = "Comparing RIGER scores")
#'
#' @export

setGeneric(name = "riger.gene.comparison.datasets",
           def = function(object1, object2,
                          object1Name = "Dataset1",
                          object2Name = "Dataset2",
                          geneName = "MDM4",
                          entityName = "all",
                          percentage = 5,
                          plotName = "Dataset Comparisson Plot",...)
             {standardGeneric("riger.gene.comparison.datasets")})
