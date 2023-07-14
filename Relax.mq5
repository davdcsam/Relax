//+------------------------------------------------------------------+
//|                                                        Relax.mq5 |
//|                                         Copyright 2023, DavdCsam |
//|                                      https://github.com/davdcsam |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, DavdCsam"
#property link      "https://github.com/davdcsam"
#property version   "1.0"

input int st_periode = 10; //Period

input double st_multiplier = 1; //Multiplier

double st_show_filling = true;

string st_name = "indicators\\st";

int st_h;

double st_red[];

double st_green[];

double st[];

//  string st_color[30];

string st_string;


int OnInit() 
    {
        
        st_h = iCustom( _Symbol, PERIOD_CURRENT, st_name, st_periode, st_multiplier, st_show_filling);
    
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

/*        
        for(int i=0 ; i < 30; i++)
            {
           
                if(st_red[i] > st_green[i]) 
                    {
                    
                        st_color[i] = "RED"; 
                        
                    } else st_color[i] = "GREEN";
           
            }
*/    
        st_string = 
            " st red " + DoubleToString(st_red[0]) +
            " | " 
            " st green " + DoubleToString(st_green[0]) +
            " | "
            " st " + DoubleToString(st[0]);
    
        Comment(
            
                st_string
            
            );
        
        Print(st_string);
    
    
    }