# EODConnector
EODConnector is a Matlab script that connects you to the [EOD Historical Data](https://eodhistoricaldata.com) market datafeed API. Given an API token it can retrieve any historical data of any asset/stock in EOD datafeed.

## Requirements

The [JSONio libray](https://github.com/gllmflndn/JSONio) is needed to properly read the EOD API data.

Also, you need a proper API token from [EOD Historical Data](https://eodhistoricaldata.com).

## Usage

This script is a plug-and-play script able to read prices data from EOD Historical Data API. Given a list of assets, an initial date and a final date this script is going to return you a list of _structs_ will all data from any available asset.

An example of how to use it could be:
'''
names = ["GSPC.INDX", "BCOMGC.INDX", "TNX.INDX", "AAPL.US"];
init_date = '2018-01-01';% 
fin_date = '2021-12-13';% 
read_data = historicaldata(names, init_date, fin_date)
'''

## Example

EOD provide a demo API key to retrieve info from AAPL and VTI: _OeAFFmMliFG5orCUuwAKQ8l4WWFQ67YX_

Then, we could do a simple script of how to retrieve info from AAPL and VTI from NASDAQ and combine it into the same timetable only keeping closing price of every day.
'''
names = ["VTI.US", "AAPL.US"];
init_date = '2018-01-01';
fin_date = '2021-12-13';
calendar = [datetime(init_date):datetime(fin_date)];
prices_data = timetable(calendar(~isweekend(calendar))'); 

read_data = historicaldata(names, fecha_inicio, fecha_fin);

for c = 1:length(names)
    prices=[read_data{c}.close];
    dates=string({read_data{c}.date});
    datos_tt = timetable(datetime(dates'),prices');
    prices_data = outerjoin(prices_data, datos_tt);
end
'''
