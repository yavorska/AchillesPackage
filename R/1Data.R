#Achilles2.4 <- read.csv("Achilles_v2.4_GENE.csv", sep = ";")
#Achilles2.0 <- read.csv("Achilles_v2.0_GENE.csv", sep = ",")
#save(Achilles2.0, file = "data/Achilles2.0.RData")

#Achilles2.0_annotation <- c("MUT","MUT","MUT","MUT","MUT","MUT","MUT","MUT","MUT","WT","MUT","MUT","WT","MUT","WT","WT","MUT","WT","MUT","MUT","MUT","MUT","MUT","WT","MUT","MUT","MUT","MUT","WT","MUT","MUT","MUT","WT","WT","MUT","WT","MUT","MUT","WT","MUT","WT","MUT","WT","WT","WT","MUT","MUT","WT","MUT","WT","MUT","MUT","MUT","WT","WT","MUT","MUT","MUT","MUT","MUT","MUT","WT","WT","MUT","WT","MUT","WT","MUT","MUT","MUT","WT","WT","MUT","WT","MUT","MUT","MUT","MUT","MUT","MUT","WT","MUT","MUT","MUT","WT","WT","WT","MUT","MUT","MUT","MUT","MUT")
#Achilles2.4_annotation <- c("NA","NA","NA","WT","WT","MUT","WT","WT","WT","WT","WT","WT","WT","MUT","MUT","MUT","MUT","WT","WT","WT","WT","WT","WT","MUT","MUT","MUT","NA","WT","WT","WT","MUT","NA","MUT","WT","WT","WT","WT","WT","MUT","MUT","MUT","WT","MUT","NA","NA","WT","NA","WT","WT","MUT","MUT","MUT","NA","MUT","MUT","MUT","WT","NA","WT","MUT","NA","WT","MUT","WT","WT","MUT","MUT","WT","WT","NA","MUT","MUT","MUT","NA","WT","MUT","NA","NA","WT","MUT","WT","WT","MUT","MUT","MUT","MUT","MUT","NA","NA","MUT","WT","MUT","MUT","MUT","MUT","MUT","NA","MUT","NA","MUT","NA","MUT","NA","NA","NA","NA","NA","NA","NA","NA","WT","MUT","NA","WT","WT","MUT","MUT","NA","WT","WT","WT","WT","WT","NA","MUT","MUT","WT","WT","MUT","MUT","WT","MUT","MUT","MUT","WT","MUT","WT","NA","WT","MUT","WT","MUT","MUT","NA","WT","MUT","WT","WT","MUT","NA","MUT","MUT","MUT","MUT","WT","WT","NA","NA","NA","NA","MUT","WT","WT","MUT","WT","WT","MUT","WT","MUT","MUT","WT","NA","MUT","NA","WT","WT","WT","MUT","NA","WT","NA","NA","NA","NA","NA","NA","NA","MUT","WT","MUT","NA","NA","WT","MUT","WT","MUT","MUT","MUT","NA","MUT","NA","WT","WT","MUT","NA","MUT","MUT","NA","NA","NA","WT","NA","MUT","WT","WT")
#save(Achilles2.4_annotation, file = "data/Achilles2.4_annotation.RData")
#save(Achilles2.4_Data, file = "data/Achilles2.4_data.RData")

theme <- theme(
  # Text
  plot.title = element_text(size = rel(1.5), face = "bold"),
  #axis.title = element_text(margin=margin(b = 15, unit = "pt")),

  # Background
  panel.background = element_rect(fill = "white"),
  panel.grid.major = element_line(colour = "gray80", linetype = "dotted"),
  panel.grid.minor = element_line(colour = "gray90", linetype = "dotted")
)
