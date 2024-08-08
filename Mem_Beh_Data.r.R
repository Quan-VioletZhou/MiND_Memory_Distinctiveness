#This script is to analyze memory tests in fMRI protocal for MiND study 
#Written by Violet Zhou in March 2022
library(dplyr)
library(tidyverse)
# Prompt for subject ID, for example just type: mindo100

subid <- readline(prompt="Enter subject ID: ") 

confirm <- readline(prompt=paste0("Is this the correct subject ID: ",subid,"     Type 1 to confirm, 0 to change."))

#loop and allow reconfirmation of subID
while(confirm == 0) {
  subid <- readline(prompt="Enter subject ID: ")
  confirm <- readline(prompt=paste0("Is this the correct subject ID: ",subid,"     Type 1 to confirm, 0 to change."))
}

wave <- readline(prompt="Enter Wave number: ")

#--------------------------Run_01---------------------------------------------------------------
#import the most recent fmri_memory Data Result for run_01
Memory_Data_01_raw <- read.csv(paste0("\\\\lsa-tpolk02-win.turbo.storage.umich.edu\\lsa-tpolk02\\migratedData\\MiND\\DataDump\\",subid,"\\",wave,"\\fmri_memory\\",subid,"-ItemContext_Berkeley_S016_Encoding_run2_Obj=Sce.log.csv"))
Memory_Data_01_raw <- Memory_Data_01_raw %>%
  mutate(row_id = row_number())
colnames(Memory_Data_01_raw)[1]<-"Subject"

#calculating how many responses are missing
missing_data_01_raw <- Memory_Data_01_raw %>% filter(Event.Type == lead(Event.Type) & Trial == "3" & Event.Type == "Picture")
missing_01 = nrow(missing_data_01_raw)

#Add one row after each missing stimuli, to indicate that hit is missing
missingRow <- data.frame(Subject = subid, Trial = '3', Event.Type = 'Response', Code = '0', Time = 0, TTime = 0, Uncertainty = NA, 
                         Duration = NA, Uncertainty.1 = NA, ReqTime = NA, ReqDur = NA, Stim.Type = NA, Pair.Index = NA, row_id = '0')

missing.ind_01 <- c(missing_data_01_raw$row_id)

if(length(missing.ind_01) != 0)
  { for (j in 1:missing_01)
    { i = missing.ind_01[1]
      Memory_Data_01_raw <- rbind(Memory_Data_01_raw[1:i, ],
                    missingRow,
                    Memory_Data_01_raw[-(1:i), ])
      Memory_Data_01_raw$row_id <- seq_len(nrow(Memory_Data_01_raw))
      missing_data_01 <- Memory_Data_01_raw %>% filter(Event.Type == lead(Event.Type) & Trial == "3" & Event.Type == "Picture")
      missing.ind_01 <- c(missing_data_01$row_id)
      j = j+1
    }
  } else
  {
    Memory_Data_01_raw <- Memory_Data_01_raw
  }

#data cleaning to delete multiple responses for one stimulus
Memory_Data_01 <- data.frame(Memory_Data_01_raw) %>% filter(Event.Type!=lead(Event.Type) & Trial == "3")

#grab stimulus type
Memory_Data_01 <- Memory_Data_01 %>% mutate(Type_Name = word(Code,start = 2, end = 3, sep = fixed("_")))
Memory_Data_01 <- Memory_Data_01 %>% fill(Type_Name, .direction = "down")

