library(gtsummary)

here::i_am("Source/01_table1.R")
AD_data<-read.csv(here::here("Data","alzheimers_disease_data.csv"))

tbl <- AD_data %>%
  select(Diagnosis, Age, Gender,Ethnicity, EducationLevel, BMI, Smoking, AlcoholConsumption,
         PhysicalActivity, DietQuality, SleepQuality, FamilyHistoryAlzheimers) %>%
  tbl_summary(
    by = Diagnosis, # stratify by diagnosis
    type = list(
      all_continuous() ~ "continuous", 
      all_categorical() ~ "categorical"
    ),
    statistic = list(
      all_continuous() ~ "{mean} ± {sd}", # can also use median, IQR
      all_categorical() ~ "{n} ({p}%)"
    ),
    missing = "ifany"
  ) %>%
  add_p() %>%   # adds p-values for group comparison
  add_overall() # adds overall column

saveRDS(
  tbl,
  file = here::here("Output", "Table_1.rds")
)