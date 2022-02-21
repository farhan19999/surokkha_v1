/*
 Navicat Premium Data Transfer

 Source Server         : testdb1
 Source Server Type    : Oracle
 Source Server Version : 190000
 Source Schema         : TESTDB1

 Target Server Type    : Oracle
 Target Server Version : 190000
 File Encoding         : 65001

 Date: 21/02/2022 19:04:41
*/


-- ----------------------------
-- Table structure for AFFILIATION
-- ----------------------------
DROP TABLE "TESTDB1"."AFFILIATION";
CREATE TABLE "TESTDB1"."AFFILIATION" (
  "CATEGORY_ID" NUMBER(3,0) VISIBLE,
  "DATE_OF_BIRTH" DATE VISIBLE,
  "FIRST_NAME" VARCHAR2(20 BYTE) VISIBLE,
  "LAST_NAME" VARCHAR2(20 BYTE) VISIBLE,
  "INSTITUTION_ID" NUMBER VISIBLE,
  "NID_NO" NUMBER(10,0) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of AFFILIATION
-- ----------------------------
INSERT INTO "TESTDB1"."AFFILIATION" VALUES ('22', TO_DATE('1994-02-04 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Xad', 'Cas', '1', '1234567893');
INSERT INTO "TESTDB1"."AFFILIATION" VALUES ('22', TO_DATE('1994-02-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'DDD', 'CCC', '1', '1234567892');
INSERT INTO "TESTDB1"."AFFILIATION" VALUES ('22', TO_DATE('2000-02-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'ABC', 'DEF', '1', '1234567890');
INSERT INTO "TESTDB1"."AFFILIATION" VALUES ('23', TO_DATE('2000-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'FET', 'BOB', '1', '1234567891');

-- ----------------------------
-- Table structure for CATEGORY
-- ----------------------------
DROP TABLE "TESTDB1"."CATEGORY";
CREATE TABLE "TESTDB1"."CATEGORY" (
  "CATEGORY_ID" NUMBER VISIBLE DEFAULT "TESTDB1"."ISEQ$$_73713".nextval NOT NULL,
  "SECTOR_ID" NUMBER(3,0) VISIBLE NOT NULL,
  "SUB_SECTOR_ID" NUMBER(3,0) VISIBLE,
  "SECTOR_NAME" VARCHAR2(200 BYTE) VISIBLE NOT NULL,
  "SUB_SECTOR_NAME" VARCHAR2(200 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of CATEGORY
-- ----------------------------
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('99', '34', NULL, 'Students below 18 years', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('21', '1', NULL, 'Citizen registration (18 years & above)', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('22', '2', '1', 'All officers and employees of the Government Health and Family Planning Department', 'Doctor');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('23', '2', '2', 'All officers and employees of the Government Health and Family Planning Department', 'Nurse and Midwife');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('24', '2', '3', 'All officers and employees of the Government Health and Family Planning Department', 'Medical Technologist');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('25', '2', '4', 'All officers and employees of the Government Health and Family Planning Department', 'Cleaning staff');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('26', '2', '5', 'All officers and employees of the Government Health and Family Planning Department', 'Physiotherapist and related staff');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('27', '2', '6', 'All officers and employees of the Government Health and Family Planning Department', 'Conventional and complementary medical personnel');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('28', '2', '7', 'All officers and employees of the Government Health and Family Planning Department', 'Community health workers');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('29', '2', '52', 'All officers and employees of the Government Health and Family Planning Department', 'Administrative');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('30', '2', '8', 'All officers and employees of the Government Health and Family Planning Department', 'Ambulance driver');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('31', '2', '53', 'All officers and employees of the Government Health and Family Planning Department', 'Others');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('32', '3', '9', 'Approved private health and family planning officers-employees', 'Doctor');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('33', '3', '10', 'Approved private health and family planning officers-employees', 'Nurse and Midwife');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('34', '3', '11', 'Approved private health and family planning officers-employees', 'Medical Technologist');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('35', '3', '12', 'Approved private health and family planning officers-employees', 'Cleaning staff');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('36', '3', '13', 'Approved private health and family planning officers-employees', 'Physiotherapist and related staff');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('37', '3', '14', 'Approved private health and family planning officers-employees', 'Conventional and complementary medical personnel');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('38', '3', '15', 'Approved private health and family planning officers-employees', 'Health workers');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('39', '3', '16', 'Approved private health and family planning officers-employees', 'Ambulance driver');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('40', '4', '17', 'All directly involved government and private health care officers-employees', 'Health administration');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('41', '4', '18', 'All directly involved government and private health care officers-employees', 'All staff involved in management');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('42', '4', '19', 'All directly involved government and private health care officers-employees', 'Clerk');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('43', '4', '20', 'All directly involved government and private health care officers-employees', 'Industrial and trade workers');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('44', '4', '21', 'All directly involved government and private health care officers-employees', 'Laundry and cooking staff');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('45', '4', '22', 'All directly involved government and private health care officers-employees', 'Driver');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('46', '5', NULL, 'Heroic freedom fighters and heroines', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('47', '6', '54', 'Front-line law enforcement agency', 'DGFI');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('48', '6', '23', 'Front-line law enforcement agency', 'Police');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('49', '6', '24', 'Front-line law enforcement agency', 'Traffic police');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('50', '6', '25', 'Front-line law enforcement agency', 'Rapid Action Battalion (RAB)');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('51', '6', '26', 'Front-line law enforcement agency', 'Ansar');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('52', '6', '49', 'Front-line law enforcement agency', 'NSI');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('53', '6', '27', 'Front-line law enforcement agency', 'VDP');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('54', '6', '31', 'Front-line law enforcement agency', 'Border Guard Bangladesh (BGB)');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('55', '6', '32', 'Front-line law enforcement agency', 'Coast Guard');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('56', '7', '28', 'Military and paramilitary defense forces', 'Army');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('57', '7', '29', 'Military and paramilitary defense forces', 'Navy');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('58', '7', '30', 'Military and paramilitary defense forces', 'Air Force');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('59', '7', '33', 'Military and paramilitary defense forces', 'Presidential Guard Regiment');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('60', '24', '59', 'Civilian Aircraft', 'Pilot');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('61', '24', '60', 'Civilian Aircraft', 'Cabin Crew');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('62', '24', '61', 'Civilian Aircraft', 'Others');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('63', '8', '34', 'Essential Offices for governance the state', 'Ministry');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('64', '8', '35', 'Essential Offices for governance the state', 'Secretariat');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('65', '8', '36', 'Essential Offices for governance the state', 'Judicial');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('66', '8', '37', 'Essential Offices for governance the state', 'Administrative');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('67', '8', '51', 'Essential Offices for governance the state', 'Officers and employees of the directorates');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('68', '8', '55', 'Essential Offices for governance the state', 'State-owned corporations and companies');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('69', '31', NULL, 'Bar Council Registrar Attorney', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('70', '23', '57', 'Educational Institutions', 'Teacher');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('71', '23', '58', 'Educational Institutions', 'Officers-Employees');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('72', '9', '38', 'Front-line media workers', 'Journalist');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('73', '9', '39', 'Front-line media workers', 'Media personnel');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('74', '10', NULL, 'Elected Public representative', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('75', '11', NULL, 'Front-line officers and employees of City Corporation and the municipality', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('76', '12', NULL, 'Religious Representatives (of all religions)', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('77', '13', NULL, 'Engaged in burial', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('78', '14', '40', 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Emergency electrical workers');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('79', '14', '41', 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Gas supply workers');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('80', '14', '42', 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Water supply staff');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('81', '14', '43', 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Sewerage workers');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('82', '14', '44', 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Fire service personnel');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('83', '14', '45', 'Government officials and employees at the forefront of emergency electricity, water, gas, sewerage and fire services.', 'Transport workers');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('84', '15', '46', 'Government officials and employees of railway stations, airports, Land ports and seaports', 'Naval Government Officers-Employees');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('85', '15', '47', 'Government officials and employees of railway stations, airports, Land ports and seaports', 'Railway station Government Officers-Employees');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('86', '15', '48', 'Government officials and employees of railway stations, airports, Land ports and seaports', 'Biman Government Officers-Employees');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('87', '15', '56', 'Government officials and employees of railway stations, airports, Land ports and seaports', 'Land ports Government Officers-Employees');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('88', '16', NULL, 'Government officials and employees involved in emergency public service in districts and upazilas', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('89', '17', NULL, 'Bank officer-employee', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('90', '32', NULL, 'Farmer', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('91', '33', NULL, 'Workers', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('92', '19', NULL, 'National players', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('93', '25', '62', 'Students in medical education related subjects', 'Public / private medical / dental college students');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('94', '25', '63', 'Students in medical education related subjects', 'Government Nursing Midwifery College / Institute student');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('95', '25', '64', 'Students in medical education related subjects', 'Student of Government IHT');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('96', '25', '65', 'Students in medical education related subjects', 'Student of Government MATS');
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('97', '26', NULL, 'Student 18 years and above', NULL);
INSERT INTO "TESTDB1"."CATEGORY" VALUES ('98', '28', NULL, 'Person with disability', NULL);

-- ----------------------------
-- Table structure for GUSER
-- ----------------------------
DROP TABLE "TESTDB1"."GUSER";
CREATE TABLE "TESTDB1"."GUSER" (
  "REGISTRATION_ID" NUMBER(20,0) VISIBLE NOT NULL,
  "PASSWORD" VARCHAR2(20 BYTE) VISIBLE,
  "FIRST_NAME" VARCHAR2(20 BYTE) VISIBLE NOT NULL,
  "LAST_NAME" VARCHAR2(20 BYTE) VISIBLE,
  "NID_NO" NUMBER(10,0) VISIBLE,
  "PHONE_NO" NUMBER(13,0) VISIBLE,
  "DATE_OF_BIRTH" DATE VISIBLE NOT NULL,
  "CATEGORY_ID" NUMBER(4,0) VISIBLE,
  "EMAIL" VARCHAR2(20 BYTE) VISIBLE,
  "PASSPORT_NO" VARCHAR2(20 BYTE) VISIBLE,
  "AGE" NUMBER(3,0) VISIBLE,
  "CURRENT_ADDRESS" NUMBER(4,0) VISIBLE NOT NULL,
  "PREFERRED_CENTER" NUMBER(4,0) VISIBLE NOT NULL,
  "HBP_HD_STR" VARCHAR2(3 BYTE) VISIBLE,
  "DIABETICS" VARCHAR2(3 BYTE) VISIBLE,
  "KD" VARCHAR2(3 BYTE) VISIBLE,
  "RESP" VARCHAR2(3 BYTE) VISIBLE,
  "CANCER" VARCHAR2(3 BYTE) VISIBLE,
  "PREV_COVID" VARCHAR2(3 BYTE) VISIBLE,
  "BIRTH_CERTIFICATE_NO" NUMBER(17,0) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of GUSER
-- ----------------------------
INSERT INTO "TESTDB1"."GUSER" VALUES ('1', NULL, 'ABC', 'DEF', '1234567890', '1234567890', TO_DATE('2000-02-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '22', NULL, NULL, '22', '4', '1', 'no', 'no', 'no', 'no', 'no', 'no', NULL);

-- ----------------------------
-- Table structure for LOCATION
-- ----------------------------
DROP TABLE "TESTDB1"."LOCATION";
CREATE TABLE "TESTDB1"."LOCATION" (
  "LOCATION_ID" NUMBER VISIBLE DEFAULT "TESTDB1"."ISEQ$$_73707".nextval NOT NULL,
  "UNION_OR_WARD" NUMBER(3,0) VISIBLE NOT NULL,
  "CITY_OR_MUNICIPALITY" VARCHAR2(30 BYTE) VISIBLE,
  "UPAZILLA_OR_THANA" VARCHAR2(20 BYTE) VISIBLE NOT NULL,
  "DISTRICT" VARCHAR2(20 BYTE) VISIBLE NOT NULL,
  "DIVISION" VARCHAR2(20 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of LOCATION
-- ----------------------------
INSERT INTO "TESTDB1"."LOCATION" VALUES ('4', '20', 'Dhaka South City Corporation', 'Ramna', 'Dhaka', 'Dhaka');
INSERT INTO "TESTDB1"."LOCATION" VALUES ('1', '1', 'Dhaka South City Corporation', 'Khilgaon', 'Dhaka', 'Dhaka');
INSERT INTO "TESTDB1"."LOCATION" VALUES ('2', '2', 'Dhaka South City Corporation', 'Khilgaon', 'Dhaka', 'Dhaka');
INSERT INTO "TESTDB1"."LOCATION" VALUES ('3', '5', 'Dhaka South City Corporation', 'Rajarbag', 'Dhaka', 'Dhaka');

-- ----------------------------
-- Table structure for NID_INFO
-- ----------------------------
DROP TABLE "TESTDB1"."NID_INFO";
CREATE TABLE "TESTDB1"."NID_INFO" (
  "NID_NO" NUMBER(10,0) VISIBLE NOT NULL,
  "FIRST_NAME" VARCHAR2(20 BYTE) VISIBLE NOT NULL,
  "LAST_NAME" VARCHAR2(20 BYTE) VISIBLE,
  "FATHER_NID" NUMBER(13,0) VISIBLE,
  "MOTHER_NID" NUMBER(13,0) VISIBLE,
  "DATE_OF_BIRTH" DATE VISIBLE NOT NULL,
  "CURRENT_ADDRESS" NUMBER(4,0) VISIBLE NOT NULL,
  "PERMANENT_ADDRESS" NUMBER(4,0) VISIBLE NOT NULL,
  "GENDER" VARCHAR2(10 BYTE) VISIBLE,
  "RELIGION" VARCHAR2(10 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of NID_INFO
-- ----------------------------
INSERT INTO "TESTDB1"."NID_INFO" VALUES ('1234567890', 'ABC', 'DEF', NULL, NULL, TO_DATE('2000-02-01 14:14:50', 'SYYYY-MM-DD HH24:MI:SS'), '1', '1', 'Male', NULL);
INSERT INTO "TESTDB1"."NID_INFO" VALUES ('1234567891', 'FET', 'BOB', NULL, NULL, TO_DATE('2000-01-01 12:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '2', '2', 'Male', NULL);

-- ----------------------------
-- Table structure for U18_INFO
-- ----------------------------
DROP TABLE "TESTDB1"."U18_INFO";
CREATE TABLE "TESTDB1"."U18_INFO" (
  "BIRTH_CERTIFICATE_NO" NUMBER(17,0) VISIBLE,
  "DATE_OF_BIRTH" DATE VISIBLE,
  "INSTITUTION_ID" NUMBER VISIBLE,
  "FIRST_NAME" VARCHAR2(30 BYTE) VISIBLE,
  "LAST_NAME" VARCHAR2(30 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of U18_INFO
-- ----------------------------
INSERT INTO "TESTDB1"."U18_INFO" VALUES ('11111111111111111', TO_DATE('2009-02-09 10:44:26', 'SYYYY-MM-DD HH24:MI:SS'), '2', 'Trs', 'Sass');

-- ----------------------------
-- Table structure for USER_ALLOCATION
-- ----------------------------
DROP TABLE "TESTDB1"."USER_ALLOCATION";
CREATE TABLE "TESTDB1"."USER_ALLOCATION" (
  "REGISTRATION_ID" NUMBER(10,0) VISIBLE NOT NULL,
  "ALLOCATED_CENTER" NUMBER(4,0) VISIBLE NOT NULL,
  "ALLOCATED_DATE" DATE VISIBLE NOT NULL,
  "DOSE_NO" NUMBER(3,0) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of USER_ALLOCATION
-- ----------------------------
INSERT INTO "TESTDB1"."USER_ALLOCATION" VALUES ('1', '1', TO_DATE('2022-02-27 12:08:40', 'SYYYY-MM-DD HH24:MI:SS'), '1');

-- ----------------------------
-- Table structure for USER_DOSAGE_HISTORY
-- ----------------------------
DROP TABLE "TESTDB1"."USER_DOSAGE_HISTORY";
CREATE TABLE "TESTDB1"."USER_DOSAGE_HISTORY" (
  "REGISTRATION_ID" NUMBER(20,0) VISIBLE NOT NULL,
  "VACCINE_ID" NUMBER(3,0) VISIBLE NOT NULL,
  "DOSE_NO" NUMBER(1,0) VISIBLE NOT NULL,
  "CENTER_ID" NUMBER(4,0) VISIBLE NOT NULL,
  "BATCH_NO" NUMBER(10,0) VISIBLE NOT NULL,
  "GIVEN_DATE" DATE VISIBLE NOT NULL,
  "CERTIFICATE_NO" VARCHAR2(20 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of USER_DOSAGE_HISTORY
-- ----------------------------
INSERT INTO "TESTDB1"."USER_DOSAGE_HISTORY" VALUES ('1', '1', '1', '1', '1234', TO_DATE('2021-01-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'BD1121&&01&&09');

-- ----------------------------
-- Table structure for VACCINATION_CENTER
-- ----------------------------
DROP TABLE "TESTDB1"."VACCINATION_CENTER";
CREATE TABLE "TESTDB1"."VACCINATION_CENTER" (
  "CENTER_ID" NUMBER VISIBLE DEFAULT "TESTDB1"."ISEQ$$_73710".nextval NOT NULL,
  "PASSWORD" VARCHAR2(20 BYTE) VISIBLE NOT NULL,
  "CENTER_NAME" VARCHAR2(50 BYTE) VISIBLE NOT NULL,
  "DAILY_CAPACITY" NUMBER(4,0) VISIBLE NOT NULL,
  "LOCATION_ID" NUMBER(4,0) VISIBLE NOT NULL,
  "CENTER_TYPE" VARCHAR2(30 BYTE) VISIBLE,
  "USER_NAME" VARCHAR2(50 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of VACCINATION_CENTER
-- ----------------------------
INSERT INTO "TESTDB1"."VACCINATION_CENTER" VALUES ('1', '1234', 'Dhaka Medical College', '1000', '4', 'Hospital', 'Dhaka Medical College');

-- ----------------------------
-- Table structure for VACCINE
-- ----------------------------
DROP TABLE "TESTDB1"."VACCINE";
CREATE TABLE "TESTDB1"."VACCINE" (
  "VACCINE_ID" NUMBER VISIBLE DEFAULT "TESTDB1"."ISEQ$$_73716".nextval NOT NULL,
  "VACCINE_NAME" VARCHAR2(20 BYTE) VISIBLE NOT NULL,
  "MANUFACTURER" VARCHAR2(20 BYTE) VISIBLE NOT NULL,
  "STOCK" NUMBER(6,0) VISIBLE,
  "SHELF_LIFE" NUMBER(4,0) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of VACCINE
-- ----------------------------
INSERT INTO "TESTDB1"."VACCINE" VALUES ('4', 'Covilo', 'Sinofarm', '1000', '270');
INSERT INTO "TESTDB1"."VACCINE" VALUES ('1', 'Comirnaty', 'Pfizer', '995', '270');
INSERT INTO "TESTDB1"."VACCINE" VALUES ('2', 'Spikevax', 'Moderna', '1000', '270');
INSERT INTO "TESTDB1"."VACCINE" VALUES ('3', 'Sputnik V', 'Gamaleya', '1000', '270');

-- ----------------------------
-- Table structure for VACCINE_VIAL_INFORMATION
-- ----------------------------
DROP TABLE "TESTDB1"."VACCINE_VIAL_INFORMATION";
CREATE TABLE "TESTDB1"."VACCINE_VIAL_INFORMATION" (
  "VACCINE_ID" NUMBER(3,0) VISIBLE NOT NULL,
  "BATCH_NO" NUMBER(10,0) VISIBLE NOT NULL,
  "DELIVERED_PLACE" NUMBER(4,0) VISIBLE,
  "MANUFACTURING_DATE" DATE VISIBLE NOT NULL,
  "EXPIRE_DATE" DATE VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of VACCINE_VIAL_INFORMATION
-- ----------------------------
INSERT INTO "TESTDB1"."VACCINE_VIAL_INFORMATION" VALUES ('1', '1234', '1', TO_DATE('2021-01-15 02:27:17', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2021-10-12 02:27:17', 'SYYYY-MM-DD HH24:MI:SS'));

-- ----------------------------
-- Table structure for WUSER
-- ----------------------------
DROP TABLE "TESTDB1"."WUSER";
CREATE TABLE "TESTDB1"."WUSER" (
  "INSTITUTION_ID" NUMBER VISIBLE DEFAULT "TESTDB1"."ISEQ$$_74796".nextval NOT NULL,
  "INSTITUTION_NAME" VARCHAR2(100 BYTE) VISIBLE,
  "WHITELISTED" NUMBER(6,0) VISIBLE,
  "CURRENTLY_REGISTERED" NUMBER(6,0) VISIBLE,
  "PASSWORD" VARCHAR2(30 BYTE) VISIBLE,
  "USER_NAME" VARCHAR2(50 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of WUSER
-- ----------------------------
INSERT INTO "TESTDB1"."WUSER" VALUES ('1', 'Dhaka Medical College', '9', '1', '1234', 'Dhaka Medical College');
INSERT INTO "TESTDB1"."WUSER" VALUES ('2', 'Dhaka Residential Model College', '0', '0', '1234', 'Dhaka Residential Model College');

-- ----------------------------
-- Sequence structure for ISEQ$$_73707
-- ----------------------------
DROP SEQUENCE "TESTDB1"."ISEQ$$_73707";
CREATE SEQUENCE "TESTDB1"."ISEQ$$_73707" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73710
-- ----------------------------
DROP SEQUENCE "TESTDB1"."ISEQ$$_73710";
CREATE SEQUENCE "TESTDB1"."ISEQ$$_73710" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73713
-- ----------------------------
DROP SEQUENCE "TESTDB1"."ISEQ$$_73713";
CREATE SEQUENCE "TESTDB1"."ISEQ$$_73713" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73716
-- ----------------------------
DROP SEQUENCE "TESTDB1"."ISEQ$$_73716";
CREATE SEQUENCE "TESTDB1"."ISEQ$$_73716" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_74525
-- ----------------------------
DROP SEQUENCE "TESTDB1"."ISEQ$$_74525";
CREATE SEQUENCE "TESTDB1"."ISEQ$$_74525" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_74796
-- ----------------------------
DROP SEQUENCE "TESTDB1"."ISEQ$$_74796";
CREATE SEQUENCE "TESTDB1"."ISEQ$$_74796" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Uniques structure for table AFFILIATION
-- ----------------------------
ALTER TABLE "TESTDB1"."AFFILIATION" ADD CONSTRAINT "SYS_C007692" UNIQUE ("NID_NO") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table AFFILIATION
-- ----------------------------
CREATE TRIGGER "TESTDB1"."INCWHITELISTED" AFTER INSERT ON "TESTDB1"."AFFILIATION" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
BEGIN
	UPDATE  WUSER w set WHITELISTED = WHITELISTED+1 
	where w.INSTITUTION_ID = :new.INSTITUTION_ID;
END;
/

-- ----------------------------
-- Primary Key structure for table CATEGORY
-- ----------------------------
ALTER TABLE "TESTDB1"."CATEGORY" ADD CONSTRAINT "SYS_C007547" PRIMARY KEY ("CATEGORY_ID");

-- ----------------------------
-- Checks structure for table CATEGORY
-- ----------------------------
ALTER TABLE "TESTDB1"."CATEGORY" ADD CONSTRAINT "SYS_C007544" CHECK ("CATEGORY_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."CATEGORY" ADD CONSTRAINT "SYS_C007545" CHECK ("SECTOR_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."CATEGORY" ADD CONSTRAINT "SYS_C007546" CHECK ("SECTOR_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table GUSER
-- ----------------------------
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007581" PRIMARY KEY ("REGISTRATION_ID");

-- ----------------------------
-- Uniques structure for table GUSER
-- ----------------------------
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007582" UNIQUE ("NID_NO") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table GUSER
-- ----------------------------
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007574" CHECK ("FIRST_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007576" CHECK ("DATE_OF_BIRTH" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007578" CHECK ("CURRENT_ADDRESS" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007579" CHECK ("PREFERRED_CENTER" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007580" CHECK (NID_NO IS NOT NULL OR DATE_OF_BIRTH IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table GUSER
-- ----------------------------
CREATE TRIGGER "TESTDB1"."ALLOCATE" AFTER INSERT ON "TESTDB1"."GUSER" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
	ad date;
BEGIN
	ad := SYSDATE + 15;
	INSERT into USER_ALLOCATION(REGISTRATION_ID, ALLOCATED_CENTER, ALLOCATED_DATE, DOSE_NO) VALUES 
	(:NEW.REGISTRATION_ID, :NEW.PREFERRED_CENTER, ad, 1);
	
end;
/
CREATE TRIGGER "TESTDB1"."REGID" BEFORE INSERT ON "TESTDB1"."GUSER" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
declare 
 cur_no number;
BEGIN
	cur_no := 0; 
	SELECT count(*) into cur_no FROM GUSER;
	:NEW.REGISTRATION_ID := cur_no+1;
	:NEW.AGE := round(MONTHS_BETWEEN(SYSDATE , :NEW.DATE_OF_BIRTH)/12,0); 
END;
/

-- ----------------------------
-- Primary Key structure for table LOCATION
-- ----------------------------
ALTER TABLE "TESTDB1"."LOCATION" ADD CONSTRAINT "SYS_C007536" PRIMARY KEY ("LOCATION_ID");

-- ----------------------------
-- Checks structure for table LOCATION
-- ----------------------------
ALTER TABLE "TESTDB1"."LOCATION" ADD CONSTRAINT "SYS_C007531" CHECK ("LOCATION_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."LOCATION" ADD CONSTRAINT "SYS_C007532" CHECK ("UNION_OR_WARD" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."LOCATION" ADD CONSTRAINT "SYS_C007533" CHECK ("UPAZILLA_OR_THANA" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."LOCATION" ADD CONSTRAINT "SYS_C007534" CHECK ("DISTRICT" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."LOCATION" ADD CONSTRAINT "SYS_C007535" CHECK ("DIVISION" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table NID_INFO
-- ----------------------------
ALTER TABLE "TESTDB1"."NID_INFO" ADD CONSTRAINT "SYS_C007563" PRIMARY KEY ("NID_NO");

-- ----------------------------
-- Checks structure for table NID_INFO
-- ----------------------------
ALTER TABLE "TESTDB1"."NID_INFO" ADD CONSTRAINT "SYS_C007558" CHECK ("NID_NO" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."NID_INFO" ADD CONSTRAINT "SYS_C007559" CHECK ("FIRST_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."NID_INFO" ADD CONSTRAINT "SYS_C007560" CHECK ("DATE_OF_BIRTH" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."NID_INFO" ADD CONSTRAINT "SYS_C007561" CHECK ("CURRENT_ADDRESS" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."NID_INFO" ADD CONSTRAINT "SYS_C007562" CHECK ("PERMANENT_ADDRESS" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Uniques structure for table U18_INFO
-- ----------------------------
ALTER TABLE "TESTDB1"."U18_INFO" ADD CONSTRAINT "SYS_C007608" UNIQUE ("BIRTH_CERTIFICATE_NO") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table U18_INFO
-- ----------------------------
CREATE TRIGGER "TESTDB1"."INCWHITELISTED2" AFTER INSERT ON "TESTDB1"."U18_INFO" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
BEGIN
	UPDATE  WUSER w set WHITELISTED = WHITELISTED+1 
	where w.INSTITUTION_ID = :new.INSTITUTION_ID;
END;
/

-- ----------------------------
-- Primary Key structure for table USER_ALLOCATION
-- ----------------------------
ALTER TABLE "TESTDB1"."USER_ALLOCATION" ADD CONSTRAINT "SYS_C007591" PRIMARY KEY ("REGISTRATION_ID");

-- ----------------------------
-- Checks structure for table USER_ALLOCATION
-- ----------------------------
ALTER TABLE "TESTDB1"."USER_ALLOCATION" ADD CONSTRAINT "SYS_C007589" CHECK ("ALLOCATED_CENTER" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."USER_ALLOCATION" ADD CONSTRAINT "SYS_C007590" CHECK ("ALLOCATED_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table USER_DOSAGE_HISTORY
-- ----------------------------
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007598" PRIMARY KEY ("REGISTRATION_ID", "DOSE_NO");

-- ----------------------------
-- Uniques structure for table USER_DOSAGE_HISTORY
-- ----------------------------
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007599" UNIQUE ("CERTIFICATE_NO") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table USER_DOSAGE_HISTORY
-- ----------------------------
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007594" CHECK ("VACCINE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007595" CHECK ("CENTER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007596" CHECK ("BATCH_NO" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007597" CHECK ("GIVEN_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table USER_DOSAGE_HISTORY
-- ----------------------------
CREATE TRIGGER "TESTDB1"."SET_CERT" BEFORE INSERT ON "TESTDB1"."USER_DOSAGE_HISTORY" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
BEGIN
	:new.CERTIFICATE_NO :=
	 'BD'||:new.REGISTRATION_ID||:new.DOSE_NO||TO_CHAR(:new.GIVEN_DATE,'yy&&mm&&dd');
	 UPDATE VACCINE set STOCK = STOCK-1 where VACCINE_ID = :new.VACCINE_ID;
end;

--drop TRIGGER set_cert;
/

-- ----------------------------
-- Primary Key structure for table VACCINATION_CENTER
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINATION_CENTER" ADD CONSTRAINT "SYS_C007542" PRIMARY KEY ("CENTER_ID");

-- ----------------------------
-- Uniques structure for table VACCINATION_CENTER
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINATION_CENTER" ADD CONSTRAINT "SYS_C007671" UNIQUE ("USER_NAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table VACCINATION_CENTER
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINATION_CENTER" ADD CONSTRAINT "SYS_C007537" CHECK ("CENTER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINATION_CENTER" ADD CONSTRAINT "SYS_C007538" CHECK ("PASSWORD" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINATION_CENTER" ADD CONSTRAINT "SYS_C007539" CHECK ("CENTER_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINATION_CENTER" ADD CONSTRAINT "SYS_C007540" CHECK ("DAILY_CAPACITY" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINATION_CENTER" ADD CONSTRAINT "SYS_C007541" CHECK ("LOCATION_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table VACCINE
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINE" ADD CONSTRAINT "SYS_C007552" PRIMARY KEY ("VACCINE_ID");

-- ----------------------------
-- Checks structure for table VACCINE
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINE" ADD CONSTRAINT "SYS_C007548" CHECK ("VACCINE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINE" ADD CONSTRAINT "SYS_C007549" CHECK ("VACCINE_NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINE" ADD CONSTRAINT "SYS_C007550" CHECK ("MANUFACTURER" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINE" ADD CONSTRAINT "SYS_C007551" CHECK ("SHELF_LIFE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table VACCINE_VIAL_INFORMATION
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINE_VIAL_INFORMATION" ADD CONSTRAINT "SYS_C007555" PRIMARY KEY ("VACCINE_ID", "BATCH_NO");

-- ----------------------------
-- Checks structure for table VACCINE_VIAL_INFORMATION
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINE_VIAL_INFORMATION" ADD CONSTRAINT "SYS_C007553" CHECK ("MANUFACTURING_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINE_VIAL_INFORMATION" ADD CONSTRAINT "SYS_C007554" CHECK ("EXPIRE_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table VACCINE_VIAL_INFORMATION
-- ----------------------------
CREATE TRIGGER "TESTDB1"."SETEXPDATE" BEFORE INSERT ON "TESTDB1"."VACCINE_VIAL_INFORMATION" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
declare
	num_of_day number;
BEGIN
	num_of_day := 0;
	SELECT SHELF_LIFE INTO num_of_day from VACCINE v where v.VACCINE_ID = :new.VACCINE_ID;
	:new.EXPIRE_DATE := :new.MANUFACTURING_DATE + num_of_day;
END;
/

-- ----------------------------
-- Primary Key structure for table WUSER
-- ----------------------------
ALTER TABLE "TESTDB1"."WUSER" ADD CONSTRAINT "SYS_C007689" PRIMARY KEY ("INSTITUTION_ID");

-- ----------------------------
-- Uniques structure for table WUSER
-- ----------------------------
ALTER TABLE "TESTDB1"."WUSER" ADD CONSTRAINT "SYS_C007691" UNIQUE ("USER_NAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table WUSER
-- ----------------------------
ALTER TABLE "TESTDB1"."WUSER" ADD CONSTRAINT "SYS_C007688" CHECK ("INSTITUTION_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table AFFILIATION
-- ----------------------------
ALTER TABLE "TESTDB1"."AFFILIATION" ADD CONSTRAINT "SYS_C007607" FOREIGN KEY ("CATEGORY_ID") REFERENCES "TESTDB1"."CATEGORY" ("CATEGORY_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."AFFILIATION" ADD CONSTRAINT "SYS_C007690" FOREIGN KEY ("INSTITUTION_ID") REFERENCES "TESTDB1"."WUSER" ("INSTITUTION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table GUSER
-- ----------------------------
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007584" FOREIGN KEY ("NID_NO") REFERENCES "TESTDB1"."NID_INFO" ("NID_NO") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007586" FOREIGN KEY ("CURRENT_ADDRESS") REFERENCES "TESTDB1"."LOCATION" ("LOCATION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007587" FOREIGN KEY ("PREFERRED_CENTER") REFERENCES "TESTDB1"."VACCINATION_CENTER" ("CENTER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007588" FOREIGN KEY ("CATEGORY_ID") REFERENCES "TESTDB1"."CATEGORY" ("CATEGORY_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."GUSER" ADD CONSTRAINT "SYS_C007656" FOREIGN KEY ("BIRTH_CERTIFICATE_NO") REFERENCES "TESTDB1"."U18_INFO" ("BIRTH_CERTIFICATE_NO") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table NID_INFO
-- ----------------------------
ALTER TABLE "TESTDB1"."NID_INFO" ADD CONSTRAINT "SYS_C007565" FOREIGN KEY ("CURRENT_ADDRESS") REFERENCES "TESTDB1"."LOCATION" ("LOCATION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."NID_INFO" ADD CONSTRAINT "SYS_C007566" FOREIGN KEY ("PERMANENT_ADDRESS") REFERENCES "TESTDB1"."LOCATION" ("LOCATION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table U18_INFO
-- ----------------------------
ALTER TABLE "TESTDB1"."U18_INFO" ADD CONSTRAINT "SYS_C007693" FOREIGN KEY ("INSTITUTION_ID") REFERENCES "TESTDB1"."WUSER" ("INSTITUTION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table USER_ALLOCATION
-- ----------------------------
ALTER TABLE "TESTDB1"."USER_ALLOCATION" ADD CONSTRAINT "SYS_C007592" FOREIGN KEY ("REGISTRATION_ID") REFERENCES "TESTDB1"."GUSER" ("REGISTRATION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."USER_ALLOCATION" ADD CONSTRAINT "SYS_C007593" FOREIGN KEY ("ALLOCATED_CENTER") REFERENCES "TESTDB1"."VACCINATION_CENTER" ("CENTER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table USER_DOSAGE_HISTORY
-- ----------------------------
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007600" FOREIGN KEY ("REGISTRATION_ID") REFERENCES "TESTDB1"."GUSER" ("REGISTRATION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007601" FOREIGN KEY ("VACCINE_ID", "BATCH_NO") REFERENCES "TESTDB1"."VACCINE_VIAL_INFORMATION" ("VACCINE_ID", "BATCH_NO") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."USER_DOSAGE_HISTORY" ADD CONSTRAINT "SYS_C007602" FOREIGN KEY ("CENTER_ID") REFERENCES "TESTDB1"."VACCINATION_CENTER" ("CENTER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table VACCINATION_CENTER
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINATION_CENTER" ADD CONSTRAINT "SYS_C007543" FOREIGN KEY ("LOCATION_ID") REFERENCES "TESTDB1"."LOCATION" ("LOCATION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table VACCINE_VIAL_INFORMATION
-- ----------------------------
ALTER TABLE "TESTDB1"."VACCINE_VIAL_INFORMATION" ADD CONSTRAINT "SYS_C007556" FOREIGN KEY ("VACCINE_ID") REFERENCES "TESTDB1"."VACCINE" ("VACCINE_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "TESTDB1"."VACCINE_VIAL_INFORMATION" ADD CONSTRAINT "SYS_C007557" FOREIGN KEY ("DELIVERED_PLACE") REFERENCES "TESTDB1"."VACCINATION_CENTER" ("CENTER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
