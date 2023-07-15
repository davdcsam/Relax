//+------------------------------------------------------------------+
//|                                                        Relax.mq5 |
//|                                         Copyright 2023, DavdCsam |
//|                                      https://github.com/davdcsam |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, DavdCsam"
#property link      "https://github.com/davdcsam"
#property version   "1.0"

#include  "features\\send_order.mq5"


enum turn
  {
      ON,
      OFF
  };

input string description_trade = "Data Trade";//...

input ENUM_ORDER_TYPE select_operation = ORDER_TYPE_BUY;// Select Type of Operation

input double lot = 1;//Lot Size

input double stoplose = 1500;//Stop Lose

input double takeprofit =  1500;//Take Profit

input uint magic_number = 666;//Magic Number

input int delay_time = 0; //Delay Time

input ulong deviation_trade = 10; //Deviation in Point

input turn only_me_index = ON; //Only Me /////////////////////////////////////

input int only_me_limit = 0; //Max Operation Open ///////////////////////////////

double price_ask;

double price_bid;

double tick_size;

string comment_trade;



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
        
        price_ask                              = SymbolInfoDouble( _Symbol, SYMBOL_ASK );
   
        price_bid                              = SymbolInfoDouble( _Symbol, SYMBOL_BID );
   
        tick_size                              = SymbolInfoDouble( _Symbol, SYMBOL_TRADE_TICK_SIZE );
   
        price_ask                              = round( price_ask / tick_size ) * tick_size;
   
        price_bid                              = round( price_bid / tick_size ) * tick_size;        
        
        CopyBuffer(st_h, 0, 0, 30, st_red);
       
        CopyBuffer(st_h, 1, 0, 30, st_green);
        
        CopyBuffer(st_h, 2, 0, 30, st);
        
        CopyRates(_Symbol, 0, 0, 30, rates);
        
        for(int i=1 ; i < 30; i++)
            {
            
                if(st_red[i-1] > rates[i-1].close) 
                    {
                    
                        st_color[i-1] = "RED"; 
                        
                    } else st_color[i-1] = "GREEN";
           
            }
        
    
        st_string = 
            " st red " + DoubleToString(st_red[0]) +
            " | " 
            " st green " + DoubleToString(st_green[0]) +
            " | "
            " st " + DoubleToString(st[0]);
    
        Comment(
            
                st_string
            
            );
            
    }