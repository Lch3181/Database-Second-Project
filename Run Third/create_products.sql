use finalproject;
drop table if exists product;
drop table if exists price;
drop table if exists invoice_products;

create table product(
    ProductID char(15) not null primary key,
    ProductName varchar(127),
    UnitDimensions char(10),
    ProductWeight decimal(15,2)
) as
    select i.PartNumber as ProductID, i.ProductName, i.UnitDimensions, i.ProductWeight
    from invoices i;

create table price(
    ProductID char(15),
    PriceID int unsigned primary key auto_increment not null,
    Price decimal(15,2),
    Date DATE,
    foreign key (ProductID) references product(ProductID) on delete cascade on update cascade
) as
    select i.Price, NOW() as Date
        from invoices i;

create table invoice_products
(
    InvoiceID int unsigned,
    ProductID char(15),
    Quantity  int(15),
    PriceID  int unsigned,
    foreign key (InvoiceID) references invoices (InvoiceID) on delete cascade on update cascade,
    foreign key (ProductID) references product (ProductID) on delete cascade on update cascade,
    foreign key (PriceID) references price(PriceID) on delete cascade on update cascade
) as
    select i.InvoiceID, i.Quantity
           from invoices i;

alter table invoices
    drop PartNumber,
    drop ProductName,
    drop ProductWeight,
    drop Quantity,
    drop Price,
    drop UnitDimensions;