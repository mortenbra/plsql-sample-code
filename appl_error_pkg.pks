create or replace package appl_error_pkg
as

  /*
  
  Purpose:    package handles errors
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- raise exception if condition is not true
  procedure assert (p_condition in boolean,
                    p_error_message in varchar2);


end appl_error_pkg;
/


