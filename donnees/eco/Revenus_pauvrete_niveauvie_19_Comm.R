library(tidyverse)
library(readxl)


# Import depuis : https://www.insee.fr/fr/statistiques/6049648

url <- "https://www.insee.fr/fr/statistiques/fichier/6049648/BASE_TD_FILO_DEC_IRIS_2019.xlsx"
destfile <- "BASE_TD_FILO_DEC_IRIS_2019.xlsx"
curl::curl_download(url, destfile)
Revenus_pauvrete_niveauvie_19_Iris <- read_excel(destfile, 
                                         skip = 5)

names(Revenus_pauvrete_niveauvie_19_Iris)[5:28] <- c("part_menages_fiscaux_imposes",
                                                     "taux_bas_revenus_declares_seuil_60pourcent",
                                                     "1er_quartile",
                                                     "mediane",
                                                     "3e_quartile",
                                                     "ecart_interquartile_rapporte_a_mediane",
                                                     "1er_decile",
                                                     "2e_decile",
                                                     "3e_decile",
                                                     "4e_decile",
                                                     "6e_decile",
                                                     "7e_decile",
                                                     "8e_decile",
                                                     "9e_decile",
                                                     "rapport_interdecile",
                                                     "S80_S20",
                                                     "indice_gini",
                                                     "part_revenus_activite",
                                                     "dont_part_salaires_traitements",
                                                     "dont_part_indemnites_chomage",
                                                     "dont_part_revenus_activites_non_salariees",
                                                     "part_pensions_retraites_rentes",
                                                     "part_autres_revenus",
                                                     "note_precaution")

write_csv(Revenus_pauvrete_niveauvie_19_Iris, 
          "C:/Users/mblancho/OneDrive - Groupe Figaro/Donnees/Revenus_pauvrete_niveauvie_19_Iris.csv")

# Fichier par commune

Revenus_pauvrete_niveauvie_19_Comm <- Revenus_pauvrete_niveauvie_19_Iris %>%
  group_by(COM, LIBCOM) %>%
  summarise(across(part_menages_fiscaux_imposes:part_autres_revenus, ~ mean(.x, na.rm = TRUE)))%>%
  write_csv("C:/Users/mblancho/OneDrive - Groupe Figaro/Donnees/Revenus_pauvrete_niveauvie_19_Comm.csv")
 


