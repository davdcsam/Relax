//+------------------------------------------------------------------+
//|                                                        Relax.mq5 |
//|                                         Copyright 2023, DavdCsam |
//|                                      https://github.com/davdcsam |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, DavdCsam"
#property link      "https://github.com/davdcsam"
#property version   "1.0"

#include  "features\\timer.mqh"
#include  "features\\send_order.mqh"
#include  "features\\enum.mqh"

input string description_st = "SuperTrend"; //...

input int st_periode = 10; //Period

input double st_multiplier = 1; //Multiplier

input bool st_show_filling = true;

string st_name = "indicators\\st";

int st_h;

double st_red[];

double st_green[];

double st[];

string st_color[30];

string st_string;

turn color_status = OFF;

MqlTick tick[];

MqlRates rates[];


int OnInit() 
    {
        
        st_h = iCustom( _Symbol, PERIOD_CURRENT, st_name, st_periode, st_multiplier, st_show_filling);
    
        ArraySetAsSeries(st_red, true);
        
        ArraySetAsSeries(st_green, true);

        ArraySetAsSeries(st, true);     
            
        ArraySetAsSeries(rates, true);
    
        return( INIT_SUCCEEDED );
        
    }
    
void OnDeinit( const int reason ) 
    {

    }
    
void OnTick(void)
    {
         
        CopyBuffer(st_h, 0, 0, 30, st_red);
       
        CopyBuffer(st_h, 1, 0, 30, st_green);
        
        CopyBuffer(st_h, 2, 0, 30, st);
        
        CopyRates(_Symbol, 0, 0, 30, rates);
        
        remain_timer();
        
        for(int i = 1 ; i < 30; i++)
            {
            
                if(st_red[i-1] > rates[i-1].close) 
                    {
                    
                        st_color[i-1] = "RED"; 
                        
                    } else st_color[i-1] = "GREEN";
           
            }
            
        if(st_color[4] == "RED" && st_color[3] == "GREEN" && st_color[2] == "GREEN" && st_color[1] == "GREEN" && st_color[0] == "GREEN")
            {
                color_status = ON;    
            }

        if(color_status == ON && remain_time == current_period)        
            {
                
                color_status = OFF;
                
                if(select_operation == ORDER_TYPE_BUY) buy_function(); 
                
                else if(select_operation == ORDER_TYPE_SELL) sell_function();
                
            }   



        st_string = 
            "      st red " + DoubleToString(st_red[0], 3) +
            " | " 
            " st green " + DoubleToString(st_green[0], 3) +
            " | "
            " st " + DoubleToString(st[0], 3);
    
        Comment(
               "\n"  
               "      Time Broker                ",         current_time,
               "\n"
               "      Remain Time               ",          remain_time,
               "\n",               
               "      Status                        ",      EnumToString(color_status),  
               "\n",     
               st_string,
               "\n",                 
               "      ", st_color[4], " ",st_color[3], " ",st_color[2], " ",st_color[1], " ",st_color[0],
               "\n"       
            );
        
        Print(DoubleToString(st_red[0]));

    }