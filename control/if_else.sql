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
