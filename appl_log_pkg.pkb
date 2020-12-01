create or replace package body appl_log_pkg
as

  /*
  
  Purpose:    package handles logging
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

procedure log (p_text in varchar2,
               p_level in number := null)
as
  pragma autonomous_transaction;
begin

  /*
  
  Purpose:    write to log
  
  Remarks:    logs using autonomous transactions, not interfering with your main transaction
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- TODO: only log if specified level is below current logging threshold

  insert into appl_log (log_text, log_status, log_date)
  values (substr(p_text, 1, 255), nvl(p_level, c_log_level_debug), sysdate);

  commit;

end log;



end appl_log_pkg;
/


