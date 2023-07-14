#property copyright "Copyright 2023, DavdCsam"
#property link      "https://github.com/davdcsam"
#property version   "1.1"
#property script_show_inputs

input int ATR_period = 10;
input double Multiplier = 1.0;

void OnTick() 
   {
   
     Comment(
     
     "Valor ATR: ", NormalizeDouble(ATR(0, ATR_period), _Digits), " | ", ATR_period
     
     );
   

   }

double ATR(int posicion, int periodos) 
   {   
   double ATR_array[];
   CopyBuffer(iATR(_Symbol, PERIOD_CURRENT, periodos), 0,0,3, ATR_array);
   ArraySetAsSeries(ATR_array, true);
  
   return(ATR_array[posicion]);
   }


