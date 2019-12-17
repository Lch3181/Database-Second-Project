use finalproject;
drop table if exists shipVia;

create table shipVia
(
    ShipViaID   int unsigned primary key auto_increment not null,
    ShipVia varchar(30)
) as
    select distinct shipVia
    from invoices
    where shipVia is not null
    order by shipVia;

alter table invoices
    add column ShipViaID int unsigned,
    add foreign key (ShipViaID) references shipVia(ShipViaID) on delete cascade on update cascade;

update invoices
    inner join shipVia sV on invoices.ShipVia = sV.ShipVia
    set invoices.ShipViaID = sV.ShipViaID
    where invoices.ShipVia is not null;

alter table invoices
    drop column if exists shipVia;