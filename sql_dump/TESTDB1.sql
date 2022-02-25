/*
 Navicat Premium Data Transfer

 Source Server         : testdb1
 Source Server Type    : Oracle
 Source Server Version : 190000
 Source Schema         : TESTDB1

 Target Server Type    : Oracle
 Target Server Version : 190000
 File Encoding         : 65001

 Date: 25/02/2022 19:21:11
*/

create table LOCATION
(
	LOCATION_ID NUMBER generated as identity
		primary key,
	UNION_OR_WARD NUMBER(3) not null,
	CITY_OR_MUNICIPALITY VARCHAR2(30),
	UPAZILLA_OR_THANA VARCHAR2(20) not null,
	DISTRICT VARCHAR2(20) not null,
	DIVISION VARCHAR2(20) not null
)
/

create or replace trigger CAP_LOCATION_DATA
	before insert or update
	on LOCATION
	for each row
DECLARE
BEGIN
	:new.DIVISION := INITCAP(:new.DIVISION);
	:new.DISTRICT := INITCAP(:new.district);
	:new.UPAZILLA_OR_THANA := INITCAP(:new.UPAZILLA_OR_THANA);
	:new.CITY_OR_MUNICIPALITY := INITCAP(:new.CITY_OR_MUNICIPALITY);
END;
/

create or replace trigger SET_LOCATION_ID
	before insert
	on LOCATION
	for each row
DECLARE
	cnt number;
begin
	cnt := 0;
	SELECT max(LOCATION_ID) INTO cnt from LOCATION;
	:new.LOCATION_ID := cnt+1;
end;
/

create table VACCINATION_CENTER
(
	CENTER_ID NUMBER generated as identity
		primary key,
	PASSWORD VARCHAR2(20) not null,
	CENTER_NAME VARCHAR2(50) not null,
	DAILY_CAPACITY NUMBER(4) not null,
	LOCATION_ID NUMBER(4) not null
		references LOCATION,
	CENTER_TYPE VARCHAR2(30),
	USER_NAME VARCHAR2(50)
		unique
)
/

create table CATEGORY
(
	CATEGORY_ID NUMBER generated as identity
		primary key,
	SECTOR_ID NUMBER(3) not null,
	SUB_SECTOR_ID NUMBER(3),
	SECTOR_NAME VARCHAR2(200) not null,
	SUB_SECTOR_NAME VARCHAR2(200)
)
/

create table VACCINE
(
	VACCINE_ID NUMBER generated as identity
		primary key,
	VACCINE_NAME VARCHAR2(20) not null
		constraint UNIQUE_VACCINE
			unique,
	MANUFACTURER VARCHAR2(20) not null,
	STOCK NUMBER(6),
	SHELF_LIFE NUMBER(4) not null
)
/

create or replace trigger SET_VACCINE_ID
	before insert
	on VACCINE
	for each row
DECLARE
	cnt number;
begin
	cnt := 0;
	SELECT max(VACCINE_ID) INTO cnt from VACCINE;
	:new.VACCINE_ID := cnt+1;
end;
/

create table VACCINE_VIAL_INFORMATION
(
	VACCINE_ID NUMBER(3) not null
		references VACCINE,
	BATCH_NO NUMBER(10) not null,
	DELIVERED_PLACE NUMBER(4)
		references VACCINATION_CENTER,
	MANUFACTURING_DATE DATE not null,
	EXPIRE_DATE DATE not null,
	primary key (VACCINE_ID, BATCH_NO)
)
/

create or replace trigger SETEXPDATE
	before insert
	on VACCINE_VIAL_INFORMATION
	for each row
declare
	num_of_day number;
BEGIN
	num_of_day := 0;
	SELECT SHELF_LIFE INTO num_of_day from VACCINE v where v.VACCINE_ID = :new.VACCINE_ID;
	:new.EXPIRE_DATE := :new.MANUFACTURING_DATE + num_of_day;
END;
/

create table NID_INFO
(
	NID_NO NUMBER(10) not null
		primary key,
	FIRST_NAME VARCHAR2(20) not null,
	LAST_NAME VARCHAR2(20),
	FATHER_NID NUMBER(13),
	MOTHER_NID NUMBER(13),
	DATE_OF_BIRTH DATE not null,
	CURRENT_ADDRESS NUMBER(4) not null
		references LOCATION,
	PERMANENT_ADDRESS NUMBER(4) not null
		references LOCATION,
	GENDER VARCHAR2(10),
	RELIGION VARCHAR2(10)
)
/

