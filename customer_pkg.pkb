create or replace package body customer_pkg
as

  /*
  
  Purpose:    package handles customers
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

function new_customer (p_customer_name in varchar2) return number
as
  l_returnvalue xy_customer.customer_id%type;
begin

  /*
  
  Purpose:    add new customer
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  insert into xy_customer (customer_name)
  values (p_customer_name)
  returning customer_id into l_returnvalue;

  return l_returnvalue;

end new_customer;


function get_customer (p_customer_id in number) return xy_customer%rowtype
as
  l_returnvalue xy_customer%rowtype;
begin

  /*
  
  Purpose:    get customer row
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  begin
    select *
    into l_returnvalue
    from xy_customer
    where customer_id = p_customer_id;
  exception
    when no_data_found then
      l_returnvalue := null;
  end;

  return l_returnvalue;

end get_customer;


function get_customer_name (p_customer_id in number) return xy_customer.customer_name%type
as
  l_returnvalue xy_customer.customer_name%type;
begin

  /*
  
  Purpose:    get customer name
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  begin
    select customer_name
    into l_returnvalue
    from xy_customer
    where customer_id = p_customer_id;
  exception
    when no_data_found then
      l_returnvalue := null;
  end;

  return l_returnvalue;

end get_customer_name;


procedure set_customer (p_customer_id in number,
                        p_customer_name in varchar2)
as
begin

  /*
  
  Purpose:    set customer
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  update xy_customer
  set customer_name = p_customer_name
  where customer_id = p_customer_id;

end set_customer;


procedure set_customer (p_row in xy_customer%rowtype)
as
begin

  /*
  
  Purpose:    set customer row
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  update xy_customer
  set row = p_row
  where customer_id = p_row.customer_id;

end set_customer;


procedure delete_customer (p_customer_id in number)
as
begin

  /*
  
  Purpose:    delete customer
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  delete
  from xy_customer
  where customer_id = p_customer_id;

end delete_customer;


procedure purge_old_customers (p_since_date in date,
                               p_delete_audit_trail in boolean := false)
as
begin

  /*
  
  Purpose:    purge old customer data
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  18.11.2020  MBR  Created

  */

  delete
  from xy_customer
  where last_active_date <= p_since_date;

  if p_delete_audit_trail then
    -- TODO: implement deletion of audit trail
    null;
  end if;

end purge_old_customers;


end customer_pkg;
/


