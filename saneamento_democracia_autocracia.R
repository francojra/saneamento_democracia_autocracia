
# Saneamento em países democratas e autocratas ---------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 10/12/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: https://ourworldindata.org/sanitation ----------------------------------------------------------------------------------------

# Sobre os dados ---------------------------------------------------------------------------------------------------------------------------

### Estima-se que 775.000 pessoas morreram prematuramente como resultado das más condições 
### sanitárias em 2017. Isso foi 1,4% das mortes em todo o mundo.

### Em países de baixa renda, a falta de saneamento básico é responsável por 5% das mortes.

### Em 2017, isso alcançou um aumento na porcentagem de morte de cerca de 11% em Chade - 
### mais que 1 em cada 10 mortes - em comparação a 0,01% na maior parte da Europa.

### Quando nós comparamos a porcentagem de mortes atribuídas a falta de saneamento ao
### longo do tempo ou entre países, nós não estamos apenas comparando a extensão do
### saneamento, mas a severidade no contexto dos riscos de morte. A porcentagem do saneamento
### não depende apenas como mutios morrem prematuramente, mas também do que mais as pessoas 
### estão a morrer e de como isto está a mudar.

# Carregar pacotes -------------------------------------------------------------------------------------------------------------------------

library(tidyverse)
library(cols4all)
library(hrbrthemes)
library(ggthemes)

# Carregar dados ---------------------------------------------------------------------------------------------------------------------------

san <- read.csv("share-deaths-unsafe-sanitation.csv")
view(san)
names(san)

# Manipular dados --------------------------------------------------------------------------------------------------------------------------

san <- san %>%
  select(-Code) %>%
  rename(por_mort_san = Deaths...Cause..All.causes...Risk..Unsafe.sanitation...Sex..Both...Age..Age.standardized..Percent.) %>%
  view()

san1 <- san %>%
  filter(Entity %in% c("United States", "Japan", "Germany",
                       "Cuba", "China", "North Korea")) %>%
  group_by(Entity) %>%
  summarise(media = mean(por_mort_san),
            n = n(), sd = sd(por_mort_san),
            se = sd/sqrt(n)) %>%
  view()

san2 <- san %>%
  filter(Entity %in% c("United States", "Japan", "Germany",
                       "Cuba", "China", "North Korea")) %>%
  view()

san3 <- san %>%
  filter(Entity %in% c("United States", "Brazil", "China")) %>% 
  view()

# Gráficos ---------------------------------------------------------------------------------------------------------------------------------

c4a("safe", 6)

ggplot(san1, aes(x = fct_reorder(Entity, media), y = media, fill = Entity)) +
  geom_col(width = 0.9) +
  geom_errorbar(aes(ymax = media + se, ymin = media + se),
                size = 0.8, width = 0.2) +
  scale_y_continuous(expand = expansion(mult = c(0,0))) +
  scale_fill_manual(values = c("#88CCEE", "#CC6677",
                               "#DDCC77", "#117733",
                               "#332288", "#AA4499")) +
  scale_x_discrete(labels = c("Alemanha", "Japão", "Estados Unidos",
                              "Coreia do Norte", "Cuba", "China")) +
  labs(x = "Países", y = "Mortes por falta de\n saneamento (%)") +
  theme_ipsum(axis_text_size = 14, axis_title_size = 16) +
  theme(legend.position = "none", 
        axis.text = element_text(color = "black"))

ggplot(san2, aes(x = Year, y = por_mort_san,
                 group = Entity, color = Entity)) +
  geom_point(shape = 15, size = 2.5) +
  geom_line(size = 1.2) +
  scale_color_manual(values = c("#88CCEE", "#CC6677",
                               "#DDCC77", "#117733",
                               "#332288", "#AA4499"),
                     labels = c("China", "Cuba", "Alemanha", "Japão",
                                "Coreia do Norte", "Estados Unidos")) +
  labs(x = "Tempo (anos)", y = "Mortes por falta de\n saneamento (%)",
       color = "Países") +
  theme_ipsum(axis_text_size = 14, axis_title_size = 16) +
  theme(axis.text = element_text(color = "black"))
