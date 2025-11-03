library(ggplot2)

here::i_am("Source/02_figure1.R")
AD_data<-read.csv(here::here("Data","alzheimers_disease_data.csv"))

p<-ggplot(AD_data, aes(x = MMSE, fill = factor(Diagnosis))) +
  geom_histogram(binwidth = 3, color = "black", position = "stack") +
  scale_fill_manual(
    values = c("0" = "steelblue", "1" = "tomato"),
    name = "Diagnosis",
    labels = c("0" = "Control", "1" = "AD")
  ) +
  labs(
    title = "Mini-Mental State Examination score Distribution by Diagnosis",
    x = "Mini-Mental State Examination score",
    y = "Number of Participants"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    legend.position = "right"
  )

saveRDS(
  p,
  file = here::here("Output", "Figure_1.rds")
)