#coding for Response_Type
# 1:first_object correct 2:first_object incorrect;3:rep_object incorrect;4:rep_object correct;5:lure_object correct;6:lure_object incorrect;
# 7: first_room correct; 8:first_room incorrect; 9:rep_room incorrect; 10:rep_room correct; 11:lure_room correct; 12: lure_room incorrect; 13: missing
Memory_Data_01 <- Memory_Data_01%>%
  mutate(Response_Type = case_when(
    .$Code == 1 & lag(.$Type_Name == "first_object") ~ 1,
    .$Code == 2 & lag(.$Type_Name == "first_object") ~ 2,
    .$Code == 1 & lag(.$Type_Name == "rep_object") ~ 3, 
    .$Code == 2 & lag(.$Type_Name == "rep_object") ~ 4, 
    .$Code == 1 & lag(.$Type_Name == "lure_object") ~ 5, 
    .$Code == 2 & lag(.$Type_Name == "lure_object") ~ 6,
    .$Code == 1 & lag(.$Type_Name == "first_room") ~ 7,
    .$Code == 2 & lag(.$Type_Name == "first_room") ~ 8,
    .$Code == 1 & lag(.$Type_Name == "rep_room") ~ 9, 
    .$Code == 2 & lag(.$Type_Name == "rep_room") ~ 10, 
    .$Code == 1 & lag(.$Type_Name == "lure_room") ~ 11, 
    .$Code == 2 & lag(.$Type_Name == "lure_room") ~ 12,
    .$Code == 0 ~ 13
  ))
view(Memory_Data_01)

#calculate the responding time
Memory_Data_01 <- Memory_Data_01 %>% mutate(Respond_Time = Time - lag(Time))
Response_Data_01 <- Memory_Data_01 %>% filter(Event.Type == "Response")
view(Response_Data_01)

#calculating the sum up response for each type
rep_object_correct_01 = sum(Response_Data_01$Response_Type == 4)
lure_object_incorrect_01 = sum(Response_Data_01$Response_Type == 6)
rep_Object_count_01 = sum(Response_Data_01$Response_Type == 3| Response_Data_01$Response_Type == 4)
lure_Object_count_01 = sum(Response_Data_01$Response_Type == 5| Response_Data_01$Response_Type == 6)

rep_room_correct_01 = sum(Response_Data_01$Response_Type == 10)
lure_room_incorrect_01 = sum(Response_Data_01$Response_Type == 12)
rep_room_count_01 = sum(Response_Data_01$Response_Type == 9| Response_Data_01$Response_Type == 10)
lure_room_count_01 = sum(Response_Data_01$Response_Type == 11| Response_Data_01$Response_Type == 12)

# calculating the RT sum up for each type
object_RT_01 = sum(Response_Data_01[which(Response_Data_01$Response_Type == 3|Response_Data_01$Response_Type == 4|Response_Data_01$Response_Type == 5|Response_Data_01$Response_Type == 6),16])
room_RT_01 = sum(Response_Data_01[which(Response_Data_01$Response_Type == 9|Response_Data_01$Response_Type == 10|Response_Data_01$Response_Type == 11|Response_Data_01$Response_Type == 12),16])
object_hit_RT_01 = sum(Response_Data_01$Respond_Time[Response_Data_01$Response_Type == 4])
object_miss_RT_01 = sum(Response_Data_01$Respond_Time[Response_Data_01$Response_Type == 3])
object_CR_RT_01 = sum(Response_Data_01$Respond_Time[Response_Data_01$Response_Type == 5])
object_FA_RT_01 = sum(Response_Data_01$Respond_Time[Response_Data_01$Response_Type == 6])
room_hit_RT_01 = sum(Response_Data_01$Respond_Time[Response_Data_01$Response_Type == 10])
room_miss_RT_01 = sum(Response_Data_01$Respond_Time[Response_Data_01$Response_Type == 9])
room_CR_RT_01 = sum(Response_Data_01$Respond_Time[Response_Data_01$Response_Type == 11])
room_FA_RT_01 = sum(Response_Data_01$Respond_Time[Response_Data_01$Response_Type == 12])


