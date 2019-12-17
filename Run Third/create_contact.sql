use finalproject;
drop table if exists company;
drop table if exists title;
drop table if exists contact;

create table company(
    CompanyID int unsigned primary key auto_increment not null,
    Company varchar(31)
) as
    select distinct Company
    from invoices
    where Company is not null
    order by Company;


create table title(
    TitleID int unsigned primary key auto_increment not null,
    Title varchar(8)
) as
    select distinct Title
    from invoices
    where Title is not null
    order by Title;

create table contact(
    ContactID int unsigned primary key auto_increment not null,
    CompanyID int unsigned,
    TitleID int unsigned,
    FirstName varchar(31),
    LastName varchar(31),
    Fax varchar(15),
    foreign key (CompanyID) references company(CompanyID) on delete cascade on update cascade,
    foreign key (TitleID) references title(TitleID) on delete cascade on update cascade
) as
    select c.CompanyID, t.TitleID, i.FirstName, i.LastName, i.Fax
    from invoices i
    left join company c on i.Company = c.Company
    left join title t on i.Title = t.Title
    where InvoiceID is not null
    order by InvoiceID;

alter table invoices
    add column Address1 varchar(255),
    add column Address2 varchar(255),
    add column PostalCodeID int unsigned,
    add column CityID int unsigned,
    add column StateID int unsigned,
    add column CountryID int unsigned,
    add foreign key (PostalCodeID) references postalcode(PostalCodeID) on delete cascade on update cascade,
    add foreign key (CityID) references city(CityID) on delete cascade on update cascade,
    add foreign key (StateID) references state(StateID) on delete cascade on update cascade,
    add foreign key (CountryID) references country(CountryID) on delete cascade on update cascade;

update invoices i
    left join city c2 on i.City = c2.City
    left join state s on i.State = s.State
    left join postalcode p on i.PostalCode = p.PostalCode
    set i.Address1 = i.Street,
      i.PostalCodeID = p.PostalCodeID,
      i.CityID = c2.CityID,
      i.StateID = s.StateID;

#reorder column
alter table invoices
    modify Address2 varchar(225) after Address1,
    modify CountryID int unsigned after StateID;

alter table invoices
    add column ContactID int unsigned,
    add foreign key (ContactID) references contact(ContactID);

update invoices
    inner join contact c on invoices.FirstName = c.FirstName
    set invoices.ContactID = c.ContactID
    where InvoiceID is not null;

alter table invoices
    drop Company,
    drop Title,
    drop FirstName,
    drop LastName,
    drop Fax,
    drop Street,
    drop PostalCode,
    drop City,
    drop State;