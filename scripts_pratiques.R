#Analyse
deces_2015_clean <- deces_2015_clean %>%
  mutate_if(is.character, str_squish)

#Calcul glissant (moyenne, somme,...)
## Utiliser package slider
slider::slide_dbl(n_dose1, sum, .before=6, .complete=TRUE)/7)
#Ici moyenne glissante sur 7 jours des vaccins. 

# Filtrer valeurs qui contiennent caractères XYZ
filter(grepl("CARACTERESXYZ", colonne_a_filtrer))

# Changer valeurs d'une variable avec recode
mutate(variable=recode(variable, 
                         `valeur_origine1`="valeur_finale1",
                         `valeur_origine2`="valeur_finale2"))


#Regex
#Utiliser str_detect avec filter
str_detect(df,"^F")) -> commence par F
"F$" -> finit par F
"\\d" -> contient des chiffres
! -> placé devant str_detect comme argument "SAUF"

# Utiliser aussi if_any, ends_with et starts_with


#Importer fichier excel et joindre toutes les feuilles avec un identifiant
#https://dominicroye.github.io/en/2019/import-excel-sheets-with-r/
lien <- ("C:/Users/user/Documents/0_PRO/Data et scripts/NOMDUFICHIER.xlsx")

df <- lien %>%
  excel_sheets()%>%
  set_names() %>%
  map_df(read_excel, path = lien, .id = "nomfuturecolonneidentifiant")


#Eliminer les doublons sur toute la ligne ou basé sur une colonne
distinct()
distinct(COLONNE_A_TRIER, .keep_all = TRUE)



# ggplot et viz

# Enregistrer png
ggsave(filename = "NOMDUFICHIER.png", width=18, height = 13, units = "cm",type="cairo-png")

# Utiliser subset pour filtrer 
geom_bar(data = subset(vaccins_natio, vaccin != 0)
         
# Marges
theme(plot.margin = margin(5, 5, 5, 5, "mm"))
         
# Légende en haut à droite dans le graph
theme(legend.position = c(0, 1), 
legend.justification = c(-0.1, 1.1))
         
# Supprimer titre légende
theme(legend.title=element_blank())
         
# Lmite date début axe x
scale_x_date(limits = c(ymd("2021-01-01"), NA))
         
# Placer texte axe x en biais
theme(axis.text.x = element_text(angle = 45, hjust=1))
         
# Formater labels avec , en décimal et . séparateur centaines
scale_y_continuous(labels=function(x) format(x, big.mark = ".", decimal.mark = ",", scientific = FALSE))
         
         
         
         
         
         
         
         
