*import full data
insheet using "C:\Users\Ashley\Desktop\full_data_super.csv", comma

*collapse data
collapse (sum)  count_firms sales_vol count_empl count_newfirms count_closedfirms total_311 problem nonemp total_911 disorder \\\
violent permit_count count_inspect count_inspecttrash count_inspectmaintain alarm_count total_loss count_crimex count_robberyx \\\
count_burglaryx count_domesticx count_weaponx count_crimey count_robberyy count_burglaryy count_domesticy count_weapony count_assault \\\
(mean)  popu popden landarea pctnhwh pctbl pctasian pcthisp households pcthhs_child pcthhs_femchild avghhsize medhhinc medhhincbl \\\
medhhincasian medhhinchisp medhhincnhwh units pctown pctrent pctvacant medyrbuilt medvalue medrent pctchild pctold pctcollege pctemployed pctpoverty, by(geoid10)

*do factor analysis with all variables, pcf
factor  count_firms sales_vol count_empl count_newfirms count_closedfirms total_311 problem nonemp total_911 disorder violent \\\
permit_count count_inspect count_inspecttrash count_inspectmaintain alarm_count total_loss count_crimex count_robberyx count_burglaryx \\\
count_domesticx count_weaponx count_crimey count_robberyy count_burglaryy count_domesticy count_weapony count_assault, pcf

*varimax rotate
rotate

*generate factor variables
predict factor1 factor2 factor3 factor4 factor5 factor6

*separate factor analysis for each factor
factor  total_911 disorder violent count_crimex count_robberyx count_burglaryx count_domesticx count_weaponx count_assault, pcf
rotate
predict crime_factor

factor  count_firms sales_vol count_empl count_newfirms count_closedfirms total_911, pcf
rotate
predict biz_factor

factor  total_311 problem nonemp permit_count, pcf
rotate
predict 3info_factor

factor  count_inspect count_inspecttrash count_inspectmaintain, pcf
rotate
predict inspection_factor

factor  alarm_count total_loss, pcf
rotate 
predict fire_factor



