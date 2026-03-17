# Title: Demo 
# Date: 10/16/2023
# Name: Lizbeth Vasquez 

# Class 3 Import data -------------------------------------------------



pacman::p_load(
  rio,          # for importing data
  here,         # for file paths
  janitor,      # for data cleaning
  lubridate,    # for working with dates
  flextable,    # for making pretty tables
  epikit,
  gtsummary,
  scales,
  flextable,
  ggExtra,
  gghighlight,
  RColorBrewer,
  viridis,
  apyramid,
  tsibble,
  tidyverse     # for data management
)

surv <- import(file = here('data','raw','surveillance_linelist_20141201.csv'))

#import data

hosp_central <- import(here("data", "raw", "hospitals", "20141201_hosp_central.csv"))
hosp_military <- import(here("data", "raw", "hospitals", "20141201_hosp_military.csv"))
hosp_port <- import(here("data", "raw", "hospitals", "20141201_hosp_port.csv"))
hosp_smmh <- import(here("data", "raw", "hospitals", "20141201_hosp_smmh.csv"))
hosp_other <- import(here("data", "raw", "hospitals", "20141201_hosp_other.csv"))
hosp_missing <- import(here("data", "raw", "hospitals", "20141201_hosp_missing.csv"))

demo <- (surv)

# Import lab data
# (place this near the top of your script, in the importing section)
lab <- import(here("data", "raw", "lab_results_20141201.xlsx")) %>% 
  clean_names()

combined <- import(here("data", "clean", "backup", "linelist_combined_20141201.rds"))
view(surv)

# About this script ----------------------------------------------

pacman::p_load(
  rio,          # for importing data
  here,         # for file paths
  janitor,      # for data cleaning
  lubridate,    # for working with dates
  flextable,    # for making pretty tables
  tidyverse     # for data management
)
# Exploratory analysis -----------------------------------------

surv <- import(file = here('data','raw','surveillance_linelist_20141201.csv'))

surv_raw <- import(here("data", "raw", "surveillance_linelist_20141201.csv"))

names(surv_raw)

# tabulate fever
surv_raw %>% 
  tabyl(fever)

surv_raw %>% 
  tabyl(gender)

ggplot(data = surv_raw, mapping = aes(x = age))+
  geom_histogram()

ggplot(data = surv_raw, mapping = aes(x = age))+
  geom_boxplot()

# median age is under 20.. but some ages are recorded in months!

surv_raw %>% 
  tabyl(`age unit`)

class(surv_raw)

class(surv_raw$age)

class(surv_raw$`onset date`)

class(surv_raw$`date of report`)

ggplot(data = surv_raw, mapping = aes(x = `wt (kg)`))+
  geom_histogram()

ggplot(data = surv_raw, mapping = aes(x = `ht (cm)`))+
  geom_histogram()


("tabyl.emptystring" = FALSE)


surv_raw %>% 
  tabyl(adm3_name_res, adm3_name_det)

# Ctrl, shift, m for pipe operator


# Clean surveillance data -------------------------------------------------

view(surv)

clean_names(surv)

surv <- surv_raw %>% 
  clean_names() %>% 
  rename(
    #NewName          #OldName
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det
  )


surv <- surv_raw %>% 
  clean_names() %>% 
  rename(
    # NEW NAME     # OLD NAME
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det
  )

view(surv)


# Testing Code ------------------------------------------------------------

surv %>% 
  select(epilink, age, gender)

#keeps fever vom, and other columns in between them 

surv %>% 
  select(fever:vomit)

# use everything()
surv %>% 
  select(fever, gender, date_report, everything())

surv %>% 
  select(-epilink)

# an equivalent command to above- removes three columns
surv %>% 
  select(-epilink, -district_det, -age)

surv <- surv_raw %>% 
  
  # automatically clean column names
  clean_names() %>% 
  
  # manually clean column names   
  rename(
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det) %>%
  
  # remove unnecessary column
  select(-row_num)


# de-duplicate rows  
distinct()

view(surv)

view(surv_raw)


# column classes ----------------------------------------------------------


class(surv$gender)

head(surv$date_onset)


# ymd() should be used to convert raw values written as: year, month, day
ymd("2020-10-11")

ymd("20201011")

# mdy() should be used to convert raw values written as: month, day, year
mdy("Oct 11 20")

mdy("10/11/20")

# mdy() should be used to convert raw values written as: month, day, year
dmy("11 October 2020")

dmy("11/10/2020")

# Mutate command= column name= a function to use to create/modify the column

