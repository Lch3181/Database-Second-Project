use finalproject;

#fix database had no pk
alter table invoices
    modify InvoiceID int unsigned primary key not null auto_increment first;

#remove Full name
alter table invoices
    drop column if exists FullName;

#fix Title column empty to null
update invoices
    set Title = null
    where Title = '';