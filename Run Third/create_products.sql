use finalproject;
drop table if exists product;

create table product(
    InvoiceID int unsigned,
    ProductID char(15) primary key not null,
    ProductName varchar(127),
    ProductWeight int,
    Quantity int(15),
    Price decimal(15,2),
    UnitDimensions char(15),
    Date datetime,
    foreign key (InvoiceID) references invoices(InvoiceID) on delete cascade on update cascade
) as
    select i.InvoiceID, i.PartNumber as ProductID, i.ProductName, i.UnitDimensions, i.ProductWeight, i.Quantity, i.Price, NOW() as Date
           from invoices i;

alter table invoices
    drop PartNumber,
    drop ProductName,
    drop ProductWeight,
    drop Quantity,
    drop Price,
    drop UnitDimensions;