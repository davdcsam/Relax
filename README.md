# Relax

Relax fue creado davdcsam a petición del grupo de trading Project Crecer. Esta disponible en el repositorio https://github.com/davdcsam/Relax.

## Descripción General

El Relax es un bot que se basa en el indicador SuperTrend para identificar y seguir las tendencias del mercado. El Relax no tiene un mercado determinado, sino que puede operar en cualquier instrumento financiero disponible en las terminales de MetaTrader 5 (MT5). El bot puede usar diferentes períodos (diario, semanal, intradía, etc.) y ajustar el multiplicador del indicador y valores de entrada según las necesidades del operador. 

El indicador SuperTrend fue desarrollado por Olivier Seban y distribuido por FXGeed en el foro oficial de (MT5). El indicador combina el rango verdadero medio (ATR) con un multiplicador para calcular su valor. Sigue la siguiente formula:
ST = (High + Low) / 2 + (Multiplier) ∗ (ATR)

Este valor se suma o se resta al precio de cierre del activo para trazar la línea de ST. Cuando el precio está por encima de esta línea, el mercado se considera alcista, por defecto, la línea será color rojo. Por tanto, cuando el precio está por debajo de la línea, el mercado se considera bajista, color verde por defecto.

## Funcionamiento

Relax cuenta las velas consecutivas que siguen la misma dirección de la línea de SuperTrend. Cuando se cumple un número determinado de velas que se especifica en Count Trend. El bot abre una operación en la apertura de la siguiente vela, siguiendo la dirección de la línea de ST. La estrategia originalmente fue diseñada para operar a favor de la tendencia, es decir, abrir posiciones de compra en tendencias alcistas y posiciones de venta en tendencias bajistas. Sin embargo, se han añadido Color Trend que permiten operar en contra de la tendencia, aprovechando los movimientos oscilatorios de algunos mercados.

Los niveles de cierre de las operaciones son el stop loss y el take profit, que el operador define en los inputs. Estos niveles son los precios a los que el bot cerrará las operaciones con pérdida o con ganancia, respectivamente. Estos niveles deben ser determinados después de realizar un análisis de la volatilidad del instrumento financiero que se opera, para adaptarse a las condiciones actuales.
A continuación, unas imágenes del funcionamiento de Relax.
 
## Valores de entrada

### Data Trade

Select Type of Operation: Este input permite elegir el tipo de operación a realizar, que puede ser ORDER_TYPE_BUY o ORDER_TYPE_SELL. Esto determina si se abre una posición larga o corta en el mercado.

Stop loss and Take profit: Son dos niveles de precio que se utilizan para cerrar una operación con pérdida o con ganancia, respectivamente.

Lot Size: Este input permite determinar el tamaño del contrato, que es la cantidad de unidades del activo que se negocia. El tamaño del contrato influye en el riesgo y el beneficio de la operación.

Magic Number: Este input permite asignar un número identificador a cada operación abierta por el bot. Esto es útil para evitar interferencias entre los bots desplegados en diferentes gráficos o activos.

Deviation in Points: Puede ser positiva o negativa, dependiendo de si el precio ejecutado es mayor o menor que el precio solicitado. La desviación puede ocurrir por varios motivos, como la volatilidad del mercado, el deslizamiento, la latencia o los errores técnicos.

### SuperTrend

Period: Es el número de velas que se utilizan para calcular el rango verdadero medio (ATR), que es una medida de la volatilidad del mercado. El valor por defecto es 10, pero se puede ajustar según el marco de tiempo y la estrategia de trading que se utilice. Un valor más alto significa una menor sensibilidad a los cambios de precios, mientras que un valor más bajo significa una mayor sensibilidad.

Multuplier: Es el factor que se multiplica por el ATR para obtener el valor del indicador Supertrend. El valor por defecto es 3, pero se puede ajustar según el nivel de riesgo y la tendencia del mercado que se quiera seguir. Un valor más alto significa una mayor distancia entre la línea del indicador y los precios, lo que reduce las señales falsas, pero también las oportunidades de trading. Un valor más bajo significa una menor distancia entre la línea del indicador y los precios, lo que aumenta las señales falsas, pero también las oportunidades de trading.

Show Filling: Es una opción que permite mostrar o no el relleno entre la línea del indicador y los precios. El relleno puede ser de color verde o rojo, dependiendo de si la señal es alcista o bajista. El relleno puede ayudar a visualizar mejor la tendencia y los puntos de entrada.

Color Count: El color rojo indica una tendencia bajista, y el color verde indica una tendencia alcista.

Count Trend: Es el número de velas consecutivas que siguen la misma dirección de la tendencia, según la opción elegida en Definir tendencia. El valor por defecto es 3.
 
## Conclusión

Relax es un bot de trading que utiliza el indicador Supertrend para seguir las tendencias del mercado y abrir operaciones en consecuencia. El bot cuenta las velas consecutivas que confirman la tendencia y abre una operación en la apertura de la siguiente vela. El bot cierra la operación cuando el precio alcanza el nivel de stop loss o take profit, o cuando cruza la línea de Supertrend en sentido contrario.

Los resultados de la optimización y el filtrado de 160 backtesting no son alentadores. La mayoría de los backtesting muestran un drawdown de entre el 10% y el 30%, lo que indica un alto riesgo y una baja rentabilidad. La estrategia tiene una gestión pasiva del riesgo, que no se adapta a las condiciones cambiantes del mercado. Además, la estrategia depende mucho de los valores de entrada que se utilizan para el indicador Supertrend y el contador de velas, que pueden variar según el instrumento financiero y el marco de tiempo que se opera.

Algunas recomendaciones para mejorar la estrategia son las siguientes:
•	Utilizar otros indicadores o herramientas para complementar o confirmar las señales del indicador Supertrend, como el índice de fuerza relativa (RSI), las medias móviles (MA), el oscilador estocástico (STOCH), etc.
•	Utilizar una gestión activa del riesgo, que modifique el nivel de stop loss o take profit según el comportamiento del mercado, como el trailing stop, el breakeven, el cierre parcial, etc.
•	Realizar un análisis previo del mercado, para identificar los posibles escenarios y las oportunidades de trading, como los niveles de soporte y resistencia, las zonas de sobrecompra y sobreventa, los patrones de velas, etc.
•	Realizar un backtesting exhaustivo y riguroso, utilizando diferentes instrumentos financieros, marcos de tiempo, períodos históricos y valores de entrada, para evaluar el rendimiento y la robustez de la estrategia.
=======
# MQL5_Team
This is ExpertAbvisor than use the first strategic with SuperTrend Indicator


DAV
~/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Experts/Relax

SIL
~/AppData/Roaming/MetaQuotes/Terminal/BB16F565FAAA6B23A20C26C49416FF05/MQL5/Experts

HEN
~/AppData/Roaming/MetaQuotes/Terminal/D0E8209F77C8CF37AD8BF550E51FF075/MQL5/Experts

CAR
~/AppData/Roaming/MetaQuotes/Terminal/1640F6577B1C4EC659BF41EA9F6C38ED/MQL5/Experts
>>>>>>> 914561458cb247bf553b0b883828f064b4697034
