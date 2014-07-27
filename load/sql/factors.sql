-- make/drop table
-- run commands in psql or similar
drop table original.factors;
create table original.factors (
	geoid character(12),
	crime numeric
);

-- copy data from CSV
\COPY original.factors FROM '/Volumes/SaoirseMor/Dropbox/dataswap/output/data/data_tmp.csv' WITH CSV HEADER DELIMITER AS ',';


