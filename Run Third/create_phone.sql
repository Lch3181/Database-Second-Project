use finalproject;
drop table if exists phone;
drop table if exists phoneType;

create table phoneType(
    PhoneTypeID int unsigned primary key not null auto_increment,
    PhoneType varchar(16)
);

create table phone
(
    ContactID int unsigned,
    PhoneID int unsigned primary key not null auto_increment,
    PhoneTypeID int unsigned,
    Phone varchar(40),
    foreign key (ContactID) references contact(ContactID) on delete cascade on update cascade,
    foreign key (PhoneTypeID) references phoneType(PhoneTypeID) on DELETE cascade on update cascade
) as
    select distinct Phone
    from invoices
    where Phone is not null;

update phone
    left join invoices i on phone.Phone = i.Phone
    set phone.ContactID = i.ContactID
    where i.Phone is not null;

alter table invoices
    drop Phone;