surv <- surv_raw %>% 
  
  # automatically clean column names
  clean_names() %>% 
  
  # manually clean column names   
  rename(
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det) %>%
  
  # remove unnecessary column
  select(-row_num) %>% 
  
  # de-duplicate rows  
  distinct() %>% 
  
  # convert date_onset to date class
  mutate(date_onset = mdy(date_onset)) %>% 
  mutate(date_report = mdy(date_report))

# plot a histogram of dates using the cleaned dataset and date column
ggplot(data = surv, mapping = aes(x = date_onset))+
  geom_histogram()

surv <- surv_raw %>% 
  
  # automatically clean column names
  clean_names() %>% 
  
  # manually clean column names   
  rename(
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det) %>%
  
  # remove unnecessary column
  select(-row_num) %>% 
  
  # de-duplicate rows  
  distinct() %>% 
  
  # convert date_onset to date class
  mutate(date_onset = mdy(date_onset)) %>% 
  mutate(date_report = mdy(date_report)) %>% 
  
  # convert age to numeric class
  mutate(age = as.numeric(age)) %>% 
  
  # This command would be added to a pipe chain
  mutate(gender = na_if(gender, "Unknown"))


surv_raw %>% 
  tabyl(gender)

surv <- surv_raw %>% 
  
  # automatically clean column names
  clean_names() %>% 
  
  # manually clean column names   
  rename(
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det) %>%
  
  # remove unnecessary column
  select(-row_num) %>% 
  
  # de-duplicate rows  
  distinct() %>% 
  
  # convert date_onset to date class
  mutate(date_onset = mdy(date_onset)) %>% 
  mutate(date_report = mdy(date_report)) %>% 
  
  # convert age to numeric class
  mutate(age = as.numeric(age)) %>% 
  
  # convert "Unknown" gender to NA
  mutate(gender = na_if(gender, "Unknown"))

view(surv_raw)

surv <- surv_raw %>% 
  
  # automatically clean column names
  clean_names() %>% 
  
  # manually clean column names   
  rename(
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det) %>%
  
  # remove unnecessary column
  select(-row_num) %>% 
  
  # de-duplicate rows  
  distinct() %>% 
  
  # convert date_onset to date class
  mutate(date_onset = mdy(date_onset)) %>% 
  mutate(date_report = mdy(date_report)) %>% 
  
  # convert age to numeric class
  mutate(age = as.numeric(age)) %>% 
  
  # convert "Unknown" gender to NA
  mutate(gender = na_if(gender, "Unknown")) %>% 
  
  # properly record missing values in many character columns
  mutate(across(.cols = where(is.character), .fns = na_if, ""))

sum(is.na(surv$date_onset))   # number of rows where is.na(surv$date_onset) evaluates to TRUE
sum(is.na(surv$date_report))  # number of rows where is.na(surv$date_report) evaluates to TRUE



surv <- surv_raw %>% 
  
  # automatically clean column names
  clean_names() %>% 
  
  # manually clean column names   
  rename(
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det) %>%
  
  # remove unnecessary column
  select(-row_num) %>% 
  
  # de-duplicate rows  
  distinct() %>% 
  
  # convert date_onset to date class
  mutate(date_onset = mdy(date_onset)) %>% 
  mutate(date_report = mdy(date_report)) %>% 
  
  # convert age to numeric class
  mutate(age = as.numeric(age)) %>% 
  
  # convert "Unknown" gender to NA
  mutate(gender = na_if(gender, "Unknown")) %>% 
  
  # properly record missing values in many character columns
  mutate(across(.cols = where(is.character), .fns = na_if, "")) %>% 
  
  # re-code hospital column
  mutate(hospital = recode(hospital,
                           # for reference: OLD = NEW
                           "Mitilary Hospital"  = "Military Hospital",
                           "Port"               = "Port Hospital",
                           "Port Hopital"       = "Port Hospital",
                           "St. Mark's Maternity Hospital (SMMH)" = "SMMH"))

view(surv)

surv <- surv_raw %>% 
  
  # automatically clean column names
  clean_names() %>% 
  
  # manually clean column names   
  rename(
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det) %>%
  
  # remove unnecessary column
  select(-row_num) %>% 
  
  # de-duplicate rows  
  distinct() %>% 
  
  # convert date_onset to date class
  mutate(date_onset = mdy(date_onset)) %>% 
  mutate(date_report = mdy(date_report)) %>% 
  
  # convert age to numeric class
  mutate(age = as.numeric(age)) %>% 
  
  # convert "Unknown" gender to NA
  mutate(gender = na_if(gender, "Unknown")) %>% 
  
  # properly record missing values in many character columns
  mutate(across(.cols = where(is.character), .fns = na_if, "")) %>% 
  
  # re-code hospital column
  mutate(hospital = recode(hospital,
                           # for reference: OLD = NEW
                           "Mitilary Hospital"  = "Military Hospital",
                           "Port"               = "Port Hospital",
                           "Port Hopital"       = "Port Hospital",
                           "St. Mark's Maternity Hospital (SMMH)" = "SMMH")) %>% 
  
  # recode gender
  mutate(gender = recode(gender,
                         "m" = "male",
                         "f" = "female"))


