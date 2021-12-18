% Simple test of how to use our script

% Assets names to retrieve data from
assets = ["VTI.US", "AAPL.US"];
% Initial and final date to retrieve data
init_date = '2018-01-01';
fin_date = '2021-12-13';

% We create a timetable with all labour days of that period
calendar = [datetime(init_date):datetime(fin_date)];
prices_data = timetable(calendar(~isweekend(calendar))'); 

% We read the data from EOD using our script, please use the test API token
% provided by them.
read_data = historicaldata(assets, init_date, fin_date);

% Once read we construct a final timetable by combining all possible days
% in case they were from two different stock markets
for c = 1:length(assets)
    prices=[read_data{c}.close];
    dates=string({read_data{c}.date});
    datos_tt = timetable(datetime(dates'),prices');
    prices_data = outerjoin(prices_data, datos_tt);
end

% Fill possible missing data for days that are not in common.
prices_data = fillmissing(prices_data, 'previous');
prices_data = fillmissing(prices_data, 'next'); 
prices_data = prices_data{:,1:end};

% We calculate a simple Portfolio with the read data.
RfReturn = 0.01;
RfVar=0.0001;
RfVol = sqrt(RfVar);
p = Portfolio('AssetList',assets,'NumAssets',length(assets),'RiskFreeRate',RfReturn);