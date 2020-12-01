create or replace package simple_test_pkg
as

  /*
  
  Purpose:    this is a simple test package
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- this procedure does something
  procedure do_something;

  -- this function returns something
  function get_something (p_id in number) return varchar2;

  -- this procedure execution is logged
  procedure debug_something (p_value1 in number,
                             p_value2 in number);


end simple_test_pkg;
/


