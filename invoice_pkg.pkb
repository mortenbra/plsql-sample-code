create or replace package body invoice_pkg
as

  /*
  
  Purpose:    package handles invoices
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

function new_invoice (p_customer_id in number,
                      p_amount in number,
                      p_vat_amount in number := 0,
                      p_invoice_description in varchar2 := null) return number
as
  l_returnvalue xy_invoice.invoice_id%type;
begin

  /*
  
  Purpose:    add new invoice
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  insert into xy_invoice (invoice_amount, vat_amount, invoice_description,
    invoice_status)
  values (p_amount, p_vat_amount, nvl(p_invoice_description, 'Standard Invoice'),
    c_status_draft)
  returning invoice_id into l_returnvalue;

  return l_returnvalue;

end new_invoice;


function new_invoice (p_row in xy_invoice%rowtype) return number
as
  l_returnvalue xy_invoice.invoice_id%type;
begin

  /*
  
  Purpose:    add new invoice row
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  insert into xy_invoice
  values p_row
  returning invoice_id into l_returnvalue;

  return l_returnvalue;

end new_invoice;


function get_invoice (p_invoice_id in number) return xy_invoice%rowtype
as
  l_returnvalue xy_invoice%rowtype;
begin

  /*
  
  Purpose:    get invoice row
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  begin
    select *
    into l_returnvalue
    from xy_invoice
    where invoice_id = p_invoice_id;
  exception
    when no_data_found then
      l_returnvalue := null;
  end;

  return l_returnvalue;

end get_invoice;


procedure set_invoice (p_row in xy_invoice%rowtype)
as
begin

  /*
  
  Purpose:    set invoice row
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  update xy_invoice
  set row = p_row
  where invoice_id = p_row.invoice_id;

end set_invoice;


procedure delete_invoice (p_invoice_id in number)
as,
begin

  /*
  
  Purpose:    delete invoice
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  delete
  from xy_invoice
  where invoice_id = p_invoice_id;

end delete_invoice;


function get_vat_amount (p_amount in number,
                         p_vat_code in varchar2) return number
as
  l_vat_rate                     number;
  l_returnvalue                  xy_invoice.vat_amount%type;
begin

  /*
  
  Purpose:    get VAT amount
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  06.11.2020  MBR  Created

  */

  if p_vat_code = c_vat_none then
    l_returnvalue := 0;
  else

    begin
      select nvl(vat_rate,0)
      into l_vat_rate
      from xy_vat
      where vat_code = p_vat_code;
    exception
      when no_data_found then
        l_vat_rate := 0;
    end;

    l_returnvalue := (nvl(p_amount,0) * l_vat_rate) / 100;

  end if;

  return l_returnvalue;

end get_vat_amount;


function get_default_invoice_description (p_invoice_type in varchar2 := null) return varchar2
as
  l_returnvalue                  xy_invoice.invoice_description%type;
begin

  /*
  
  Purpose:    get default invoice description
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  06.11.2020  MBR  Created

  */

  l_returnvalue := case
    when p_invoice_type = c_type_standard then 'Standard'
    when p_invoice_type = c_type_credit_note then 'Credit Note'
    else null
  end;

  return l_returnvalue;

end get_default_invoice_description;


end invoice_pkg;
/


