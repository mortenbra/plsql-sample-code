create or replace package appl_log_pkg
as

  /*
  
  Purpose:    package handles logging
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- log levels
  c_log_level_debug              constant appl_log.log_level%type := 0;
  c_log_level_info               constant appl_log.log_level%type := 1;
  c_log_level_warning            constant appl_log.log_level%type := 2;
  c_log_level_error              constant appl_log.log_level%type := 3;

  -- write to log
  procedure log (p_text in varchar2,
                 p_level in number := null);

end appl_log_pkg;
/


