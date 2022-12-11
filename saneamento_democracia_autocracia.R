
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




