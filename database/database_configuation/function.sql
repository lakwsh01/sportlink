
CREATE OR REPLACE FUNCTION short_index (initial varchar, index_len int default 6)     
RETURNS varchar
LANGUAGE plpgsql  
AS $$    
DECLARE    
randomId VARCHAR;    
BEGIN
SELECT gen_random_uuid() into randomId;  
RETURN initial||'-'||substring(replace(randomId,'-',''),0,index_len+1);
END; 
$$;