# Class 4 -------------------------------------------------


surv <- surv_raw %>% 
  
  # automatically clean column names
  clean_names() %>% 
  
  # manually clean column names   
  rename(
    date_onset = onset_date,
    date_report = date_of_report,
    district_res = adm3_name_res,
    district_det = adm3_name_det) %>%
  
  # remove unnecessary column
  select(-row_num) %>% 
  
  # de-duplicate rows  
  distinct() %>% 
  
  # convert date_onset to date class
  mutate(date_onset = mdy(date_onset)) %>% 
  mutate(date_report = mdy(date_report)) %>% 
  
  # convert age to numeric class
  mutate(age = as.numeric(age)) %>% 
  
  # convert "Unknown" gender to NA
  mutate(gender = na_if(gender, "Unknown")) %>% 
  
  # properly record missing values in many character columns
  mutate(across(.cols = where(is.character), .fns = na_if, "")) %>% 
  
  # re-code hospital column
  mutate(hospital = recode(hospital,
                           # for reference: OLD = NEW
                           "Mitilary Hospital"  = "Military Hospital",
                           "Port"               = "Port Hospital",
                           "Port Hopital"       = "Port Hospital",
                           "St. Mark's Maternity Hospital (SMMH)" = "SMMH")) %>%
  
  # recode gender
  mutate(gender = recode(gender,
                         "m" = "male",
                         "f" = "female")) %>% 
  
  # convert negative weight values to NA
  mutate(wt_kg = ifelse(wt_kg < 0, NA, wt_kg))  %>% 
  
  # create case definition
  mutate(case_def = case_when(
    lab_confirmed == TRUE             ~ "Confirmed",
    epilink == "yes" & fever == "yes" ~ "Suspect",
    TRUE                              ~ "To investigate")) %>% 
  
  # create age-in-years
  mutate(age_years = case_when(
    age_unit == "months" ~ age/12,   # if age is given in months
    age_unit == "years"  ~ age,      # if age is given in years
    is.na(age_unit)      ~ age)) %>% # if unit missing assume years, else NA
  
  # create age category column
  mutate(age_cat = age_categories(         # create new column
    age_years,                             # numeric column to make groups from
    lower = 0,
    upper = 70,
    by = 10)) %>% 
  
  # Make date-difference column  
  mutate(diff = date_report - date_onset) %>% 
  
  # create column marking TRUE if district of residence and detection differ
  mutate(moved = district_res != district_det) %>% 
  
  # create new column that prioritizes district of detection
  mutate(district = coalesce(district_det, district_res)) %>% 
  
  # remove suspect cases
  filter(case_def == "Confirmed") %>% 
  
  # re-arrange columns
  select(case_id, starts_with("date"), diff, gender, age, age_unit, age_years,
         age_cat, hospital, district, district_res, district_det, moved, everything())


# Export cleaned file to the root folder of the R project  
export(surv, "surveillance_linelist_clean_20141201.csv")


# Export cleaned file  
export(surv, here("data", "clean", "surveillance_linelist_clean_20141201.rds"))





summary(surv$wt_kg)
# Summary tables ----------------------------------------------

# 31 have dif district of res and detection
surv %>% 
  tabyl(moved)

View(surv)

surv %>% 
  tabyl(moved, district_res)

surv %>% 
  tabyl(district, show_na = FALSE)

?tabyl

surv %>% 
  tabyl(district) %>% 
  adorn_totals() %>% 
  adorn_pct_formatting() %>% 
  arrange(desc(n))

surv %>% 
  tabyl(district) %>% 
  arrange(desc(n)) %>% 
  adorn_totals() %>% 
 
  adorn_pct_formatting() #shows the total at the bottom

 #dplyr functions
surv %>% 
  count(hospital)

hospital_counts <- surv %>% 
  count(hospital, district)

surv %>% 
  count(hospital, gender)

surv %>% 
  group_by(hospital) %>% 
  summarise(n_rows = n())

surv %>% 
  group_by(hospital) %>% 
  summarise(
    n_rows  = n(),                           # amount of rows per group
    age_avg = mean(age_years, na.rm = T),    # mean age in the group
    max_onset = max(date_onset, na.rm=T)     # latest onset date
  )

