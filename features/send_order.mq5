#include "..\\Relax.mq5"

MqlTradeRequest request_trade                = {};
        
MqlTradeResult result_trade                  = {};

void sell_function()
    {
        
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