create or replace trigger ENTRY_CITIZEN
	before insert
	on NID_INFO
	for each row
DECLARE
begin

	insert into AFFILIATION
	(CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO)
	VALUES (21,:new.DATE_OF_BIRTH, :new.FIRST_NAME, :new.LAST_NAME, 9,:new.NID_NO);

end;
/

create table WUSER
(
	INSTITUTION_ID NUMBER generated as identity
		primary key,
	INSTITUTION_NAME VARCHAR2(100),
	WHITELISTED NUMBER(6),
	CURRENTLY_REGISTERED NUMBER(6),
	PASSWORD VARCHAR2(30),
	USER_NAME VARCHAR2(50)
		unique
)
/

create table AFFILIATION
(
	CATEGORY_ID NUMBER(3)
		references CATEGORY,
	DATE_OF_BIRTH DATE,
	FIRST_NAME VARCHAR2(20),
	LAST_NAME VARCHAR2(20),
	INSTITUTION_ID NUMBER
		references WUSER,
	NID_NO NUMBER(10)
		unique
)
/

create or replace trigger INCWHITELISTED
	after insert
	on AFFILIATION
	for each row
DECLARE
BEGIN
	UPDATE  WUSER w set WHITELISTED = WHITELISTED+1
	where w.INSTITUTION_ID = :new.INSTITUTION_ID;
END;
/

create table U18_INFO
(
	BIRTH_CERTIFICATE_NO NUMBER(17)
		unique,
	DATE_OF_BIRTH DATE,
	INSTITUTION_ID NUMBER
		references WUSER,
	FIRST_NAME VARCHAR2(30),
	LAST_NAME VARCHAR2(30)
)
/

create table GUSER
(
	REGISTRATION_ID NUMBER(20) not null
		primary key,
	PASSWORD VARCHAR2(20),
	FIRST_NAME VARCHAR2(20) not null,
	LAST_NAME VARCHAR2(20),
	NID_NO NUMBER(10)
		unique
		references AFFILIATION (NID_NO),
	PHONE_NO NUMBER(13),
	DATE_OF_BIRTH DATE not null,
	CATEGORY_ID NUMBER(4)
		references CATEGORY,
	EMAIL VARCHAR2(20),
	PASSPORT_NO VARCHAR2(20),
	AGE NUMBER(3),
	CURRENT_ADDRESS NUMBER(4) not null
		references LOCATION,
	PREFERRED_CENTER NUMBER(4) not null
		references VACCINATION_CENTER,
	HBP_HD_STR VARCHAR2(3),
	DIABETICS VARCHAR2(3),
	KD VARCHAR2(3),
	RESP VARCHAR2(3),
	CANCER VARCHAR2(3),
	PREV_COVID VARCHAR2(3),
	BIRTH_CERTIFICATE_NO NUMBER(17)
		references U18_INFO (BIRTH_CERTIFICATE_NO),
	check (NID_NO IS NOT NULL OR DATE_OF_BIRTH IS NOT NULL)
)
/

create or replace trigger REGID
	before insert
	on GUSER
	for each row
declare
 cur_no number;
BEGIN
	cur_no := 0;
	SELECT count(*) into cur_no FROM GUSER;
	:NEW.REGISTRATION_ID := cur_no+1;
	:NEW.AGE := round(MONTHS_BETWEEN(SYSDATE , :NEW.DATE_OF_BIRTH)/12,0);
END;
/

create or replace trigger ALLOCATE
	after insert
	on GUSER
	for each row
DECLARE
	ad date;
BEGIN
	ad := SYSDATE + 15;
	INSERT into USER_ALLOCATION(REGISTRATION_ID, ALLOCATED_CENTER, ALLOCATED_DATE, DOSE_NO) VALUES
	(:NEW.REGISTRATION_ID, :NEW.PREFERRED_CENTER, ad, 1);

end;
/

create table USER_ALLOCATION
(
	REGISTRATION_ID NUMBER(10) not null
		primary key
		references GUSER,
	ALLOCATED_CENTER NUMBER(4) not null
		references VACCINATION_CENTER,
	ALLOCATED_DATE DATE not null,
	DOSE_NO NUMBER(3)
)
/