surv %>% 
  group_by(hospital) %>% 
  summarise(fem = sum(gender == "female", na.rm = TRUE))

surv %>% 
  group_by(hospital) %>% 
  summarise(fem = sum(
    gender == "female",
    na.rm = TRUE))

surv %>% 
  group_by(hospital) %>% 
  summarise(
    n_cases   = n(),
    males     = sum(gender == "male", na.rm=T),
    males_pct = males/n_cases
  ) #note that the percentage is in decimals

surv %>% 
  group_by(hospital) %>% 
  summarise(
    n_cases   = n(),
    males     = sum(gender == "male", na.rm=T),
    males_pct = percent(males/n_cases)
  )

surv %>% 
  group_by(hospital) %>% 
  summarise(
    mean_age = round(mean(age_years, na.rm = T), digits = 0)
  )

surv %>% 
  group_by(hospital) %>%                                     # get statistics for each hospital
  summarise(
    n_cases   = n(),                                         # number of rows (cases)
    max_onset = max(date_onset, na.rm = T),                  # latest onset date
    under5    = sum(age_years <= 5, na.rm = T),              # number of children under 5
    vomit_n   = sum(vomit == "yes", na.rm=T),                # number vomiting
    vomit_pct = percent(vomit_n / n_cases),                  # percent vomiting
    max_wt_male = max(wt_kg[gender == "male"], na.rm = T)) %>%     # max weight among men
  qflextable()

#saving the table

my_table <- surv %>% 
  group_by(hospital) %>%                                     # get statistics for each hospital
  summarise(
    n_cases   = n(),                                         # number of rows (cases)
    max_onset = max(date_onset, na.rm = T),                  # latest onset date
    under5    = sum(age_years <= 5, na.rm = T),              # number of children under 5
    vomit_n   = sum(vomit == "yes", na.rm=T),                # number vomiting
    vomit_pct = percent(vomit_n / n_cases),                  # percent vomiting
    max_wt_male = max(wt_kg[gender == "male"], na.rm = T)) %>%     # max weight among men
  qflextable()

save_as_docx(my_table, path = "hospital_table.docx")
save_as_image(my_table, path = "hospital_table.png")



# DATA VIS using (ggplot) -------------------------------------------------

#simple plots



ggplot( #opening a plot canvas
  data = surv, # selecting a dataset
  mapping= aes( # setting x
    x =age_years,
    y = ht_cm)
  ) +
  geom_point(color = "blue")



ggplot( #opening a plot canvas
  data = surv, # selecting a dataset
  mapping= aes( # setting x
    x =age_years,
    y = ht_cm,
  color = hospital)
 )+
  geom_point() +
  facet_wrap(~hospital)

 #Simple plots ex.
ggplot(data = surv)

ggplot(data = surv, mapping = aes(x = district, y = age_years))

ggplot( #opening a plot canvas
  data = surv, # selecting a dataset
  mapping= aes( # setting x
    x =district,
    y= age_years,
    fill = district,))+
geom_jitter()+
geom_violin(alpha = 0)+
labs(                                               # add labels to plot
  title = "Ebola Analysis",
  subtitle = "Surveillance",
  x = "District",
  y = "Age (years)",
  caption = "Among an Ebola outbreak, 2014",
  fill = "District"
)

# Testing Bar Plots
ggplot(
  data = surv, 
  mapping = aes(
    x = district,
    fill = fct_rev (age_cat)))+
  geom_bar()

#Adjacent bars
ggplot(data = surv, mapping = aes(x = district, fill = age_cat))+
  geom_bar(position = "dodge")

case_counts_district <- surv %>% 
  group_by(district) %>% 
  summarise(n_cases = n())

height_plot <- ggplot(data = surv, mapping = aes(x = age_years, y = ht_cm, color = gender))+
  geom_point()

ggMarginal(height_plot, groupFill = TRUE)


# adding smoothed means
ggplot(data = surv, mapping = aes(x = date_report, y = diff))+
  geom_point()+
  geom_smooth()

# Histogram Syntax
ggplot(
  data = surv, 
  mapping = aes(
    x = date_onset))+
  geom_histogram(fill = "darkgreen")

ggplot(
  data = surv, 
  mapping = aes(
    x = age_years, 
    fill = gender))+
  geom_histogram()

ggplot(data = surv, mapping = aes(x = age_years, fill = gender))+
  geom_histogram(bins = 100)

ggplot(data = surv, mapping = aes(x = age_years, fill = gender))+
  geom_histogram(bins = 5)

