use finalproject;
drop table if exists city;
drop table if exists state;
drop table if exists country;
drop table if exists postalCode;

create table city(
    CityID int unsigned primary key auto_increment not null,
    City varchar(31)
) as
    select distinct City
    from invoices
    where City is not null
    order by City;

create table state(
    StateID int unsigned primary key auto_increment not null,
    State varchar(31)
) as
    select distinct State
    from invoices
    where State is not null
    order by State;

create table country(
    CountryID int unsigned primary key auto_increment not null,
    Country varchar(31)
);

create table postalCode(
    PostalCodeID int unsigned primary key auto_increment not null,
    PostalCode varchar(31)
) as
    select distinct PostalCode
    from invoices
    where PostalCode is not null
    order by PostalCode;

