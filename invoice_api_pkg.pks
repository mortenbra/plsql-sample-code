create or replace package invoice_api_pkg
as

  /*
  
  Purpose:    package handles invoices (API)
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- create new invoice
  function create_invoice (p_customer_id in number,
                           p_amount in number,
                           p_description in varchar2 := null,
                           p_vat_code in varchar2 := null) return number;

  -- approve draft invoice
  procedure approve_invoice (p_invoice_id in number);

  -- get status color
  function get_color (p_invoice_id in number := null,
                      p_invoice in xy_invoice%rowtype := null) return varchar2;


end invoice_api_pkg;
/