ggplot(data = surv, mapping = aes(x = age_years, fill = gender))+
  geom_histogram(binwidth = 5)

# Facets

ggplot(data = surv, mapping = aes(x = date_onset, fill = district))+
  geom_histogram()+
  facet_wrap(~ district)

# Scales, Labels, and Themes ----------------------------------------------

surv %>%
Filter(gender != "NA") %>%
  ggplot(
    mapping = aes(
    x = date_onset,
    fill = gender)
  )+
  geom_histogram() +
  scale_fill_manual(
    values = c("male" = "#4e2b87",
               "female" = "#20bf23"))
+
  scale_x_date(
    date_break = "1 month",
    date_labels ="%b %y"
  )+
  theme_classic()
  
  
  
  linelist %>% 
  filter(
    age > 25,
    district == "Bolo"
  )
  
  ggplot(
    data = surv,
    mapping = aes(
      x = district,
      fill = age_cat)) +
    geom_bar() +
    scale_fill_brewer(palette = "Pastel2",
                      na.value = "grey")
  #Continuous color scales
  ggplot(
    data = surv,
    mapping = aes(
      x = age_years,
      y = wt_kg,
      color = temp)) +
    geom_point()+
    scale_color_viridis_c(option = "inferno", na.value = "grey")
  # Adjusting Y axis
  ggplot(
    data = surv,
    mapping = aes(
      x = district,
      fill = gender)) +
    geom_bar() +
    scale_fill_viridis_d(na.value = "grey")+
  scale_y_continuous(breaks = seq(from = 0,
                                  to = 250,
                                  by = 25)+
                       expand = c(0,0))
 # Starting Scales at 0
  ggplot(
    data = surv,
    mapping = aes(
      x = district,
      fill = gender)) +
    geom_bar() +
    scale_fill_viridis_d(na.value = "grey") +
    scale_y_continuous(breaks = seq(from = 0,
                                    to = 250,
                                    by = 25),
                       expand = c(0,0)) +
    scale_x_discrete(expand = c(0,0))+ #Flip axis
    coord_flip()
  
  #Date axis labels
  ggplot(
    data = surv,
    mapping = aes(x = date_onset)) +
    geom_histogram()
  
  ggplot(
    data = surv,
    mapping = aes(x = date_onset)) +
    geom_histogram() +
    scale_x_date(date_breaks = "2 months",
                 date_labels = "%d %b \n %Y" )
  #date breaks
  ggplot(
    data = surv,
    mapping = aes(x = date_onset)) +
    geom_histogram() +
    scale_x_date(date_breaks = "2 months",
                 labels = label_date_short() )
  
  #Display percents 
  delay_1wk <- surv %>%                                      # begin with surveillance linelist
    mutate(diff_1wk = as.numeric(diff) > 7) %>%              # create column that is TRUE is diff is greater than 7
    group_by(week = floor_date(date_report, "week")) %>%     # create column "week" and group by it  
    summarise(                                               # begin summarise command     
      cases = n(),                                           # number of cases in the week
      delayed = sum(diff_1wk == TRUE, na.rm=T),              # number of delayed cases in the week 
      delayed_pct = delayed / cases)                         # calculate proportion
  
  
  
  ggplot(data = surv,
         mapping = aes(
           x = age_years,
           y = ht_cm,
           color = gender)) +
    geom_point(
      alpha = 0.7) +
    scale_color_brewer(
      palette = "Pastel2",
      na.value = "grey") +
    labs(
      title = "Height and age",
      subtitle = "All hospitals",
      x = "Age (years)",
      y = "Height (cm)",
      caption = "Fictional Ebola data",
      color = "Gender"
    ) +
    theme_classic(base_size = 16) +
    theme(
      legend.position = "bottom",                # move legend to bottom
      plot.title = element_text(color = "red",   # title color
                                size = 20,       # title font size
                                face = "bold"),  # title typeface
      axis.title.y = element_text(angle = 0))    # rotate y axis title to be horizontal
  
  

