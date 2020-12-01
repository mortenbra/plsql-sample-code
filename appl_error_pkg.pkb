create or replace package body appl_error_pkg
as

  /*
  
  Purpose:    package handles errors
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

procedure assert (p_condition in boolean,
                  p_error_message in varchar2)
as
begin

  /*
  
  Purpose:    raise exception if condition is not true
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  if not nvl(p_condition, false) then
    raise_application_error (-20000, p_error_message);
  end if;

end assert;


end appl_error_pkg;
/


