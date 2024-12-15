CREATE TABLE item ( 
id bigint NOT NULL,
name VARCHAR(256) NOT NULL,
item_number VARCHAR(31) NOT NULL
);
ALTER TABLE item ADD PRIMARY KEY (id);

insert into item (id, name, item_number) values (10, 'item1', '20241215042500');
insert into item (id, name, item_number) values (20, 'item2', '20241215042510');
insert into item (id, name, item_number) values (30, 'item3', '20241215042520');
insert into item (id, name, item_number) values (40, 'item4', '20241215042530');

select * from item order by item_number::numeric asc;

ALTER TABLE item ALTER COLUMN item_number TYPE NUMERIC USING item_number::numeric;

select * from item order by item_number asc;

CREATE SEQUENCE "item_item_number_seq";
select setval('item_item_number_seq', cast((select coalesce(max(item_number),1) from item) as bigint));

ALTER TABLE item
   ALTER COLUMN item_number SET DEFAULT nextval('item_item_number_seq');
   
insert into item (id, name) values (55, 'item5');
insert into item (id, name) values (66, 'item6');
insert into item (id, name) values (77, 'item7');

