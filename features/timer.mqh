#include "enum.mqh"

#resource "\\Experts\\Relax\\resource\\alert.wav"

input string description_remain = "       Remain Alert to Next End Candle";// ...

input turn active_remain_time_alert = ON; // Active Remain Alert

input int alert_remain_time = 6; // Seconds to Alert

datetime start_time = TimeCurrent();

datetime local_start_time = TimeLocal();

datetime current_time;

int remain_time;

int Hours; 

int Minutes; 

int Seconds;

MqlDateTime DateTimeStructure;

int period = _Period;

int m1_to_seconds = 60;

int current_period;

void remain_timer() 
    {
    
        period = _Period;

        current_period = period * m1_to_seconds - delay_time;
   
        current_time = TimeCurrent();
    
        remain_time = (int)( ( (TimeCurrent() / (Period() *60)) * Period() * 60 + Period() * 60 ) - current_time );
      
        TimeToStruct(current_time, DateTimeStructure);
       
        Hours = DateTimeStructure.hour;
       
        Minutes = DateTimeStructure.min;
       
        Seconds = DateTimeStructure.sec + 1;
       
        if(alert_remain_time == remain_time && active_remain_time_alert == ON)
            {
         
                PlaySound("\\Experts\\Relax\\resource\\alert.wav");
          
            }

}