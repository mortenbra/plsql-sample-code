create or replace package xtp
as

  /*
  
  Purpose:    the neXT generation Plsql content builder
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  13.10.2022  MBR  Created

  */

  -- initialize buffer
  procedure init;

  -- print to buffer
  procedure p (p_text in varchar2);

  -- print to buffer without line feed
  procedure prn (p_text in varchar2);

  -- print clob to buffer
  procedure p (p_clob in clob);

  -- print clob to buffer without line feed
  procedure prn (p_clob in clob);

  -- get clob output
  function get_clob (p_clear_buffer in boolean := true) return clob;

end xtp;
/
