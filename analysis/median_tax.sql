#!/bin/bash
psql -h 66.228.36.34 -p 5432 -U dataswap dataswap << EOF

--Create table for R1
drop table aggregated.R1_tax;
create table aggregated.R1_tax(

GEOID10 character(12),
av_2000 numeric, 
av_2001 numeric, 
av_2002 numeric, 
av_2003 numeric, 
av_2004 numeric, 
av_2005 numeric, 
av_2006 numeric, 
av_2007 numeric, 
av_2008 numeric, 
av_2009 numeric, 
av_2010 numeric, 
av_2011 numeric, 
av_2012 numeric, 
av_2013 numeric 
);

--load data for R1
\copy aggregated.R1_tax from '/home/tom/R/median_values_bg_R1.csv' with csv header delimiter as ',';

--Create table for R23
drop table aggregated.R23_tax;
create table aggregated.R23_tax(

GEOID10 character(12),
av_2000 numeric, 
av_2001 numeric, 
av_2002 numeric, 
av_2003 numeric, 
av_2004 numeric, 
av_2005 numeric, 
av_2006 numeric, 
av_2007 numeric, 
av_2008 numeric, 
av_2009 numeric, 
av_2010 numeric, 
av_2011 numeric, 
av_2012 numeric, 
av_2013 numeric 
);

--load data for R23
\copy aggregated.R23_tax from '/home/tom/R/median_values_bg_R23.csv' with csv header delimiter as ',';

--Create table for RCD
drop table aggregated.RCD_tax;
create table aggregated.RCD_tax(

GEOID10 character(12),
av_2000 numeric, 
av_2001 numeric, 
av_2002 numeric, 
av_2003 numeric, 
av_2004 numeric, 
av_2005 numeric, 
av_2006 numeric, 
av_2007 numeric, 
av_2008 numeric, 
av_2009 numeric, 
av_2010 numeric, 
av_2011 numeric, 
av_2012 numeric, 
av_2013 numeric 
);

--load data for RCD
\copy aggregated.RCD_tax from '/home/tom/R/median_values_bg_RCD.csv' with csv header delimiter as ',';
EOF