#calculating hit rate/ false alarm/ corrected hit rate/ RT
Response_Data_01 <- Response_Data_01%>%
  mutate(R1_OHR = (sum(Response_Data_01$Response_Type == 4)/sum(Response_Data_01$Response_Type == 3| Response_Data_01$Response_Type == 4)), #object hit rate
         R1_OFA = (sum(Response_Data_01$Response_Type == 6)/sum(Response_Data_01$Response_Type == 5| Response_Data_01$Response_Type == 6)), #object false alarm
         R1_OCHR = (R1_OHR - R1_OFA), #object corrected hit rate
         R1_RHR = (sum(Response_Data_01$Response_Type == 10)/sum(Response_Data_01$Response_Type == 9| Response_Data_01$Response_Type == 10)), #room hit rate
         R1_RFA = (sum(Response_Data_01$Response_Type == 12)/sum(Response_Data_01$Response_Type == 11| Response_Data_01$Response_Type == 12)), #room false alarm
         R1_RCHR = (R1_RHR - R1_RFA), #room corrected hit rate
         
         R1_Avg_ORT = mean(Respond_Time[Response_Type == 3|Response_Type == 4|Response_Type == 5| Response_Type ==6]), #average responding time for objects
         R1_Avg_RRT = mean(Respond_Time[Response_Type == 9|Response_Type == 10|Response_Type == 11| Response_Type ==12]), #average responding time for rooms
         R1_Avg_RT = mean(Respond_Time), #average responding time
         
         R1_OH_RT = mean(Respond_Time[Response_Type == 4]), #response time for object hits
         R1_OM_RT = mean(Respond_Time[Response_Type == 3]), #response time for object misses
         R1_OCR_RT = mean(Respond_Time[Response_Type == 5]), #response time for object correct rejection
         R1_OFA_RT = mean(Respond_Time[Response_Type == 6]), #response time for object false alarms
         R1_RH_RT = mean(Respond_Time[Response_Type == 10]), #response time for room hits
         R1_RM_RT = mean(Respond_Time[Response_Type == 9]), #response time for room misses
         R1_RCR_RT = mean(Respond_Time[Response_Type == 11]), #response time for room correct rejection
         R1_RFA_RT = mean(Respond_Time[Response_Type == 12]), #response time for room false alarms
         R1_MR = (missing_01/((nrow(Response_Data_01)+missing_01))) #missing rate
  )
view(Response_Data_01)


#write to csv
write.csv(Response_Data_01, row.names = FALSE, file= paste0("\\\\lsa-tpolk02-win.turbo.storage.umich.edu\\lsa-tpolk02\\migratedData\\MiND\\DataDump\\",subid,"\\",wave,"\\fmri_memory\\",subid,"-ItemContext_Berkeley_S016_Encoding_run2_Obj=Sce.ResponseData.NEW.csv"))



#--------------------------Run_02---------------------------------------------------------------
#import the most recent fmri_memory Data Result for run_02
Memory_Data_02_raw <- read.csv(paste0("\\\\lsa-tpolk02-win.turbo.storage.umich.edu\\lsa-tpolk02\\migratedData\\MiND\\DataDump\\",subid,"\\",wave,"\\fmri_memory\\",subid,"-ItemContext_Berkeley_S018_Encoding_run1_Sce=Obj.log.csv"))
Memory_Data_02_raw <- Memory_Data_02_raw %>%
  mutate(row_id = row_number())
colnames(Memory_Data_02_raw)[1]<-"Subject"

#calculating how many responses are missing
missing_data_02_raw <- Memory_Data_02_raw %>% filter(Event.Type == lead(Event.Type) & Trial == "3" & Event.Type == "Picture")
missing_02 = nrow(missing_data_02_raw)

#Add one row after each missing stimuli, to indicate that hit is missing
missingRow <- data.frame(Subject = subid, Trial = '3', Event.Type = 'Response', Code = '0', Time = 0, TTime = 0, Uncertainty = NA, 
                         Duration = NA, Uncertainty.1 = NA, ReqTime = NA, ReqDur = NA, Stim.Type = NA, Pair.Index = NA, row_id = '0')

missing.ind_02 <- c(missing_data_02_raw$row_id)