# Joining Data ------------------------------------------------------------

  hosp <- bind_rows(hosp_central, hosp_port, hosp_military, hosp_smmh, hosp_other, hosp_missing) 
  
  
  full_join(dataframe1, dataframe2,      
           by = c("age"    = "Ages",  # different column names
                  "gender" = "Sex",   # different column names
                  "city")             # both data frames have column "city"  
  )
  
  dim(surv)
  dim(hosp)
  
  surv %>% 
    count(case_id) %>% 
    filter(n > 1)
  # for each dataset, sort and print the first 10 identifier values
  
  #  surveillance dataset
  surv %>% 
    arrange(case_id) %>%
    pull(case_id) %>%
    head(10)
  
  #  hospital dataset
  hosp %>% 
    arrange(ID) %>% 
    pull(ID) %>% 
    head(10)
  
  full_join(surv, hosp, by = c("case_id" = "ID"))
  
  surv %>% colnames()
  
  hosp %>% colnames()
  
  
  # here Luong helped me put in the advanced piping to remove the duplicated variables
  test_join <- surv %>% 
    left_join(hosp %>% 
                select(c(ID, date_hospitalisation, time_admission, outcome, date_outcome)),
                 by = c("case_id" = "ID"))
  dim(test_join)
  
  hosp <- bind_rows(hosp_central, hosp_port, hosp_military,
                    hosp_smmh, hosp_other, hosp_missing) %>% 
    
    # select specific columns from hosp, and re-name ID as case_ID
    select(
      case_id = ID,          # select and rename
      date_hospitalisation,  # select
      time_admission,        # select
      date_outcome,          # select
      outcome)               # select
  
  combined <- left_join(surv, hosp, by = "case_id")
  
  combined <- left_join(combined, lab, by = "case_id")
  # Import lab data 
  # (add to the import section of your R script)
  investigations <- import(here("data", "raw", "case_investigations_20141201.xlsx")) %>% 
    # remove unnecessary columns  
    select(-c(age, age_unit, gender))
  
  # Join the two data frames with a left-join
  # (add to the joining section of your R script)
  combined <- left_join(combined, investigations, by = "case_id")
  
  # Clean the new columns that have been joined to 'combined'
  combined <- combined %>% 
    
    # convert all column names to lower case and remove spaces
    clean_names() %>% 
    
    # covert new columns to class date
    mutate(date_hospitalisation = mdy(date_hospitalisation),
           date_outcome         = mdy(date_outcome),
           date_infection       = ymd(date_infection)) %>% 
    
    # clean outcome and hospital missings
    mutate(outcome = na_if(outcome, ""),
           hospital = na_if(hospital, ""))
  
  

# Pivoting - Parent timelines------------------------------------------------------

  timelines <- combined %>% 
    arrange(date_onset) %>%                 
    head(5) %>%                            
    select(case_id, starts_with("date"))     
  
  
  #pivote dates longer
  
  timelines_long <- timelines %>% 
    pivot_longer(
      cols = starts_with("date"),
      names_to = "date_type",
      values_to = "date")
  
  ggplot(data = timelines_long,    # use the long dataset
         mapping = aes(
           x = date,               # dates of all types displayed along the x-axis
           y = case_id,            # case_id are discrete, character values
           color = date_type,      # color of the points
           shape = date_type,      # shape of the points
           group = case_id))+      # this makes the lines appear by color
    geom_point(size = 4)+            # show points
    geom_line()+                     # show lines
    theme_minimal()
  
  class(timelines_long$date_type)
  
  
  # Pivot dates longer
  timelines_long <- timelines %>% 
    
    # pivot the dataset longer
    pivot_longer(
      cols = starts_with("date"),
      names_to = "date_type",
      values_to = "date") %>% 
    
    # set the new column date_type as class factor, and define order for its values
    mutate(date_type = 
             fct_relevel(date_type, "date_infection", "date_onset", "date_report", 
                         "date_hospitalisation", "date_outcome"))
  
  class(timelines_long$date_type)

  levels(timelines_long$date_type)
  
  timelines_long %>% 
    ggplot(data = timelines_long,
           mapping = aes(
             x = date,
             y = case_id,
             color = date_type,
             shape = date_type,
             group = case_id))+
    geom_point(size = 4)+
    geom_line()+
    theme_minimal()
  
  ggplot(data = combined, 
         mapping = aes(
           x = date_onset,
           fill = district))+
    geom_histogram(binwidth = 7)
  
  
  ggplot(data = combined, 
         mapping = aes(x = date_onset,
           fill = fct_lump_n(district, 3)))+
    geom_histogram(binwidth = 7)+
    labs(fill = "District")
  
  
  

