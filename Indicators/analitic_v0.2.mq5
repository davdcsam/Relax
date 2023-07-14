#property copyright "Copyright 2023, DavdCsam"
#property link      "https://github.com/davdcsam"
#property version   "1.1"
#property indicator_chart_window
#property indicator_buffers 9
#property indicator_plots 2

#property indicator_label1  "Filling"
#property indicator_type1   DRAW_FILLING
#property indicator_color1  clrSkyBlue, clrPaleGreen

#property indicator_label2  "SuperTrend"
#property indicator_type2   DRAW_COLOR_LINE
#property indicator_color2  clrBlue, clrRed

input int    Periode = 10;
input double Multiplier = 1.0;
input bool   Show_Filling = false; // Show as DRAW_FILLING

double Filled_a[];
double Filled_b[];
double SuperTrend[];
double ColorBuffer[];
double Atr[];
double Up[];
double Down[];
double Middle[];
double trend[];

int atrHandle;
int changeOfTrend;
int flag;
int flagh;

datetime lastPrintTime = 0;

// Funcion de initacion 
int OnInit()
  {
//--- indicator buffers mapping
   SetIndexBuffer(0,Filled_a,INDICATOR_DATA);
   SetIndexBuffer(1,Filled_b,INDICATOR_DATA);
   SetIndexBuffer(2,SuperTrend,INDICATOR_DATA);
   SetIndexBuffer(3,ColorBuffer,INDICATOR_COLOR_INDEX);
   SetIndexBuffer(4,Atr,INDICATOR_CALCULATIONS);
   SetIndexBuffer(5,Up,INDICATOR_CALCULATIONS);
   SetIndexBuffer(6,Down,INDICATOR_CALCULATIONS);
   SetIndexBuffer(7,Middle,INDICATOR_CALCULATIONS);
   SetIndexBuffer(8,trend,INDICATOR_CALCULATIONS);

   atrHandle=iATR(_Symbol,_Period,Periode);

   return(0);
  }
// Funcion de interacion
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {

   int to_copy;
   
   if(prev_calculated>rates_total || prev_calculated<0) to_copy=rates_total;
      else
        {
         to_copy=rates_total-prev_calculated;
         if(prev_calculated>0) to_copy++;
        }

   if(IsStopped()) return(0); //Checking for stop flag
   
   if(CopyBuffer(atrHandle,0,0,to_copy,Atr)<=0)
     {
      Print("Getting Atr is failed! Error",GetLastError());
      return(0);
     }

   int first;
   
   if(prev_calculated>rates_total || prev_calculated<=0) // checking for the first start of calculation of an indicator
     {
      first=Periode; // starting index for calculation of all bars
     }
      else
        {
         first=prev_calculated-1; // starting number for calculation of new bars
        }
        
   for(int i=first; i<rates_total && !IsStopped(); i++)
     {
      Middle[i]=(high[i]+low[i])/2;
      Up[i]  = Middle[i] +(Multiplier*Atr[i]);
      Down[i]= Middle[i] -(Multiplier*Atr[i]);

      if(close[i]>Up[i-1]) 
        {
         trend[i]=1;
         if(trend[i-1]==-1) changeOfTrend=1;
        }
         else if(close[i]<Down[i-1]) 
           {
            trend[i]=-1;
            if(trend[i-1]==1) changeOfTrend=1;
           }
         else if(trend[i-1]==1) 
           {
            trend[i]=1;
            changeOfTrend=0;
           }
         else if(trend[i-1]==-1) 
           {
            trend[i]=-1;
            changeOfTrend=0;
           }

      if(trend[i]<0 && trend[i-1]>0) 
        {
         flag=1;
        }
         else 
           {
            flag=0;
           }
   
         if(trend[i]>0 && trend[i-1]<0) 
           {
            flagh=1;
           }
         else 
           {
            flagh=0;
           }

      if(trend[i]>0 && Down[i]<Down[i-1])
         Down[i]=Down[i-1];

      if(trend[i]<0 && Up[i]>Up[i-1])
         Up[i]=Up[i-1];

      if(flag==1)
         Up[i]=Middle[i]+(Multiplier*Atr[i]);

      if(flagh==1)
         Down[i]=Middle[i]-(Multiplier*Atr[i]);


//Dibuja el indicador
      if(trend[i]==1) 
        {
         SuperTrend[i]=Down[i];
         if(changeOfTrend==1) 
           {
            SuperTrend[i-1]=SuperTrend[i-2];
            changeOfTrend=0;
           }
         ColorBuffer[i]=0.0;
        }
      else if(trend[i]==-1) 
        {
         SuperTrend[i]=Up[i];
         if(changeOfTrend==1) 
           {
            SuperTrend[i-1]= SuperTrend[i-2];
            changeOfTrend = 0;
           }
         ColorBuffer[i]=1.0;
        }
     }
     
      int size_supertrend = ArraySize(SuperTrend); 
      
      ArraySetAsSeries(SuperTrend, true);

      EventSetTimer(1);  
     
      if (TimeCurrent() - lastPrintTime >= 10) 
      {

         Print(
            "ST price: ", NormalizeDouble(SuperTrend[0], 4)
            );
       
         static double last_super_trend;

         if (last_super_trend != NormalizeDouble(SuperTrend[0], 4)) 
         {                 
              int last_super_trend_h = FileOpen("Test.csv", FILE_READ|FILE_WRITE|FILE_CSV|FILE_ANSI, ",");
              
              FileSeek(last_super_trend_h, 4, SEEK_END);
               
              FileWrite(last_super_trend_h,
                  NormalizeDouble(SuperTrend[0], 4)
              );
                   
              FileClose(last_super_trend_h);
               
              last_super_trend = NormalizeDouble(SuperTrend[0],4);
         }
         
         lastPrintTime = TimeCurrent();
      }

      return(rates_total);
      
      ArraySetAsSeries(SuperTrend, false);
  }