if(length(missing.ind_02) != 0)
{ for (j in 1:missing_02)
{ i = missing.ind_02[1]
Memory_Data_02_raw <- rbind(Memory_Data_02_raw[1:i, ],
                            missingRow,
                            Memory_Data_02_raw[-(1:i), ])
Memory_Data_02_raw$row_id <- seq_len(nrow(Memory_Data_02_raw))
missing_data_02 <- Memory_Data_02_raw %>% filter(Event.Type == lead(Event.Type) & Trial == "3" & Event.Type == "Picture")
missing.ind_02 <- c(missing_data_02$row_id)
j = j+1
}
} else
{
  Memory_Data_02_raw <- Memory_Data_02_raw
}



#data cleaning to delete multiple responses for one stimulus
Memory_Data_02 <- data.frame(Memory_Data_02_raw) %>% filter(Event.Type!=lead(Event.Type) & Trial == "3")


#grab stimulus type
Memory_Data_02 <- Memory_Data_02 %>% mutate(Type_Name = word(Code,start = 2, end = 3, sep = fixed("_")))
Memory_Data_02 <- Memory_Data_02 %>% fill(Type_Name, .direction = "down")

#coding for Response_Type
# 1:first_object correct 2:first_object incorrect;3:rep_object incorrect;4:rep_object correct;5:lure_object correct;6:lure_object incorrect;
# 7: first_room correct; 8:first_room incorrect; 9:rep_room incorrect; 10:rep_room correct; 11:lure_room correct; 12: lure_room incorrect
Memory_Data_02 <- Memory_Data_02%>%
  mutate(Response_Type = case_when(
    .$Code == 1 & lag(.$Type_Name == "first_object") ~ 1,
    .$Code == 2 & lag(.$Type_Name == "first_object") ~ 2,
    .$Code == 1 & lag(.$Type_Name == "rep_object") ~ 3, 
    .$Code == 2 & lag(.$Type_Name == "rep_object") ~ 4, 
    .$Code == 1 & lag(.$Type_Name == "lure_object") ~ 5, 
    .$Code == 2 & lag(.$Type_Name == "lure_object") ~ 6,
    .$Code == 1 & lag(.$Type_Name == "first_room") ~ 7,
    .$Code == 2 & lag(.$Type_Name == "first_room") ~ 8,
    .$Code == 1 & lag(.$Type_Name == "rep_room") ~ 9, 
    .$Code == 2 & lag(.$Type_Name == "rep_room") ~ 10, 
    .$Code == 1 & lag(.$Type_Name == "lure_room") ~ 11, 
    .$Code == 2 & lag(.$Type_Name == "lure_room") ~ 12,
    .$Code == 0 ~ 13,
  ))
view(Memory_Data_02)

#calculate the responding time
Memory_Data_02 <- Memory_Data_02 %>% mutate(Respond_Time = Time - lag(Time))
Response_Data_02 <- Memory_Data_02 %>% filter(Event.Type == "Response")

#calculating the sum up response for each type
rep_object_correct_02 = sum(Response_Data_02$Response_Type == 4)
lure_object_incorrect_02 = sum(Response_Data_02$Response_Type == 6)
rep_Object_count_02 = sum(Response_Data_02$Response_Type == 3| Response_Data_02$Response_Type == 4)
lure_Object_count_02 = sum(Response_Data_02$Response_Type == 5| Response_Data_02$Response_Type == 6)

rep_room_correct_02 = sum(Response_Data_02$Response_Type == 10)
lure_room_incorrect_02 = sum(Response_Data_02$Response_Type == 12)
rep_room_count_02 = sum(Response_Data_02$Response_Type == 9| Response_Data_02$Response_Type == 10)
lure_room_count_02 = sum(Response_Data_02$Response_Type == 11| Response_Data_02$Response_Type == 12)

