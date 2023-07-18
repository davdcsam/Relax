#include "enum.mqh"

MqlRates rates[];

input group "SuperTrend"

input int st_periode = 10; //Period

input double st_multiplier = 1; //Multiplier

input bool st_show_filling = true; //Show Filling

input type_color st_select_color = RED; //Color Count

input char st_count = 3; //Count Trend

string st_name = "..\\indicators\\st";

int st_h;

double st[];

type_color st_color[30];

type_color st_contrast_select_color;

string st_string;

turn trade_state = OFF;

void supertrend_onint()
    {
    
        st_h = iCustom( _Symbol, PERIOD_CURRENT, st_name, st_periode, st_multiplier, st_show_filling);
    
        ArraySetAsSeries(st, true);     
            
        ArraySetAsSeries(rates, true);
        
        if(st_select_color == RED) 
            {
                st_contrast_select_color = GREEN;
            } else if(st_select_color == GREEN) 
                        { 
                            st_contrast_select_color = RED;   
                        }

    }
    
void supertrend_ontick()
    {
        
        CopyBuffer(st_h, 2, 0, 30, st);
        
        CopyRates(_Symbol, 0, 0, 30, rates);
    
        for(int i = 1 ; i < 30; i++)
            {
            
                if(st[i-1] > rates[i-1].close) 
                    {
                    
                        st_color[i-1] = RED; 
                        
                    } else st_color[i-1] = GREEN;
           
            }
           
        st_string = 
            "\n" +
            "      ST " + DoubleToString(st[0], 3) + " | Period " + IntegerToString(st_periode) + " | Mult " + DoubleToString(st_multiplier, 1) + " | Color " + EnumToString(st_select_color) + " | Count " + IntegerToString(st_count) + 
            "\n" +
            "      " + 
            EnumToString(st_color[10]) + " 10 | " +
            EnumToString(st_color[9]) + " 9 | " + 
            EnumToString(st_color[8]) + " 8 | " + 
            EnumToString(st_color[7]) + " 7 | " + 
            EnumToString(st_color[6]) + " 6 | " + 
            EnumToString(st_color[5]) + " 5 | " + 
            EnumToString(st_color[4]) + " 4 | " + 
            EnumToString(st_color[3]) + " 3 | " + 
            EnumToString(st_color[2]) + " 2 | " + 
            EnumToString(st_color[1]) + " 1 | " + 
            EnumToString(st_color[0]) + " 0" +
            "\n";        
        
    }