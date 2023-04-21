#Associated publication: XXX

library("UpSetR")
library("tidyverse")

#The presence/absence matrix prepared with 'UpSet_matrix_formatting.sh' is loaded
pan <- read.csv("UpSet_input.tsv", header=T, sep = "\t")

Compartment = if_else(rowSums(pan[3:33]) < 31, "Accessory", "Core")
pan$Compartment = Compartment
Accessory = filter(pan, Compartment == "Accessory")

Zambia = Accessory[24:26]
Zambia$CMW25467 = Accessory[33] 

metadata_reg = data.frame(Sets = c("Kenya","Uganda","Zambia","Zimbabwe","RSA"), Region = c(rep("East Africa",2),rep("Southern Africa",3)), Strains = c(rowSums(Accessory[3:9]),rowSums(Accessory[10:16]),rowSums(Zambia),rowSums(Accessory[27:32]),rowSums(Accessory[17:23])))

countries = data.frame(Kenya = ifelse(rowSums(Accessory[3:9]) >= 1, 1, 0), Uganda = ifelse(rowSums(Accessory[10:15]) >= 1, 1, 0), Zambia = ifelse(rowSums(Zambia) >= 1, 1, 0), RSA = ifelse(rowSums(Accessory[16:23]) >= 1, 1, 0), Zimbabwe = ifelse(rowSums(Accessory[27:32]) >= 1, 1, 0))

upset(countries, sets = colnames(countries), order.by = "freq", keep.order=TRUE,set.metadata = list(data = metadata_reg, plots = list(list(type = "matrix_rows",column = "Region",colors = c("East Africa" = "orange","Southern Africa" = "blue")))),empty.intersections = "on",text.scale = c(2,1.5,1,1,1.2,1.5),mb.ratio=c(0.5, 0.5),nintersects=NA,set_size.show = TRUE)
