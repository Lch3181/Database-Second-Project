use finalproject;
drop table if exists email;
drop table if exists emailType;

create table emailType(
    EmailTypeID int unsigned primary key not null auto_increment,
    EmailType varchar(16)
);

create table email
(
    ContactID int unsigned,
    EmailID int unsigned primary key not null auto_increment,
    EmailTypeID int unsigned,
    Email varchar(40),
    foreign key (ContactID) references contact(ContactID) on delete cascade on update cascade,
    foreign key (EmailTypeID) references emailType(EmailTypeID) on DELETE cascade on update cascade
) as
    select distinct Email
    from invoices
    where Email is not null;

update email
    left join invoices i on email.Email = i.Email
    set email.ContactID = i.ContactID
    where i.Email is not null;

alter table invoices
    drop Email;