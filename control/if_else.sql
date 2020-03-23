declare
  v_num1 number := 0;
  v_num2 number;
begin
  if v_num1 = v_num2    
  then
    dbms_output.put_line('v_num1 == v_num2');
  else
    dbms_output.put_line('v_num1 == v_num2');    
  end if;
  
  if v_num1 < 0
  then
    dbms_output.put_line('v_num1<0');
  elsif v_num1 > 0
  then  
    dbms_output.put_line('v_num1>0');
  else 
    dbms_output.put_line('v_num1==0');
  end if;
end;


declare
  v_letter CHAR(1) := '&sv_letter';
begin
  if (v_letter >= 'A' and v_letter <= 'Z') or (v_letter >= 'a' and v_letter <= 'z')
  then
    dbms_output.put_line('This is a letter');
  else
    dbms_output.put_line('This is not a letter');
    if v_letter between '0' and '9'
    then
      dbms_output.put_line('This is a number');
    else
      dbms_output.put_line('This is not a number');
    end if;
  end if;  
end;


