create or replace package body simple_test_pkg
as

  /*
  
  Purpose:    this is a simple test package
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

procedure do_something
as
begin

  /*
  
  Purpose:    this procedure does something
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- TODO: add your own magic here...
  null;

end do_something;


function get_something (p_id in number) return varchar2
as
  l_returnvalue xy_customer.customer_name%type;
begin

  /*
  
  Purpose:    this function returns something
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  l_returnvalue := customer_pkg.get_customer_name (p_customer_id => p_id);

  return l_returnvalue;

end get_something;


procedure calculate_something
as
begin

  /*
  
  Purpose:    this procedure calculates something
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- TODO: add your own magic here...
  null;

end calculate_something;


procedure debug_something (p_value1 in number,
                           p_value2 in number)
as
  l_scope  logger_logs.scope%type := lower($$plsql_unit) || '.' || 'debug_something';
  l_params logger.tab_param;
begin

  /*
  
  Purpose:    this procedure execution is logged
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  logger.append_param(l_params, 'p_value1', p_value1);
  logger.append_param(l_params, 'p_value2', p_value2);
  logger.log('START', l_scope, null, l_params);

  -- TODO: add your own magic here...
  null;

  logger.log('END', l_scope);

exception
  when others then
    logger.log_error('Unhandled Exception', l_scope, null, l_params);
    raise;

end debug_something;



end simple_test_pkg;
/


