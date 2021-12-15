CREATE TABLE sensor(
	id   integer ,
	type_id integer,
    code text ,
    latitude   double precision,
    longitude   double precision,
    row   integer,
    "column"        integer,
    value         integer,
    date timestamp without time zone ,
    PRIMARY KEY(id,type_id)

)

"SELECT id, code, latitude, longitude, row, sensor.column, value, date, type_id FROM sensor"