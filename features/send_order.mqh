#include "enum.mqh"

MqlTradeRequest request_trade = {};
        
MqlTradeResult result_trade = {};

input string description_trade = "       Data Trade";//...

input ENUM_ORDER_TYPE select_operation = ORDER_TYPE_BUY;// Select Type of Operation

input double lot = 1;//Lot Size

input double stoplose = 1500;//Stop Lose

input double takeprofit =  1500;//Take Profit

input uint magic_number = 666;//Magic Number

input ulong deviation_trade = 10; //Deviation in Point

double price_ask;

double price_bid;

double tick_size;

string comment_trade;

string send_order_string;

void type_operation_function()
    {
   
        if(select_operation == ORDER_TYPE_BUY)
            {
   
                buy_function();
   
            } else if(select_operation == ORDER_TYPE_SELL)
                        {
   
                            sell_function();
   
                        }

    } 

void sell_function()
    {
    
        price_ask                              = SymbolInfoDouble( _Symbol, SYMBOL_ASK );
   
        price_bid                              = SymbolInfoDouble( _Symbol, SYMBOL_BID );
   
        tick_size                              = SymbolInfoDouble( _Symbol, SYMBOL_TRADE_TICK_SIZE );
   
        price_ask                              = round( price_ask / tick_size ) * tick_size;
   
        price_bid                              = round( price_bid / tick_size ) * tick_size;          
        
        Print( "Sending SELL order in ", _Symbol, " with ", magic_number ); 
   
        comment_trade                          = EnumToString( select_operation ) + " " + _Symbol + " with " + string( magic_number );
   
        request_trade.action                   = TRADE_ACTION_DEAL;
   
        request_trade.symbol                   = _Symbol;
   
        request_trade.volume                   = lot;
   
        request_trade.type                     = ORDER_TYPE_SELL;
   
        request_trade.price                    = price_bid;
   
        request_trade.sl                       = ( request_trade.price + stoplose * _Point );
      
        request_trade.tp                       = ( request_trade.price - takeprofit * _Point );
   
        request_trade.deviation                = deviation_trade;
   
        request_trade.magic                    = magic_number;
   
        request_trade.comment                  = comment_trade;
   
        if( !OrderSend( request_trade, result_trade ) )
            {
   
                Alert( "Error sending order, code: ", GetLastError() );
   
            } else Print( request_trade.symbol, " Operation ", EnumToString( select_operation ), " ", result_trade.retcode, " ", " | Lot ", request_trade.volume, " Price ", DoubleToString( result_trade.price, _Digits ) );

    }
  
void buy_function()
    {
    
        price_ask                              = SymbolInfoDouble( _Symbol, SYMBOL_ASK );
   
        price_bid                              = SymbolInfoDouble( _Symbol, SYMBOL_BID );
   
        tick_size                              = SymbolInfoDouble( _Symbol, SYMBOL_TRADE_TICK_SIZE );
   
        price_ask                              = round( price_ask / tick_size ) * tick_size;
   
        price_bid                              = round( price_bid / tick_size ) * tick_size;        
        
        Print( "Sending BUY order in ", _Symbol, " with ", magic_number );
   
        request_trade.action                   = TRADE_ACTION_DEAL;
   
        request_trade.symbol                   = _Symbol;
   
        request_trade.volume                   = lot;
   
        request_trade.type                     = ORDER_TYPE_BUY;
   
        request_trade.price                    = price_ask;
   
        request_trade.sl                       = ( request_trade.price - stoplose * _Point );
        
        request_trade.tp                 = ( request_trade.price + takeprofit * _Point );

        request_trade.deviation                = deviation_trade;
   
        request_trade.magic                    = magic_number;
   
        request_trade.comment                  = comment_trade;
   
        if( !OrderSend( request_trade, result_trade ) )
            {
   
                Alert( "Error en el envio de la orden", GetLastError() );
   
            } else Print( request_trade.symbol, " Operation ", EnumToString( select_operation ), " ", result_trade.retcode, " ", " | Lot ", request_trade.volume, " Price ", DoubleToString( result_trade.price, _Digits ) );

    }
    
void send_order_ontick()
    {
    
        send_order_string =
            "\n" +
            "      Type of Operation        "       + EnumToString( select_operation ) +
            "\n"
            "      Lot Size                      "  + DoubleToString( lot, _Digits ) +
            "\n"
            "      Stop Lose                   "    + DoubleToString( stoplose, 0 ) +
            "\n"
            "      Take Profit                  "   + DoubleToString( takeprofit, 0 ) +
            "\n";    
    
    
    }