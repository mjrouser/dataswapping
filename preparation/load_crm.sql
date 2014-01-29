drop table crm_data;
create table crm_data (
	x  numeric,
	y numeric, 
	x_alt numeric, 
	y_alt numeric, 
	propid character varying(7), 
	opendate date, 
	subject character varying(50), 
	reason character varying(50), 
	type character varying(50), 
	channel character varying(50), 
	source character varying(50), 
	unciviluse integer, 
	housing integer,    
	bigbuilt integer, 
	graffiti integer, 
	trash integer, 
	privateneglect integer, 
	problem integer, 
	publicdenig integer
);