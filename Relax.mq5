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
#include  "features\\supertrend.mqh"
#include  "features\\last_error.mqh"

void operation_module()
    {
        switch(st_count)
            {
                case 1:
                    if(st_color[2] == st_contrast_select_color && st_color[1] == st_select_color && st_color[0] == st_select_color)
                        {
                            trade_state = ON;
                        }
                 break;
                                  
                case 2:
                    if(st_color[3] == st_contrast_select_color && st_color[2] == st_select_color && st_color[1] == st_select_color && st_color[0] == st_select_color)
                        {
                            trade_state = ON;
                        }
                 break;
                 
                case 3:
                    if(st_color[4] == st_contrast_select_color && st_color[3] == st_select_color && st_color[2] == st_select_color  && st_color[1] == st_select_color && st_color[0] == st_select_color)
                        {
                            trade_state = ON;
                        }
                 break;
                case 4:
                    if(st_color[5] == st_contrast_select_color && st_color[4] == st_select_color && st_color[3] == st_select_color  && st_color[2] == st_select_color && st_color[1] == st_select_color && st_color[0] == st_select_color)
                        {
                            trade_state = ON;
                        }
                 break;                 
                case 5:
                    if(st_color[6] == st_contrast_select_color && st_color[5] == st_select_color && st_color[4] == st_select_color  && st_color[3] == st_select_color && st_color[2] == st_select_color && st_color[1] == st_select_color && st_color[0] == st_select_color)
                        {
                            trade_state = ON;
                        }
                 break;
                 
                default:
                    last_error = "Out Range in Swicth Operator / Operation Module";
                 break;
            }
            
        if(trade_state == ON)        
            {   
                type_operation_function();
                
                trade_state = OFF;
            }            
    }

int OnInit() 
    {
        
        supertrend_onint();
    
        last_error_oninit();
    
        return( INIT_SUCCEEDED );
        
    }
    
void OnDeinit( const int reason ) 
    {

    }
    
void OnTick(void)
    {

        remain_timer();
        
        supertrend_ontick();
        
        send_order_ontick();
        
        if(remain_time == current_period)
            {
                operation_module();
            }
    
        Comment(
               "\n"  
               "      Time Broker                ",         current_time,
               "\n"
               "      Remain Time               ",          remain_time,
               "\n",
               send_order_string,
               st_string,
               "\n",
               "      Last Error [ ", last_error, " ]"              
            );

    }