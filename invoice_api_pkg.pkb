create or replace package body invoice_api_pkg
as

  /*
  
  Purpose:    package handles invoices (API)
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

function create_invoice (p_customer_id in number,
                         p_amount in number,
                         p_description in varchar2 := null,
                         p_vat_code in varchar2 := null) return number
as
  l_customer                     xy_customer%rowtype;
  l_description                  xy_invoice.invoice_description%type;
  l_vat_amount                   xy_invoice.vat_amount%type;
  l_returnvalue                  xy_invoice.invoice_id%type;
begin

  /*
  
  Purpose:    create new invoice
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  -- 1) validate inputs

  appl_error_pkg.assert (p_customer_id is not null, 'Customer ID must be specified!');
  appl_error_pkg.assert (p_amount is not null, 'Amount must be specified!');
  appl_error_pkg.assert (p_amount > 0, 'Amount must be greater than zero!');

  l_customer := customer_pkg.get_customer (p_customer_id);

  appl_error_pkg.assert (l_customer.customer_id is not null, 'Customer not found!');
  appl_error_pkg.assert (l_customer.customer_status = customer_pkg.c_status_active, 'Customer not active!');

  -- 2) do calculations and derive values

  l_description := coalesce (p_description, invoice_pkg.get_default_invoice_description (invoice_pkg.c_type_standard), 'Untitled');

  if p_vat_code is not null then
    l_vat_amount := nvl (invoice_pkg.get_vat_amount (p_amount, p_vat_code), 0);
  else
    l_vat_amount := 0;
  end if;

  -- TODO: calculate due date

  -- 3) perform main task

  l_returnvalue := invoice_pkg.new_invoice (
    p_customer_id => p_customer_id,
    p_amount => p_amount,
    p_vat_amount => l_vat_amount,
    p_invoice_description => p_description
  );

  -- 4) validate outputs

  appl_error_pkg.assert (l_returnvalue is not null, 'Failed to create invoice!');

  return l_returnvalue;

end create_invoice;


procedure approve_invoice (p_invoice_id in number)
as
  l_invoice                      xy_invoice%rowtype;
begin

  /*
  
  Purpose:    approve draft invoice
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  l_invoice := invoice_pkg.get_invoice (p_invoice_id);

  appl_error_pkg.assert (l_invoice.invoice_id is not null, 'Invoice not found!');
  appl_error_pkg.assert (
    p_condition => l_invoice.invoice_status in (invoice_pkg.c_status_draft, invoice_pkg.c_status_waiting),
    p_error_message => 'Invalid invoice status!'
  );

  l_invoice.invoice_status := invoice_pkg.c_status_approved;
  l_invoice.approved_date := sysdate;

  appl_log_pkg.log ('Setting invoice status for invoice ' || p_invoice_id || '...', p_level => appl_log_pkg.c_log_level_debug);

  invoice_pkg.set_invoice (l_invoice);

  appl_log_pkg.log ('... DONE setting invoice status for invoice ' || p_invoice_id, p_level => appl_log_pkg.c_log_level_debug);

end approve_invoice;


function get_color (p_invoice_id in number := null,
                    p_invoice in xy_invoice%rowtype := null) return varchar2
as
  l_invoice     xy_invoice%rowtype;
  l_returnvalue varchar2(255);
begin

  /*
  
  Purpose:    get invoice status color
  
  Remarks:    
  
  Date        Who  Description
  ----------  ---  -------------------------------------
  05.11.2020  MBR  Created

  */

  l_invoice := coalesce (p_invoice, invoice_pkg.get_invoice (p_invoice_id));

  l_returnvalue := case
    when l_invoice.status = invoice_pkg.c_status_draft then 'lightgrey'
    when l_invoice.status = invoice_pkg.c_status_paid and l_invoice.amount is not null then 'green'
    else 'red'
  end;

  return l_returnvalue;

end get_color;


end invoice_api_pkg;
/


