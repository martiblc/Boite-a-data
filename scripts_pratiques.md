# Scripts pratiques

## 📂 Import

-   [Importer fichier excel et joindre toutes les feuilles avec un
    identifiant](https://dominicroye.github.io/en/2019/import-excel-sheets-with-r/)

<!-- -->

    lien <- ("C:/Users/user/Documents/0_PRO/Data et scripts/NOMDUFICHIER.xlsx")

    df <- lien %>%
      excel_sheets()%>%
      set_names() %>%
      map_df(read_excel, path = lien, .id = "nomfuturecolonneidentifiant")

## 🧹 Nettoyage

-   Nettoyer automatiquement les titres

<!-- -->

    df %>% janitor::clean_names()

-   Éliminer les doublons sur toute la ligne ou basé sur une colonne

<!-- -->

    # Exclure les doublons
    df %>% distinct(col1, col2, col3, .keep_all = T)

    # Garder que les doublons
    df %>% group_by(col1, col2, col3) %>% filter(n() > 1)

    # Filtrer les doublons
    df %>% group_by(col1, col2, col3) %>% filter(n() == 1)

    # Méthode de base pour exclure les doublons
    df[!duplicated(df[1:3]), ]
    df[!duplicated(df[c("col1", "col2"), ]), ]

-   Retirer tous les accents, cédilles…

<!-- -->

    mutate(colonne = iconv(colonne, from="UTF-8",to="ASCII//TRANSLIT"))

-   Retirer tous les espaces

<!-- -->

    mutate(across(where(is.character), str_remove_all, " "))

-   Utiliser mutate\_at pour appliquer facilement fonction et remplacer
    valeurs

<!-- -->

    # Exemple 1
    df %>% mutate_at("var1", ~str_replace_all(., " ", "<br>"))

    # Exemple 2
    df %>% mutate_at("var2", ~replace(., is.nan(.), 0))

## 🛠 Wrangling

### Calculs

-   Calcul glissant (moyenne, somme,…)

<!-- -->

    # Moyenne glissante sur 7 jours
    slider::slide_dbl(n_dose1, sum, .before=6, .complete = TRUE) / 7

-   Normaliser/standardiser une série afin d’obtenir une note pour
    chaque valeur respectant les écarts

<!-- -->

    note_max_meilleur <- function(x) {
    (x - min(x)) / (max(x) - min(x))
    }

    note_min_meilleur <- function(x) {
    (x - max(x)) / (min(x) - max(x))
    }

### Travail en largeur

-   Appliquer même fonction sur tout un rang de colonnes (utilisable
    avec group\_by)

<!-- -->

    df %>% group_by(colonne_groupe) %>%
      summarise(across(1e_col_choisie:derniere_col_choisie, mean))

    # Utiliser tilde avec fonction pour changer ses arguments
    df %>% group_by(colonne_groupe) %>%
      summarise(across(1e_col_choisie:derniere_col_choisie, ~ mean(.x, na.rm = TRUE)))

-   Appliquer une fonction ou calcul en largeur (sur la ligne / rowwise)

<!-- -->

    df %>%
      rowwise() %>%
      mutate(nouvelle_col = sum(c_across(1e_col_choisie:derniere_col_choisie)) / 4)

### Fonctions maison

-   Sauvegarder résultat fonction dans environnement global R (à
    utiliser dans fonction par exemple)

<!-- -->

    assign(x = nom_objet, value = objet, envir = .GlobalEnv)

### Filtrer

-   Filtrer valeurs qui contiennent caractères XYZ

<!-- -->

    filter(grepl("CARACTERESXYZ", colonne_a_filtrer))

-   [Filtrer dans plusieurs
    variables](https://dplyr.tidyverse.org/reference/filter_all.html#arguments)
    -   if\_any() si la condition doit être remplie dans une seule des
        variables au moins
    -   if\_all() si elle doit l’être dans toutes les variables

Les deux se basent sur une fonction pour filter. Il faut donc
l’introduire avec le tilde. Le .x avant un opérateur est nécessaire pour
lui introduire chacune des variables que va itérer le everything() ou
across().

    filter(if_any(everything(), ~ .x == "Poor" ))

    # everything() pour sélectionner toutes les variables
    # across() pour sélectionner une plage

    filter(across(quality2018:quality2021, ~ !is.na(.x)))

### Divers

-   Changer valeurs d’une ou plusieurs variables avec recode

<!-- -->

    # Changer valeurs d'une variable
    mutate(col1 = recode(col1, 
                             `valeur1` = "val_1.1",
                             `valeur2` = "val_2.1"))

    # Changer valeurs dans plusieurs variables 
    mutate_at(c("col1","col2"), 
              list(~ recode(., valeur1 = "val_1.1",
                             valeur2 = "val_2.1",
                             .default = NaN))) 

-   Changer valeurs d’une variable avec une ou plusieurs conditions avec
    case\_when

<!-- -->

    # Utilisation classique avec case_when
    df %>% 
      mutate_at("col1",funs(
        case_when(col1 == 1 ~ "alt1",
                  col1 == 2 ~ "alt2",
                  T ~ "alt3")))


    # Utilisation case_when avec between (rang numérique)
    df %>% 
      mutate(col1 = case_when(
          between(var2, 1, 5) ~ "A",
          between(var2, 6, 10) ~ "B",
          T ~ col1)
          )

-   Copier dataframe dans le presse-papier

<!-- -->

    clipr::write_clip(data)  

## RegEx

Utiliser str\_detect avec filter - str\_detect(df,“^F”)) -&gt; commence
par F - “F$” -&gt; finit par F - “\d” -&gt; contient des chiffres - !
-&gt; placé devant str\_detect comme argument “SAUF”

Utiliser aussi if\_any, ends\_with et starts\_with

## Divers

    deces_2015_clean <- deces_2015_clean %>%
      mutate_if(is.character, str_squish)

## Viz

-   Enregistrer png

<!-- -->

    ggsave(filename = "NOMDUFICHIER.png", width=18, height = 13, units = "cm",type="cairo-png")

-   Utiliser subset pour filtrer

<!-- -->

    geom_bar(data = subset(vaccins_natio, vaccin != 0))

-   Marges

<!-- -->

    theme(plot.margin = margin(5, 5, 5, 5, "mm"))

-   Légende en haut à droite dans le graph

<!-- -->

    theme(legend.position = c(0, 1), 
    legend.justification = c(-0.1, 1.1))

-   Supprimer titre légende

<!-- -->

    theme(legend.title=element_blank())

-   Lmite date début axe x

<!-- -->

    scale_x_date(limits = c(ymd("2021-01-01"), NA))

-   Placer texte axe x en biais

<!-- -->

    theme(axis.text.x = element_text(angle = 45, hjust=1))

-   Formater labels avec , en décimal et . séparateur centaines

<!-- -->

    scale_y_continuous(labels=function(x) format(x, big.mark = ".", decimal.mark = ",", scientific = FALSE))
