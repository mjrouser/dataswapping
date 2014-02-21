#!/bin/bash
psql -h 66.228.36.34 -p 5432 -U dataswap dataswap << EOF

--Create table for R1
drop table aggregated.R1_tax;
create table aggregated.R1_tax(

GEOID10 character(12),
year numeric,
med_value numeric
);

--load data for R1
\copy aggregated.R1_tax from '/home/tom/dataswap_tax/analysis/median_values_bg_R1.csv' with csv header delimiter as ',';

--Create table for R23
drop table aggregated.R23_tax;
create table aggregated.R23_tax(

GEOID10 character(12),
year numeric,
med_value numeric
);

--load data for R23
\copy aggregated.R23_tax from '/home/tom/dataswap_tax/analysis/median_values_bg_R23.csv' with csv header delimiter as ',';

--Create table for CD
drop table aggregated.CD_tax;
create table aggregated.CD_tax(

GEOID10 character(12),
year numeric,
med_value numeric
);

--load data for CD
\copy aggregated.CD_tax from '/home/tom/dataswap_tax/analysis/median_values_bg_CD.csv' with csv header delimiter as ',';
EOF