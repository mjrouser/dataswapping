clear
*import full data
insheet using "C:\Users\Jackie\Dropbox\Civic Tech\Dataswap\dataswap\Tax Assessor's Database and Auxiliary Data\output\data\full_data_super.csv", comma

*collapse data
collapse (sum) count_firms sales_vol count_empl count_newfirms count_closedfirms total_311 problem nonemp total_911 disorder violent permit_count count_inspect count_inspecttrash count_inspectmaintain alarm_count total_loss count_crime count_robbery count_burglary count_domestic count_weapon count_assault, by(geoid10)
*do factor analysis with all variables, pcf
factor  count_firms sales_vol count_empl count_newfirms count_closedfirms total_311 problem nonemp total_911 disorder violent permit_count count_inspect count_inspecttrash count_inspectmaintain alarm_count total_loss count_crime count_robbery count_burglary count_domestic count_weapon count_assault, pcf

*varimax rotate
rotate

*generate factor variables
predict factor1 factor2 factor3 factor4 factor5 factor6

*separate factor analysis for each factor
factor  total_911 disorder violent count_crime count_robbery count_burglary count_domestic count_weapon count_assault, pcf
rotate
predict crime_factor

factor  count_firms sales_vol count_empl count_newfirms count_closedfirms total_911, pcf
rotate
predict biz_factor

factor  total_311 problem nonemp permit_count, pcf
rotate
predict info_factor

factor  count_inspect count_inspecttrash count_inspectmaintain, pcf
rotate
predict inspection_factor

factor  alarm_count total_loss, pcf
rotate 
predict fire_factor

save "C:\Users\Jackie\Documents\GitHub\dataswap_tax\analysis\full_data_factors.dta"


