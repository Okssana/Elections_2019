library (data.table)
library(tidyr)
library(rvest)
library(xml2)

#Download files from the Central Comission web-site

registered_major <- for (n in c(11:40, 45:52, 57:60, 62:103, 105:107, 112:223, 226)){            #Numbers of voting districts, totally 198

  url_2019 <- paste0("https://www.cvk.gov.ua/pls/vnd2019/wp033pt001f01=919pf7331=", n ,".html")
  
  if(url.exists(url_2019) == TRUE){
    
    results_2019 <- read_html(url_2019)%>% 
    html_table(fill = TRUE)
    
    results_2019[[6]]%>%
      data.frame()
    
    
  }
  
  #dir.create("registered_major_2019")
  file <- paste0("registered_major_2019/dist_", n, ".csv")
  if (!file.exists(file)) write.csv(results_2019[[6]], file, fileEncoding = "UTF-8") 
  
  Sys.sleep(0.5)
}

  
#Merge CSV files
csv_files_results <- list.files (path = "C:/Users/user/Desktop/R_JOB/CVK_jails/jails/results_2019/", 
                                 pattern = "*.csv", 
                                 full.names = T)

# Import all CSV files

DATA_ALL_results <- as_tibble (rbindlist (lapply (csv_files_results, fread)))
