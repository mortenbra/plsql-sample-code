create or replace package invoice_pkg
as

  /*
  
  Purpose:    package handles invoices
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- invoice status
  c_status_draft                 constant xy_invoice.invoice_status%type := 'DRAFT';
  c_status_waiting               constant xy_invoice.invoice_status%type := 'WAITING';
  c_status_approved              constant xy_invoice.invoice_status%type := 'APPROVED';
  c_status_posted                constant xy_invoice.invoice_status%type := 'POSTED';
  c_status_cancelled             constant xy_invoice.invoice_status%type := 'CANCELLED';

  -- invoice types
  c_type_standard                constant xy_invoice.invoice_type%type := 'STANDARD';
  c_type_credit_note             constant xy_invoice.invoice_type%type := 'CREDIT_NOTE';

  -- VAT codes
  c_vat_none                     constant xy_invoice.vat_code%type := 'NONE';
  c_vat_low                      constant xy_invoice.vat_code%type := 'LOW_VAT';
  c_vat_high                     constant xy_invoice.vat_code%type := 'HIGH_VAT';

  -- add new invoice
  function new_invoice (p_customer_id in number,
                        p_amount in number,
                        p_vat_amount in number := 0,
                        p_invoice_description in varchar2 := null) return number;

  -- add new invoice row
  function new_invoice (p_row in xy_invoice%rowtype) return number;

  -- get invoice row
  function get_invoice (p_invoice_id in number) return xy_invoice%rowtype;

  -- set invoice row
  procedure set_invoice (p_row in xy_invoice%rowtype);

  -- delete invoice
  procedure delete_invoice (p_invoice_id in number);

  -- get VAT amount
  function get_vat_amount (p_amount in number,
                           p_vat_code in varchar2) return number;

  -- get default invoice description
  function get_default_invoice_description (p_invoice_type in varchar2 := null) return varchar2;

end invoice_pkg;
/