create table USER_DOSAGE_HISTORY
(
	REGISTRATION_ID NUMBER(20) not null
		references GUSER,
	VACCINE_ID NUMBER(3) not null,
	DOSE_NO NUMBER(1) not null,
	CENTER_ID NUMBER(4) not null
		references VACCINATION_CENTER,
	BATCH_NO NUMBER(10) not null,
	GIVEN_DATE DATE not null,
	CERTIFICATE_NO VARCHAR2(20)
		unique,
	primary key (REGISTRATION_ID, DOSE_NO),
	foreign key (VACCINE_ID, BATCH_NO) references VACCINE_VIAL_INFORMATION
)
/

create or replace trigger SET_CERT
	before insert
	on USER_DOSAGE_HISTORY
	for each row
DECLARE
BEGIN
	:new.CERTIFICATE_NO :=
	 'BD'||:new.REGISTRATION_ID||:new.DOSE_NO||TO_CHAR(:new.GIVEN_DATE,'yy&&mm&&dd');
	 UPDATE VACCINE set STOCK = STOCK-1 where VACCINE_ID = :new.VACCINE_ID;
end;

--drop TRIGGER set_cert;
/

create or replace trigger INCWHITELISTED2
	after insert
	on U18_INFO
	for each row
DECLARE
BEGIN
	UPDATE  WUSER w set WHITELISTED = WHITELISTED+1
	where w.INSTITUTION_ID = :new.INSTITUTION_ID;
END;
/

create or replace trigger SET_WUSER_ID
	before insert
	on WUSER
	for each row
DECLARE
	cnt number;
begin
	cnt := 0;
	SELECT max(INSTITUTION_ID) INTO cnt from wuser;
	:new.INSTITUTION_ID := cnt+1;
end;
/
---data

insert into TESTDB1.LOCATION (LOCATION_ID, UNION_OR_WARD, CITY_OR_MUNICIPALITY, UPAZILLA_OR_THANA, DISTRICT, DIVISION) values (4, 20, 'Dhaka South City Corporation', 'Ramna', 'Dhaka', 'Dhaka');
insert into TESTDB1.LOCATION (LOCATION_ID, UNION_OR_WARD, CITY_OR_MUNICIPALITY, UPAZILLA_OR_THANA, DISTRICT, DIVISION) values (1, 1, 'Dhaka South City Corporation', 'Khilgaon', 'Dhaka', 'Dhaka');
insert into TESTDB1.LOCATION (LOCATION_ID, UNION_OR_WARD, CITY_OR_MUNICIPALITY, UPAZILLA_OR_THANA, DISTRICT, DIVISION) values (2, 2, 'Dhaka South City Corporation', 'Khilgaon', 'Dhaka', 'Dhaka');
insert into TESTDB1.LOCATION (LOCATION_ID, UNION_OR_WARD, CITY_OR_MUNICIPALITY, UPAZILLA_OR_THANA, DISTRICT, DIVISION) values (3, 5, 'Dhaka South City Corporation', 'Rajarbag', 'Dhaka', 'Dhaka');
insert into TESTDB1.LOCATION (LOCATION_ID, UNION_OR_WARD, CITY_OR_MUNICIPALITY, UPAZILLA_OR_THANA, DISTRICT, DIVISION) values (5, 2, 'Dncc', 'Khilgaon2', 'Dhaka', 'Dhaka');

----

insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (99, 34, null, 'Students below 18 years', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (21, 1, null, 'Citizen registration (18 years & above)', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (22, 2, 1, 'All officers and employees of the Government Health and Family Planning Department', 'Doctor');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (23, 2, 2, 'All officers and employees of the Government Health and Family Planning Department', 'Nurse and Midwife');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (24, 2, 3, 'All officers and employees of the Government Health and Family Planning Department', 'Medical Technologist');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (25, 2, 4, 'All officers and employees of the Government Health and Family Planning Department', 'Cleaning staff');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (26, 2, 5, 'All officers and employees of the Government Health and Family Planning Department', 'Physiotherapist and related staff');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (27, 2, 6, 'All officers and employees of the Government Health and Family Planning Department', 'Conventional and complementary medical personnel');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (28, 2, 7, 'All officers and employees of the Government Health and Family Planning Department', 'Community health workers');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (29, 2, 52, 'All officers and employees of the Government Health and Family Planning Department', 'Administrative');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (30, 2, 8, 'All officers and employees of the Government Health and Family Planning Department', 'Ambulance driver');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (31, 2, 53, 'All officers and employees of the Government Health and Family Planning Department', 'Others');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (32, 3, 9, 'Approved private health and family planning officers-employees', 'Doctor');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (33, 3, 10, 'Approved private health and family planning officers-employees', 'Nurse and Midwife');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (34, 3, 11, 'Approved private health and family planning officers-employees', 'Medical Technologist');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (35, 3, 12, 'Approved private health and family planning officers-employees', 'Cleaning staff');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (36, 3, 13, 'Approved private health and family planning officers-employees', 'Physiotherapist and related staff');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (37, 3, 14, 'Approved private health and family planning officers-employees', 'Conventional and complementary medical personnel');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (38, 3, 15, 'Approved private health and family planning officers-employees', 'Health workers');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (39, 3, 16, 'Approved private health and family planning officers-employees', 'Ambulance driver');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (40, 4, 17, 'All directly involved government and private health care officers-employees', 'Health administration');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (41, 4, 18, 'All directly involved government and private health care officers-employees', 'All staff involved in management');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (42, 4, 19, 'All directly involved government and private health care officers-employees', 'Clerk');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (43, 4, 20, 'All directly involved government and private health care officers-employees', 'Industrial and trade workers');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (44, 4, 21, 'All directly involved government and private health care officers-employees', 'Laundry and cooking staff');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (45, 4, 22, 'All directly involved government and private health care officers-employees', 'Driver');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (46, 5, null, 'Heroic freedom fighters and heroines', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (47, 6, 54, 'Front-line law enforcement agency', 'DGFI');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (48, 6, 23, 'Front-line law enforcement agency', 'Police');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (49, 6, 24, 'Front-line law enforcement agency', 'Traffic police');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (50, 6, 25, 'Front-line law enforcement agency', 'Rapid Action Battalion (RAB)');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (51, 6, 26, 'Front-line law enforcement agency', 'Ansar');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (52, 6, 49, 'Front-line law enforcement agency', 'NSI');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (53, 6, 27, 'Front-line law enforcement agency', 'VDP');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (54, 6, 31, 'Front-line law enforcement agency', 'Border Guard Bangladesh (BGB)');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (55, 6, 32, 'Front-line law enforcement agency', 'Coast Guard');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (56, 7, 28, 'Military and paramilitary defense forces', 'Army');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (57, 7, 29, 'Military and paramilitary defense forces', 'Navy');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (58, 7, 30, 'Military and paramilitary defense forces', 'Air Force');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (59, 7, 33, 'Military and paramilitary defense forces', 'Presidential Guard Regiment');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (60, 24, 59, 'Civilian Aircraft', 'Pilot');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (61, 24, 60, 'Civilian Aircraft', 'Cabin Crew');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (62, 24, 61, 'Civilian Aircraft', 'Others');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (63, 8, 34, 'Essential Offices for governance the state', 'Ministry');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (64, 8, 35, 'Essential Offices for governance the state', 'Secretariat');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (65, 8, 36, 'Essential Offices for governance the state', 'Judicial');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (66, 8, 37, 'Essential Offices for governance the state', 'Administrative');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (67, 8, 51, 'Essential Offices for governance the state', 'Officers and employees of the directorates');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (68, 8, 55, 'Essential Offices for governance the state', 'State-owned corporations and companies');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (69, 31, null, 'Bar Council Registrar Attorney', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (70, 23, 57, 'Educational Institutions', 'Teacher');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (71, 23, 58, 'Educational Institutions', 'Officers-Employees');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (72, 9, 38, 'Front-line media workers', 'Journalist');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (73, 9, 39, 'Front-line media workers', 'Media personnel');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (74, 10, null, 'Elected Public representative', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (75, 11, null, 'Front-line officers and employees of City Corporation and the municipality', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (76, 12, null, 'Religious Representatives (of all religions)', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (77, 13, null, 'Engaged in burial', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (78, 14, 40, 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Emergency electrical workers');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (79, 14, 41, 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Gas supply workers');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (80, 14, 42, 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Water supply staff');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (81, 14, 43, 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Sewerage workers');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (82, 14, 44, 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Fire service personnel');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (83, 14, 45, 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Transport workers');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (84, 15, 46, 'Government officials and employees of railway stations, airports, Land ports and seaports', 'Naval Government Officers-Employees');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (85, 15, 47, 'Government officials and employees of railway stations, airports, Land ports and seaports', 'Railway station Government Officers-Employees');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (86, 15, 48, 'Government officials and employees of railway stations, airports, Land ports and seaports', 'Biman Government Officers-Employees');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (87, 15, 56, 'Government officials and employees of railway stations, airports, Land ports and seaports', 'Land ports Government Officers-Employees');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (88, 16, null, 'Government officials and employees involved in emergency public service in districts and upazilas', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (89, 17, null, 'Bank officer-employee', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (90, 32, null, 'Farmer', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (91, 33, null, 'Workers', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (92, 19, null, 'National players', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (93, 25, 62, 'Students in medical education related subjects', 'Public / private medical / dental college students');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (94, 25, 63, 'Students in medical education related subjects', 'Government Nursing Midwifery College / Institute student');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (95, 25, 64, 'Students in medical education related subjects', 'Student of Government IHT');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (96, 25, 65, 'Students in medical education related subjects', 'Student of Government MATS');
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (97, 26, null, 'Student 18 years and above', null);
insert into TESTDB1.CATEGORY (CATEGORY_ID, SECTOR_ID, SUB_SECTOR_ID, SECTOR_NAME, SUB_SECTOR_NAME) values (98, 28, null, 'Person with disability', null);
-----

insert into TESTDB1.WUSER (INSTITUTION_ID, INSTITUTION_NAME, WHITELISTED, CURRENTLY_REGISTERED, PASSWORD, USER_NAME) values (1, 'Dhaka Medical College', 25, 1, '1234', 'Dhaka Medical College');
insert into TESTDB1.WUSER (INSTITUTION_ID, INSTITUTION_NAME, WHITELISTED, CURRENTLY_REGISTERED, PASSWORD, USER_NAME) values (9, 'Citizen', 2, 0, '0000', 'Citizen');
insert into TESTDB1.WUSER (INSTITUTION_ID, INSTITUTION_NAME, WHITELISTED, CURRENTLY_REGISTERED, PASSWORD, USER_NAME) values (4, 'AwerG', 0, 0, '1234', 'AwerG');
insert into TESTDB1.WUSER (INSTITUTION_ID, INSTITUTION_NAME, WHITELISTED, CURRENTLY_REGISTERED, PASSWORD, USER_NAME) values (5, 'Aasde', 0, 0, '1234', 'Aasde');
insert into TESTDB1.WUSER (INSTITUTION_ID, INSTITUTION_NAME, WHITELISTED, CURRENTLY_REGISTERED, PASSWORD, USER_NAME) values (6, 'ADG', 0, 0, '1234', 'ADG');
insert into TESTDB1.WUSER (INSTITUTION_ID, INSTITUTION_NAME, WHITELISTED, CURRENTLY_REGISTERED, PASSWORD, USER_NAME) values (2, 'Dhaka Residential Model College', 0, 0, '1234', 'Dhaka Residential Model College');
insert into TESTDB1.WUSER (INSTITUTION_ID, INSTITUTION_NAME, WHITELISTED, CURRENTLY_REGISTERED, PASSWORD, USER_NAME) values (10, 'Dhaka University', 0, 0, '1234', 'Dhaka University');


-----
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (22, '1994-02-04', 'Xad', 'Cas', 1, 1234567893);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (22, '1994-02-02', 'DDD', 'CCC', 1, 1234567892);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (90, '1996-03-05', 'Tst', 'Udy', 1, 1231231322);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (22, '1994-02-04', 'trs', 'yso', 1, 1236567893);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (22, '2000-02-01', 'ABC', 'DEF', 1, 1234567890);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (22, '1995-02-01', 'GETY', 'Asd', 1, 1231232122);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (21, '1988-07-25', 'RAHIMA', 'BEGUM', 9, 1234567894);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (21, '1999-07-26', 'FARHAN', 'FAHIM', 9, 1234567896);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (23, '2000-01-01', 'FET', 'BOB', 1, 1234567891);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (46, '1945-02-02', 'un', 'undef', null, 3314221361);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (22, '2022-02-03', 'Grt', 'Asd', 1, 1231232109);
insert into TESTDB1.AFFILIATION (CATEGORY_ID, DATE_OF_BIRTH, FIRST_NAME, LAST_NAME, INSTITUTION_ID, NID_NO) values (22, '1997-01-02', 'DSS', 'CCC', 1, 1231232106);
------
insert into TESTDB1.VACCINE (VACCINE_ID, VACCINE_NAME, MANUFACTURER, STOCK, SHELF_LIFE) values (4, 'Covilo', 'Sinofarm', 1000, 270);
insert into TESTDB1.VACCINE (VACCINE_ID, VACCINE_NAME, MANUFACTURER, STOCK, SHELF_LIFE) values (1, 'Comirnaty', 'Pfizer', 1000, 270);
insert into TESTDB1.VACCINE (VACCINE_ID, VACCINE_NAME, MANUFACTURER, STOCK, SHELF_LIFE) values (2, 'Spikevax', 'Moderna', 1000, 270);
insert into TESTDB1.VACCINE (VACCINE_ID, VACCINE_NAME, MANUFACTURER, STOCK, SHELF_LIFE) values (3, 'Sputnik V', 'Gamaleya', 1000, 270);
insert into TESTDB1.VACCINE (VACCINE_ID, VACCINE_NAME, MANUFACTURER, STOCK, SHELF_LIFE) values (5, 'wvaccine', 'myself', 1000, 270);

-----

insert into TESTDB1.VACCINATION_CENTER (CENTER_ID, PASSWORD, CENTER_NAME, DAILY_CAPACITY, LOCATION_ID, CENTER_TYPE, USER_NAME) values (1, '1234', 'Dhaka Medical College', 1000, 4, 'Hospital', 'Dhaka Medical College');
-----
insert into TESTDB1.VACCINE_VIAL_INFORMATION (VACCINE_ID, BATCH_NO, DELIVERED_PLACE, MANUFACTURING_DATE, EXPIRE_DATE) values (1, 1234, 1, '2021-01-15 02:27:17', '2021-10-12 02:27:17');
-----


-----
insert into TESTDB1.NID_INFO (NID_NO, FIRST_NAME, LAST_NAME, FATHER_NID, MOTHER_NID, DATE_OF_BIRTH, CURRENT_ADDRESS, PERMANENT_ADDRESS, GENDER, RELIGION) values (1234567890, 'ABC', 'DEF', null, null, '2000-02-01', 1, 1, 'Male', null);
insert into TESTDB1.NID_INFO (NID_NO, FIRST_NAME, LAST_NAME, FATHER_NID, MOTHER_NID, DATE_OF_BIRTH, CURRENT_ADDRESS, PERMANENT_ADDRESS, GENDER, RELIGION) values (1234567896, 'FARHAN', 'FAHIM', null, null, '1999-07-26', 3, 3, 'Male', null);
insert into TESTDB1.NID_INFO (NID_NO, FIRST_NAME, LAST_NAME, FATHER_NID, MOTHER_NID, DATE_OF_BIRTH, CURRENT_ADDRESS, PERMANENT_ADDRESS, GENDER, RELIGION) values (1234567894, 'RAHIMA', 'BEGUM', null, null, '1988-07-25', 1, 3, 'Female', null);
insert into TESTDB1.NID_INFO (NID_NO, FIRST_NAME, LAST_NAME, FATHER_NID, MOTHER_NID, DATE_OF_BIRTH, CURRENT_ADDRESS, PERMANENT_ADDRESS, GENDER, RELIGION) values (1234567891, 'FET', 'BOB', null, null, '2000-01-01', 2, 2, 'Male', null);
------
insert into TESTDB1.U18_INFO (BIRTH_CERTIFICATE_NO, DATE_OF_BIRTH, INSTITUTION_ID, FIRST_NAME, LAST_NAME) values (11111111111111111, '2009-02-09', 2, 'Trs', 'Sass');
insert into TESTDB1.U18_INFO (BIRTH_CERTIFICATE_NO, DATE_OF_BIRTH, INSTITUTION_ID, FIRST_NAME, LAST_NAME) values (12345678901234567, '2005-02-02', 1, 'adsd', 'sadw');
insert into TESTDB1.U18_INFO (BIRTH_CERTIFICATE_NO, DATE_OF_BIRTH, INSTITUTION_ID, FIRST_NAME, LAST_NAME) values (12345658901234567, '2001-02-05', 1, 'Ufsda', 'Adsad');
insert into TESTDB1.U18_INFO (BIRTH_CERTIFICATE_NO, DATE_OF_BIRTH, INSTITUTION_ID, FIRST_NAME, LAST_NAME) values (12345678901334557, '2008-02-03', 1, 'Tads', 'aww');
-----

------
insert into TESTDB1.GUSER (REGISTRATION_ID, PASSWORD, FIRST_NAME, LAST_NAME, NID_NO, PHONE_NO, DATE_OF_BIRTH, CATEGORY_ID, EMAIL, PASSPORT_NO, AGE, CURRENT_ADDRESS, PREFERRED_CENTER, HBP_HD_STR, DIABETICS, KD, RESP, CANCER, PREV_COVID, BIRTH_CERTIFICATE_NO) values (2, '1234', 'Xad', 'Cas', 1234567893, 8801234567891, '1994-02-04', 22, null, null, 28, 4, 1, 'no', 'no', 'no', 'no', 'no', 'no', null);
insert into TESTDB1.GUSER (REGISTRATION_ID, PASSWORD, FIRST_NAME, LAST_NAME, NID_NO, PHONE_NO, DATE_OF_BIRTH, CATEGORY_ID, EMAIL, PASSPORT_NO, AGE, CURRENT_ADDRESS, PREFERRED_CENTER, HBP_HD_STR, DIABETICS, KD, RESP, CANCER, PREV_COVID, BIRTH_CERTIFICATE_NO) values (1, '1234', 'ABC', 'DEF', 1234567890, 8801234567890, '2000-02-01', 22, null, null, 22, 4, 1, 'no', 'no', 'no', 'no', 'no', 'no', null);
insert into TESTDB1.GUSER (REGISTRATION_ID, PASSWORD, FIRST_NAME, LAST_NAME, NID_NO, PHONE_NO, DATE_OF_BIRTH, CATEGORY_ID, EMAIL, PASSPORT_NO, AGE, CURRENT_ADDRESS, PREFERRED_CENTER, HBP_HD_STR, DIABETICS, KD, RESP, CANCER, PREV_COVID, BIRTH_CERTIFICATE_NO) values (3, '1234', 'Trs', 'Sass', null, 8801234567890, '2009-02-09', null, null, null, 13, 4, 1, 'no', 'no', 'no', 'no', 'no', 'no', 11111111111111111);
insert into TESTDB1.GUSER (REGISTRATION_ID, PASSWORD, FIRST_NAME, LAST_NAME, NID_NO, PHONE_NO, DATE_OF_BIRTH, CATEGORY_ID, EMAIL, PASSPORT_NO, AGE, CURRENT_ADDRESS, PREFERRED_CENTER, HBP_HD_STR, DIABETICS, KD, RESP, CANCER, PREV_COVID, BIRTH_CERTIFICATE_NO) values (4, '1234', 'DDD', 'CCC', 1234567892, 8801234567890, '1994-02-02', 22, null, null, 28, 4, 1, 'no', 'no', 'no', 'no', 'no', 'no', null);
---------

insert into TESTDB1.USER_ALLOCATION (REGISTRATION_ID, ALLOCATED_CENTER, ALLOCATED_DATE, DOSE_NO) values (2, 1, '2022-03-10 01:23:26', 1);
insert into TESTDB1.USER_ALLOCATION (REGISTRATION_ID, ALLOCATED_CENTER, ALLOCATED_DATE, DOSE_NO) values (1, 1, '2022-02-27 12:08:40', 1);
insert into TESTDB1.USER_ALLOCATION (REGISTRATION_ID, ALLOCATED_CENTER, ALLOCATED_DATE, DOSE_NO) values (3, 1, '2022-03-10 01:57:45', 1);
insert into TESTDB1.USER_ALLOCATION (REGISTRATION_ID, ALLOCATED_CENTER, ALLOCATED_DATE, DOSE_NO) values (4, 1, '2022-03-10 04:14:11', 1);
--------

insert into TESTDB1.USER_DOSAGE_HISTORY (REGISTRATION_ID, VACCINE_ID, DOSE_NO, CENTER_ID, BATCH_NO, GIVEN_DATE, CERTIFICATE_NO) values (1, 1, 1, 1, 1234, '2021-01-09', 'BD1121&&01&&09');
-----
---END---