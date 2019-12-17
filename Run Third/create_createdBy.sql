use finalproject;
drop table if exists createdBy;

create table createdBy
(
    CreatedByID   int unsigned primary key auto_increment not null,
    CreatedBy varchar(30)
) as
    select distinct CreatedBy
    from invoices
    where CreatedBy is not null
    order by CreatedBy;

alter table invoices
    add column createByID int unsigned,
    add foreign key (createByID) references createdBy(CreatedByID) on delete cascade on update cascade;

update invoices
    inner join createdBy cB on invoices.CreatedBy = cB.CreatedBy
    set invoices.createByID = cB.CreatedByID
    where invoices.CreatedBy is not null;

alter table invoices
    drop column if exists CreatedBy;