drop table original.acs_data;
create table original.acs_data (
	bg_id numeric, 
	popu numeric, 
	popden numeric, 
	landarea numeric, 
	pctnhwh numeric, 
	pctbl numeric, 
	pctasian numeric, 
	pcthisp numeric, 
	households numeric, 
	pcthhs_child numeric, 
	pcthhs_femchild numeric, 
	avghhsize numeric, 
	medhhinc numeric, 
	medhhincbl numeric, 
	medhhincasian numeric, 
	medhhinchisp numeric, 
	medhhincnhwh numeric, 
	units numeric, 
	pctown numeric, 
	pctrent numeric, 
	pctvacant numeric, 
	medyrbuilt numeric, 
	medvalue numeric, 
	medrent numeric, 
	pctchild numeric, 
	pctold numeric, 
	pctcollege numeric, 
	pctemployed numeric, 
	pctpoverty numeric
);

-- copy data from CSV
\COPY original.acs_data FROM '/Volumes/SaoirseMor/Dropbox/dataswap/ACS_2008_2012/acs0812_bg_suffolk_clean.csv' WITH CSV HEADER DELIMITER AS ',';