# calculating the RT sum up for each type
object_RT_02 = sum(Response_Data_02[which(Response_Data_02$Response_Type == 3|Response_Data_02$Response_Type == 4|Response_Data_02$Response_Type == 5|Response_Data_02$Response_Type == 6),16])
room_RT_02 = sum(Response_Data_02[which(Response_Data_02$Response_Type == 9|Response_Data_02$Response_Type == 10|Response_Data_02$Response_Type == 11|Response_Data_02$Response_Type == 12),16])
object_hit_RT_02 = sum(Response_Data_02$Respond_Time[Response_Data_02$Response_Type == 4])
object_miss_RT_02 = sum(Response_Data_02$Respond_Time[Response_Data_02$Response_Type == 3])
object_CR_RT_02 = sum(Response_Data_02$Respond_Time[Response_Data_02$Response_Type == 5])
object_FA_RT_02 = sum(Response_Data_02$Respond_Time[Response_Data_02$Response_Type == 6])
room_hit_RT_02 = sum(Response_Data_02$Respond_Time[Response_Data_02$Response_Type == 10])
room_miss_RT_02 = sum(Response_Data_02$Respond_Time[Response_Data_02$Response_Type == 9])
room_CR_RT_02 = sum(Response_Data_02$Respond_Time[Response_Data_02$Response_Type == 11])
room_FA_RT_02 = sum(Response_Data_02$Respond_Time[Response_Data_02$Response_Type == 12])


#calculating hit rate/ false alarm/ corrected hit rate
Response_Data_02 <- Response_Data_02%>%
  mutate(R2_OHR = (sum(Response_Data_02$Response_Type == 4)/sum(Response_Data_02$Response_Type == 3| Response_Data_02$Response_Type == 4)), #object hit rate
         R2_OFA = (sum(Response_Data_02$Response_Type == 6)/sum(Response_Data_02$Response_Type == 5| Response_Data_02$Response_Type == 6)), #object false alarm
         R2_OCHR = (R2_OHR - R2_OFA), #object corrected hit rate
         R2_RHR = (sum(Response_Data_02$Response_Type == 10)/sum(Response_Data_02$Response_Type == 9| Response_Data_02$Response_Type == 10)), #room hit rate
         R2_RFA = (sum(Response_Data_02$Response_Type == 12)/sum(Response_Data_02$Response_Type == 11| Response_Data_02$Response_Type == 12)), #room false alarm
         R2_RCHR = (R2_RHR - R2_RFA), #room corrected hit rate
         R2_Avg_ORT = mean(Respond_Time[Response_Type == 3|Response_Type == 4|Response_Type == 5| Response_Type ==6]), #average responding time for objects
         R2_Avg_RRT = mean(Respond_Time[Response_Type == 9|Response_Type == 10|Response_Type == 11| Response_Type ==12]), #average responding time for rooms
         R2_Avg_RT = mean(Respond_Time), #average responding time
         R2_OH_RT = mean(Respond_Time[Response_Type == 4]), #response time for object hits
         R2_OM_RT = mean(Respond_Time[Response_Type == 3]), #response time for object misses
         R2_OCR_RT = mean(Respond_Time[Response_Type == 5]), #response time for object correct rejection
         R2_OFA_RT = mean(Respond_Time[Response_Type == 6]), #response time for object false alarms
         R2_RH_RT = mean(Respond_Time[Response_Type == 10]), #response time for room hits
         R2_RM_RT = mean(Respond_Time[Response_Type == 9]), #response time for room misses
         R2_RCR_RT = mean(Respond_Time[Response_Type == 11]), #response time for room correct rejection
         R2_RFA_RT = mean(Respond_Time[Response_Type == 12]), #response time for room false alarms
         R2_MR = (missing_02/((nrow(Response_Data_02)+missing_02))) #missing rate
  )
view(Response_Data_02)

