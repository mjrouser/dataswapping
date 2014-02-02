--load data
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

--load data
\copy aggregated.R1_tax from 'F:/Data/median_values_bg_R1.csv' with csv header delimiter as ',';

