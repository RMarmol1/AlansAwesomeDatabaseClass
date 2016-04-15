-- 1. function PreReqsFor(courseNum)
create or replace function PreReqsFor(int) returns setof int as 
$$
declare
   num_input int       := $1;
 
begin
   return query(
      select preReqNum
      from   prerequisites
       where  courseNum = num_input);
  
end;
$$ 
language plpgsql;

Select PreReqsFor(499);

--2. function IsPreReqFor(courseNum)
create or replace function IsPreReqFor(int) returns setof int as 
$$
declare
   num_input int       := $1;
 
begin
   return query(
      select courseNum
      from   prerequisites
       where  preReqNum = num_input);
  
end;
$$ 
language plpgsql;

Select IsPreReqFor(120);

--Optional Challenge: The force is strong with this one
create or replace function AllPreReqsFor(int) returns setof int as 
$$
declare
   num_input int       := $1;
 
 
begin
   
      return query(
		   select preReqNum
		   from prerequisites
		   where courseNum IN (select PreReqsFor(num_input))
		   UNION
		   select PreReqsFor(num_input)
		   order by preReqNum ASC);
      
  
end;
$$ 
language plpgsql;

Select AllPreReqsFor(499);