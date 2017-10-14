--standart schema
create table metrics (
id serial, 
name varchar(15), 
min_zn float, 
max_zn float
);
--modified schema
create table metrics (
id serial, 
name varchar(15), 
min_zn float, 
max_zn float,
function text, -- function
is_have_dependency boolean -- field for check dependency
);

create table metric_dependency(
id serial,
metric_id integer references metric.id, -- id of current metric 
dependency_id integer references metric.id, -- id of dependency
parametr_number integer -- number of parametr in metric's function
);

