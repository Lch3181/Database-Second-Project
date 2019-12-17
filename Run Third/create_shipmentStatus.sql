use finalproject;
drop table if exists shipmentStatus;

create table shipmentStatus
(
    ShipmentStatusID   int unsigned primary key auto_increment not null,
    ShipmentStatus varchar(30)
) as
    select distinct shipmentStatus
    from invoices
    where shipmentStatus is not null
    order by shipmentStatus;

alter table invoices
    add column ShipmentStatusID int unsigned,
    add foreign key (ShipmentStatusID) references shipmentStatus(ShipmentStatusID) on delete cascade on update cascade;

update invoices
    inner join shipmentStatus sS on invoices.ShipmentStatus = sS.ShipmentStatus
    set invoices.ShipmentStatusID = sS.ShipmentStatusID
    where invoices.ShipmentStatus is not null;

alter table invoices
    drop column if exists shipmentStatus;