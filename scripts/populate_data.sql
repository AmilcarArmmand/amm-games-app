-- script that enters data into amm_games database
use amm_games;

delete from person;

insert into person values('1','admin@admin.com','name','password_hash','first_name',
       'last_name', 'phone_number', '2022:06:06', '1');