# 11/8 Advanced Plots -----------------------------------------------------

  combined %>% 
    mutate(week_onset = yearweek(date_onset, week_start = 1))
  
  combined %>% 
    mutate(week_onset = yearweek(date_onset, week_start = 1)) %>% 
    mutate(week_onset_date = as.Date(week_onset)) 
  
  
  combined <- combined %>% 
    mutate(week_onset      = yearweek(date_onset, week_start = 1), ## create week of onset variable  
           week_onset_date = as.Date(week_onset))                  ## create a date version 
 
   # Heat plots
  
  # count cases by hospital-week
  hospital_weeks_raw <- combined %>%
    count(hospital, week_onset_date) 
  
  # create longer dataset of all possible hospital-weeks
  expanded <- hospital_weeks_raw %>% 
    select(hospital, week_onset_date) %>%
    tidyr::expand(., week_onset_date, hospital)
  
  # merge so that all hospital-weeks are represented in the data
  hospital_weeks <- hospital_weeks_raw %>%      
    right_join(expanded) %>%                            
    mutate(n = replace_na(n, 0)) %>% 
    filter(week_onset_date >= ymd("2014-06-15"))
  
  head(hospital_weeks)    # print the first 6 rows
  
  ?geom_tile
  
  ggplot(data = hospital_weeks,
         mapping = aes(x = week_onset_date, y = hospital, fill = n)) +
    geom_tile()
  
  hospital_weeks_adjusted <- hospital_weeks %>%
    mutate(hospital = fct_explicit_na(hospital),
           hospital = fct_relevel(hospital, "Central Hospital", "Military Hospital", "Port Hospital", 
                                  "SMMH", "Other", "(missing)"))
  ggplot(data = hospital_weeks_adjusted)+
         geom_tile(aes(x = week_onset_date, y = hospital, fill = n))+
    scale_fill_gradient(low = "skyblue", high = "tomato")+
    scale_x_date(date_breaks = "2 weeks", labels = scales::label_date_short())+
                   labs(x= "Week of symptom onset", y= "Hospital", 
                        fill = "number of weekly cases")+
                   theme_minimal()
  #Setting up data and custom heat plot 
  age_outcome_summary <- combined %>%
    drop_na(gender, age_cat) %>%         # remove any NA values
    group_by(age_cat, gender) %>%        # group rows by age-gender groups
    summarise(                           # begin creating new summary columns
      n = n(),
      n_death = sum(outcome == "Death",  # sum the number of rows where outcome is Death
                    na.rm = TRUE),
      pct_death = n_death / n)           # create proportion dead in the group
  
  # make plot
  ggplot(data = age_outcome_summary,            # use new data frame
         mapping = aes(x = gender,              # gender on x-axis
                       y = age_cat,             # age category on y-axis
                       fill = pct_death)) +     # fill (color) is shaded by the proportion dead
    geom_tile() +                               # display data as tiles  
    scale_fill_viridis(                         # adjust colors scale
      option = "B",                             # pick any option
      limits = c(0, 1)) +                       # set the limits to go from 0 to 1
    geom_text(                                  # add text over the tiles
      mapping = aes(
        label = scales::percent(                # show percents instead of proportions
          pct_death,
          accuracy = 0.1)))+
    labs(x = "Gender",                          # add labels
         y = "Age categories",
         fill = "Percent of\ncases fatal") +
    scale_fill_continuous(                      # adjust the values displayed in the legend
      labels = scales::percent)                 # to be percents (not proportions)
  
  # Epi curves with calendar dates
  
  ggplot(data = combined, mapping = aes(x = date_onset)) +
    geom_histogram(binwidth = 5) +
    labs(x = "Date of onset", y = "Incidence") +
    theme_bw()
  
