create or replace package body xtp
as

  /*
  
  Purpose:    the neXT generation Plsql content builder
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  13.10.2022  MBR  Created

  */

  c_max_vc2_size       constant number := 32767;

  m_buffer_vc2         varchar2(c_max_vc2_size);
  m_buffer_clob        clob := '';

procedure init
as
begin

  /*
  
  Purpose:    initialize buffer
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  13.10.2022  MBR  Created

  */

  m_buffer_vc2 := '';
  m_buffer_clob := '';

end init;


procedure p (p_text in varchar2)
as
begin

  /*
  
  Purpose:    print to buffer
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  13.10.2022  MBR  Created

  */

  prn (p_text || chr(10));

end p;


procedure prn (p_text in varchar2)
as
begin

  /*
  
  Purpose:    print to buffer without line feed
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  13.10.2022  MBR  Created

  */

  if lengthb(m_buffer_vc2) + lengthb(p_text) <= c_max_vc2_size then
    m_buffer_vc2 := m_buffer_vc2 || p_text;
  else
    m_buffer_clob := m_buffer_clob || m_buffer_vc2;
    m_buffer_vc2 := p_text;
  end if;

end prn;


procedure p (p_clob in clob)
as
begin

  /*
  
  Purpose:    print clob to buffer
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  13.10.2022  MBR  Created

  */

  prn (p_clob => p_clob || chr(10));

end p;


procedure prn (p_clob in clob)
as
begin

  /*
  
  Purpose:    print clob to buffer without line feed
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  13.10.2022  MBR  Created

  */

  m_buffer_clob := m_buffer_clob || p_clob;

end prn;


function get_clob (p_clear_buffer in boolean := true) return clob
as
  l_returnvalue clob;
begin

  /*
  
  Purpose:    get clob output
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  13.10.2022  MBR  Created

  */

  l_returnvalue := m_buffer_clob;

  if m_buffer_vc2 is not null then
    l_returnvalue := l_returnvalue || m_buffer_vc2;
  end if;

  if p_clear_buffer then
    init();
  end if;

  return l_returnvalue;

end get_clob;


end xtp;
/
