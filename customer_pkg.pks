create or replace package customer_pkg
as

  /*
  
  Purpose:    package handles customers
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- customer status
  c_status_active                constant xy_customer.customer_status%type := 'ACTIVE';
  c_status_inactive              constant xy_customer.customer_status%type := 'INACTIVE';

  -- add new customer
  function new_customer (p_customer_name in varchar2) return number;

  -- get customer row
  function get_customer (p_customer_id in number) return xy_customer%rowtype;

  -- get customer name
  function get_customer_name (p_customer_id in number) return xy_customer.customer_name%type;

  -- set customer
  procedure set_customer (p_customer_id in number,
                          p_customer_name in varchar2);

  -- set customer row
  procedure set_customer (p_row in xy_customer%rowtype);

  -- delete customer
  procedure delete_customer (p_customer_id in number);

  -- purge old customers
  procedure purge_old_customers (p_since_date in date,
                                 p_delete_audit_trail in boolean := false);

end customer_pkg;
/


