use finalproject;

#fix database had no pk
alter table invoices
    modify InvoiceID int unsigned primary key not null auto_increment first;

#remove unnecessary
alter table invoices
    drop FullName,
    drop ExtendedPrice,
    drop TaxAmount,
    drop Subtotal,
    drop InvoiceTotal;

#fix Title column empty to null
update invoices
    set Title = null
    where Title = '';