#Defining manual bins
  seq.Date(from = ymd("2014-05-06"),
           to = ymd("2014-11-28"),
           by = "week")
  
  
  ggplot(data = combined, aes(x = date_onset))+
    geom_histogram(
      breaks = seq.Date(
        from = ymd("2014-05-06"),
        to = ymd("2014-11-28"),
        by = "week")) +
    labs(x = "Date of onset", y = "Incidence") +
    theme_bw() 
  
  
  floor_date(ymd("2014-05-06"), unit = "week", week_start = 1)
  
  
  ceiling_date(ymd("2014-11-28"), unit = "week", week_start = 1)
  
  
  # Sequence of Mondays from before earliest case, to after latest case
  seq.Date(from = floor_date(ymd("2014-05-06"), unit = "week", week_start = 1),
           to =   ceiling_date(ymd("2014-11-28"), unit = "week", week_start = 1),
           by =   "week")
  
  seq.Date(from = floor_date(min(combined$date_onset, na.rm=T), unit = "week", week_start = 1),
           to =   ceiling_date(max(combined$date_onset, na.rm=T), unit = "week", week_start = 1),
           by =   "week")
  
  # Define and save the vector
  ebola_weeks <- seq.Date(
    from = floor_date(min(combined$date_onset, na.rm=T), unit = "week", week_start = 1),
    to =   ceiling_date(max(combined$date_onset, na.rm=T), unit = "week", week_start = 1),
    by =   "week")
  
  
  # Run the plot, using the vector
  ggplot(data = combined, aes(x = date_onset)) +
    geom_histogram(breaks = ebola_weeks, closed = "left") +
    labs(x = "Date of onset", y = "Incidence") +
    theme_bw()
  
  # Monthly Epidemic Curve 
  
  # define and save the vector (by month)
  ebola_months <- seq.Date(
    from = floor_date(min(combined$date_onset, na.rm=T), unit = "month"),
    to =   ceiling_date(max(combined$date_onset, na.rm=T), unit = "month"),
    by =   "month")
  
  # run the plot with monthly breaks, and fill
  ggplot(data = combined, aes(x = date_onset, fill = hospital)) +
    geom_histogram(breaks = ebola_months, closed = "left") +
    scale_x_date(
      date_breaks = "months",
      labels = scales::label_date_short())+
    labs(x = "Date of onset", y = "Incidence") +
    theme_bw()
  
  facet_wrap(~gender)
  
  ggplot(data = combined, aes(x = date_onset, fill = hospital)) +
    geom_histogram(breaks = ebola_months, closed = "left") +
    scale_x_date(
      date_breaks = "months",
      labels = scales::label_date_short())+
    labs(x = "Date of onset", y = "Incidence") +
    theme_bw()+
    facet_wrap(~hospital)
  
  
  # Week number epicurves
  all_weeks <- seq(min(combined$week_onset, na.rm = TRUE),
                   max(combined$week_onset, na.rm = TRUE),
                   by = 1) 
  
  all_weeks
  
  # weeks to dates
  all_weeks_date <-  as.Date(all_weeks)  
  
  all_weeks_date
  
  counts <- combined %>%
    filter(!is.na(week_onset_date)) %>%
    count(week_onset_date) %>%
    ## ensure that all weeks are present in the table, filled in with 0 as necessary
    as_tsibble() %>% 
    fill_gaps(n = 0)
  
  ## plot 
  counts %>%
    ggplot(aes(x = week_onset_date, y = n)) +        # n is the counts 
    geom_col(width = 7) +                            # for full-width weekly columns                             
    theme(axis.text.x = element_text(angle = 90)) +  # pivot the labels 90 degrees
    scale_x_date(
      breaks = all_weeks_date,
      labels = all_weeks)
  
  # Apyramid
  age_pyramid(data = combined,
              age_group = "age_cat", 
              #note that the column must be enclosed in quotation marks (" ")
              split_by = "gender")  
  
  age_pyramid(data = combined,
            age_group = "age_cat", #note that the column must be enclosed in quotation marks (" ")
            split_by = "gender",
            proportional = TRUE,
            na.rm = FALSE)
  #note that the column must be enclosed in quotation marks (" ")
  
  #Practice dataset
  
  # Creates the object demo_agg
  #############################
  demo_wide_counts <- structure(list(
    age_cat = structure(c(1L, 2L, 3L, 4L, 5L, 6L, 7L, 8L, NA),
                        .Label = c("0-9", "10-19", "20-29", "30-39", "40-49", "50-59", "60-69", "70+"), class = "factor"),
    female = c(149L, 104L, 55L, 15L, 4L, 1L, NA, NA, NA),
    male = c(96L, 80L, 65L, 39L, 19L, 5L, 5L, 1L, NA),
    missing_gender = c(5L, 4L, 4L, 2L, NA, NA, 1L, NA, 26L)),
    row.names = c(NA, -9L),
    class = c("tbl_df", "tbl", "data.frame"))
  
  demo_long_counts <- demo_wide_counts %>% 
    pivot_longer(
      col = c(female, male, missing_gender),    # cols to elongate
      names_to = "gender",                      # name for new col of categories
      values_to = "counts") %>%                 # name for new col of counts
    mutate(
      gender = na_if(gender, "missing_gender")) # convert "missing_gender" to NA
  
  age_pyramid(data = demo_long_counts,
              age_group = "age_cat", 
              split_by = "gender",
              count = "counts")
  
  # Adding GGplot to age pyramids
  # Age pyramid with ggplot modifications
  age_pyramid(
    data = combined,
    age_group = "age_cat",
    split_by = "gender",
    proportional = TRUE,
    show_midpoint = FALSE)+
    
    theme_minimal()+
    
    scale_fill_brewer(type = "qual", palette = 2)+
    
    labs(title = "Age and gender of confirmed cases",
         x = "Proportion of all cases",
         y = "Age group",
         caption = "Ebola outbreak",
         fill = "Gender")