function eod_data = historicaldata(assets, date_init, date_end, api_token)
% 
% Inputs:
%
%   Assets:
%       A list with assets name. The name of the stocks/assets are
%       available at EOD Historical Data webpage.
%   Date init:
%       A string, with the following format 'yyyy-mm-dd', indicating the
%       initial date to retrieve historical data.
%   Date end:
%       A string, with the following format 'yyyy-mm-dd', indicating the
%       final date to retrieve historical data.
%   API Token:
%       A string with a valid API token provided by EOD Historical Data. If
%       API Token is not introduced, a promt will appear.
% Copyright (c) Alejandro Guerrero-López

addpath('./JSONio/')

if nargin < 4
    api_token = "";
end
if length(strsplit(date_init, '/'))>1 || length(strsplit(date_end, '/'))>1
    error("The date format expected is 'yyyy-mm-dd' not 'yyyy/mm/dd', fix it please.")
end
if length(api_token)<2
    api_token = inputdlg('Enter your EOD API key:', 'EOD API TOKEN', [1 50]);
end

eod_data=cell(1,length(assets));
for n=1:length(assets)
    urlString = ["https://eodhistoricaldata.com/api/eod/",assets(n),"?from=",date_init,"&to=",date_end,"&api_token=",api_token,"&period=d&fmt=json"];
    query = [];
    for c=1:length(urlString)
        query = strcat(query, urlString(c));
    end
    [s, success] = urlread(query);
    if success==0
        fprintf("The query failed")
    end
    eod_data{n} = jsonread(s);
end

end
