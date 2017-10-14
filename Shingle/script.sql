--init schema 
create table genetic(
id serial,
document_id integer,
kshingle integer,
word varchar(20)
);

-- function for two unique set 
-- for 2-kshingle 1
-- for 5-kshingle 1
-- for 9-kshingle 0.638
create function get_shingle_unique(_shin integer, _doc1 integer, _doc2 integer) returns real as $BODY$ 
begin
return (select (select count(*) from ((
select word from genetic where document_id = _doc1 and kshingle = _shin)
intersect
(select word from genetic where document_id = _doc2 and kshingle = _shin)) as t) ::real
/
(select count (*) from (((
select word from genetic where document_id = _doc1 and kshingle = _shin)
union
(select word from genetic where document_id = _doc2 and kshingle = _shin))
) as t)); end; $BODY$ language 'plpgsql';

--this function for get shingle for two list of words
-- for 2-kshingle 0.945
-- for 5-kshingle 0.888
-- for 9-kshingle 0.443 
create function get_shingle_for_all(_shin integer, _doc1 integer, _doc2 integer) returns real as $BODY$ 
begin
return (select (select count(*) from ((
select word from genetic where document_id = _doc1 and kshingle = _shin)
intersect all
(select word from genetic where document_id = _doc2 and kshingle = _shin)) as t) ::real
/
(select count (*) from (((
select word from genetic where document_id = _doc1 and kshingle = _shin)
union all
(select word from genetic where document_id = _doc2 and kshingle = _shin))
except all
((
select word from genetic where document_id = _doc1 and kshingle = _shin)
intersect all
(select word from genetic where document_id = _doc2 and kshingle = _shin))
) as t)); end; $BODY$ language 'plpgsql';
