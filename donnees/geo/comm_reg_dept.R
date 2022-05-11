library(tidyverse)

setwd("C:/Users/mblancho/OneDrive - Groupe Figaro/Donnees")

# Donnees INSEE : https://www.insee.fr/fr/information/6051727

commune_2022 <- read_csv("https://www.insee.fr/fr/statistiques/fichier/6051727/commune_2022.csv")

region_2022 <- read_csv("https://www.insee.fr/fr/statistiques/fichier/6051727/region_2022.csv")

departement_2022 <- read_csv("https://www.insee.fr/fr/statistiques/fichier/6051727/departement_2022.csv")



comm_reg_dept_2022 <- commune_2022 %>%
  left_join(region_2022, by = "REG", suffix = c("_commune", "_region")) %>%
  left_join(departement_2022, by = "DEP") %>%
  filter(!TYPECOM %in% c("COMA", "COMD"))


write_csv(comm_reg_dept_2022, "comm_reg_dept_2022.csv")
  