#write to csv
write.csv(Response_Data_02, row.names = FALSE, file= paste0("\\\\lsa-tpolk02-win.turbo.storage.umich.edu\\lsa-tpolk02\\migratedData\\MiND\\DataDump\\",subid,"\\",wave,"\\fmri_memory\\",subid,"-ItemContext_Berkeley_S018_Encoding_run1_Sce=Obj.ResponseData.NEW.csv"))

#--------------------------Output_Response_Run01+Run02---------------------------------------------------------------
Response_Data_all <- data.frame(
  OHR_all = (rep_object_correct_01 + rep_object_correct_02) / (rep_Object_count_01 + rep_Object_count_02),
  OFA_all = (lure_object_incorrect_01 + lure_object_incorrect_02) / (lure_Object_count_01 + lure_Object_count_02),
  #OCHR_all = (Response_Data_all$OHR_all - Response_Data_all$OFA_all), 
  RHR_all = (rep_room_correct_01 + rep_room_correct_02) / (rep_room_count_01 + rep_room_count_02),
  RFA_all = (lure_room_incorrect_01 + lure_room_incorrect_02) / (lure_room_count_01 + lure_room_count_02),
  #RCHR_all = (Response_Data_all$RHR_all - Response_Data_all$RFA_all),
  Avg_ORT_all = (object_RT_01 + object_RT_02) / (rep_Object_count_01 + rep_Object_count_02 + lure_Object_count_01 + lure_Object_count_02),
  Avg_RRT_all = (room_RT_01 + room_RT_02) / (rep_room_count_01 + rep_room_count_02 + lure_room_count_01 + lure_room_count_02),
  Avg_RT_all = (object_RT_01 + object_RT_02 + room_RT_01 + room_RT_02) / (rep_Object_count_01 + rep_Object_count_02 + lure_Object_count_01 + lure_Object_count_02 + rep_room_count_01 + rep_room_count_02 + lure_room_count_01 + lure_room_count_02),
  OH_RT_all = (object_hit_RT_01 + object_hit_RT_02) / (rep_object_correct_01 + rep_object_correct_02),
  OM_RT_all = (object_miss_RT_01 + object_miss_RT_02) / (rep_Object_count_01 - rep_object_correct_01 + rep_Object_count_02 - rep_object_correct_02),
  OCR_RT_all = (object_CR_RT_01 + object_CR_RT_02) / (lure_Object_count_01 - lure_object_incorrect_01 + lure_Object_count_02 - lure_object_incorrect_02),
  OFA_RT_all = (object_FA_RT_01 + object_FA_RT_02) / (lure_object_incorrect_01 + lure_object_incorrect_02),
  RH_RT_all = (room_hit_RT_01 + room_hit_RT_02) / (rep_room_correct_01 + rep_room_correct_02),
  RM_RT_all = (room_miss_RT_01 + room_miss_RT_02) / (rep_room_count_01 - rep_room_correct_01 + rep_room_count_02 - rep_room_correct_02),
  RCR_RT_all = (room_CR_RT_01 + room_CR_RT_02) / (lure_room_count_01 - lure_room_incorrect_01 + lure_room_count_02 - lure_room_incorrect_02),
  RFA_RT_all = (room_FA_RT_01 + room_FA_RT_02) / (lure_room_incorrect_01 + lure_room_incorrect_02),
  MR_all = (missing_01 + missing_02) /((nrow(Response_Data_02)+missing_02) + (nrow(Response_Data_01)+missing_01))
  )

Response_Data_all %>% mutate(
  OCHR_all = (OHR_all - OFA_all),
  RCHR_all = (RHR_all - RFA_all)
)
view(Response_Data_all)


#write to csv
write.csv(Response_Data_all, row.names = FALSE, file= paste0("\\\\lsa-tpolk02-win.turbo.storage.umich.edu\\lsa-tpolk02\\migratedData\\MiND\\DataDump\\",subid,"\\",wave,"\\fmri_memory\\",subid,"memory_task_all_Sce=Obj.ResponseData.NEW.csv"))


