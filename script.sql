DROP TABLE IF EXISTS Order_Products;
DROP TABLE IF EXISTS Requestor_Order;
DROP TABLE IF EXISTS Warehouse_product_location;
DROP TABLE IF EXISTS Disaster;
DROP TABLE IF EXISTS CallCenter;
DROP TABLE IF EXISTS CommandCenter;
DROP TABLE IF EXISTS Warehouse;
DROP TABLE IF EXISTS Project_Team;
DROP TABLE IF EXISTS Special_Teams;
DROP TABLE IF EXISTS Project_Task;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Groups;
DROP TABLE IF EXISTS ENCOUNTER;
DROP TABLE IF EXISTS Project;
DROP TABLE IF EXISTS Resources;
DROP TABLE IF EXISTS Location;
DROP TABLE IF EXISTS FEMA;
DROP TABLE IF EXISTS Task;
DROP TABLE IF EXISTS Person;
DROP TABLE IF EXISTS Person_Skills;
DROP TABLE IF EXISTS Person_Type;
DROP TABLE IF EXISTS Availability;
DROP TABLE IF EXISTS Address;
DROP TABLE IF EXISTS MEDIA;

CREATE TABLE IF NOT EXISTS MEDIA
(
Media_ID      		 	INT                    	 AUTO_INCREMENT PRIMARY KEY,
News   	    		VARCHAR(50) 	 NOT NULL,
Social_Media    		VARCHAR(50)    		 NOT NULL
);

CREATE TABLE IF NOT EXISTS Address   
(
Address_ID   		 INT   			 AUTO_INCREMENT PRIMARY KEY,
Address   		 VARCHAR(25)   	 NOT NULL,
City   			 VARCHAR(25)   	 NOT NULL,
State   			 VARCHAR(25)   	 NOT NULL,
Zip   			 VARCHAR(25)   	 NOT NULL,
Country   		 VARCHAR(25)   	 NOT NULL
);
CREATE TABLE IF NOT EXISTS Availability
(
Available_ID		INT		AUTO_INCREMENT, PRIMARY KEY,
AV_StartDate		DATE		NULL,
AV_EndDate		DATE		NULL
);
CREATE TABLE IF NOT EXISTS Person_Type
(
PersonType		INT			AUTO_INCREMENT PRIMARY KEY,
PtypeDesc		VARCHAR(50)	NOT NULL
);

CREATE TABLE IF NOT EXISTS Person_Skills
(
PSkill_ID 		INT 			AUTO_INCREMENT PRIMARY KEY,
Pskill_Desc		VARCHAR(50)	NOT NULL
);

CREATE TABLE IF NOT EXISTS  Person   
(
Person_ID   		 INT   			 AUTO_INCREMENT PRIMARY KEY ,
FirstName   		 VARCHAR(25)   	 NOT NULL,
LastName   		 VARCHAR(25)   	 NOT NULL,
Address_ID   		 INT   		 	 NOT NULL,    
Phone_Number   	 INT   			 NOT NULL,    
Driver_State_ID   	 INT   			 NOT NULL,
Email_Address   	 VARCHAR(25)   	 NOT NULL,
Gender   		 VARCHAR(25)   	 NOT NULL,
PersonType   		 CHAR(1)	   	 NOT NULL,
AV_ID			 INT			 NOT NULL,
Person_Skills		 INT	 		 NOT NULL
CONSTRAINT fk_address FOREIGN KEY (Address_ID) REFERENCES Address(Address_ID)
CONSTRAINT fk_persontype FOREIGN KEY (PersonType) REFERENCES Person_Type(PersonType),
CONSTRAINT fk_av_id FOREIGN KEY (AV_ID) REFERENCES Availability(AV_ID),
CONSTRAINT fk_personskill FOREIGN KEY (Pskill_ID) REFERENCES Person_Skills(Pskill_ID)
);

CREATE TABLE IF NOT EXISTS Task
(
Task_ID   		 INT   			 AUTO_INCREMENT PRIMARY KEY,
Task_Name   		 VARCHAR(25)   	 NOT NULL,
Task_DESC   		 VARCHAR(25)   	 NOT NULL);

CREATE TABLE IF NOT EXISTS   FEMA
(
Fema_ID   		 INT   		 	AUTO_INCREMENT PRIMARY KEY,
Cost_Code   		 VARCHAR(25)   	NOT NULL
);

CREATE TABLE IF NOT EXISTS Location
(
Location_ID    	 INT    			 AUTO_INCREMENT PRIMARY KEY,
Address   	 VARCHAR(25)   	 NOT NULL,
City   		 VARCHAR(25)   	 NOT NULL,
State   		 VARCHAR(25)   	 NOT NULL,
Zip   		 VARCHAR(25)   	 NOT NULL,
Country   	 VARCHAR(25)   	 NOT NULL
);

CREATE TABLE IF NOT EXISTS Resources
(
Resource_ID   	INT    			AUTO_INCREMENT PRIMARY KEY,
Location_ID   	 	INT     			NOT NULL,
Resource_Type    	VARCHAR(20)   	NOT NULL,
Resource_DESC    	VARCHAR(20)   	NOT NULL,

CONSTRAINT FK_Location FOREIGN KEY(Location_ID)
REFERENCES Location(Location_ID)
);

CREATE TABLE IF NOT EXISTS Project  
(
Project_ID   		 INT   		 AUTO_INCREMENT PRIMARY KEY,
Resource_ID   		 INT   		 NOT NULL,
Fema_ID   		 INT   			 NOT NULL,
CONSTRAINT FK_Resource_ID FOREIGN KEY (Resource_ID) REFERENCES  Resources(Resource_ID),
CONSTRAINT FK_Fema_ID FOREIGN KEY (Fema_ID) REFERENCES  FEMA(Fema_ID)
);


CREATE TABLE IF NOT EXISTS ENCOUNTER
(
Person_ID   	 	 INT    		 NOT NULL,
ENCOUNTER_ID   	 INT    		 UNIQUE AUTO_INCREMENT PRIMARY KEY,
CALL_CENTER_ID   	 INT   		 NOT NULL,
LOCATION_ID   	 INT   		 NOT NULL,
CREATE_DATE   	 DATE   	 NOT NULL,
CLOSE_DATE   	 DATE   	 NOT NULL,
MEDIA_ID   		 INT   		 NULL,
TASK_ID   		 INT   		 NOT NULL,
Project_ID   		 INT   		 NOT NULL,
Command_No   	 INT   		 NOT NULL,

CONSTRAINT FK_Person_ID FOREIGN KEY (Person_ID)
REFERENCES  Person(Person_ID)
);

CREATE TABLE IF NOT EXISTS Groups
(
Groups_ID   		 INT   			 AUTO_INCREMENT PRIMARY KEY,
Project_ID   		 INT   			 NOT NULL
);

CREATE TABLE IF NOT EXISTS   Product
(
Product_ID   			 INT   		 AUTO_INCREMENT PRIMARY KEY,
Resource_ID   			 INT   		 NOT NULL,
Fema_ID   			 INT   		 NOT NULL,

CONSTRAINT FK_Resource_Product_ID FOREIGN KEY (Resource_ID)
REFERENCES  Resources(Resource_ID),
CONSTRAINT FK_Fema_Product_ID FOREIGN KEY (Fema_ID)
REFERENCES FEMA(Fema_ID)
);

CREATE TABLE IF NOT EXISTS Project_Task
(
ProjectTask_ID   	 INT    			 AUTO_INCREMENT PRIMARY KEY,
Task_ID   		 INT   			 NOT NULL,
Project_ID   		 INT   			 NOT NULL,

CONSTRAINT FK_Task_ID     FOREIGN KEY (Task_ID)
REFERENCES  Task(Task_ID),
CONSTRAINT FK_Project FOREIGN KEY (Project_ID)
REFERENCES  Project(Project_ID)
);

CREATE TABLE IF NOT EXISTS   Special_Teams
(
Team_ID   		 INT   			 AUTO_INCREMENT PRIMARY KEY,
Groups_ID   		 INT   			 NOT NULL,

CONSTRAINT FK_Group_ID FOREIGN KEY (Groups_ID)
REFERENCES  Groups(Groups_ID)
);


CREATE TABLE IF NOT EXISTS  Project_Team
(
Project_Team   	 INT   			 AUTO_INCREMENT PRIMARY KEY,
Project_ID   	 	 INT   			 NOT NULL,
Team_ID   		 INT   			 NOT NULL,

CONSTRAINT FK_ProjectTeam_ID FOREIGN KEY (Project_ID)
REFERENCES  Project(Project_ID),
CONSTRAINT FK_Team_ID FOREIGN KEY (Team_ID)
REFERENCES  Special_Teams(Team_ID)
);

CREATE TABLE IF NOT EXISTS   Warehouse
(
Warehouse_ID   	 INT   			 AUTO_INCREMENT PRIMARY KEY,
Address_ID   		 INT   			 NOT NULL,
Location_ID   		 INT   			 NOT NULL,

CONSTRAINT FK_Address_ID FOREIGN KEY (Address_ID)
REFERENCES  Address(Address_ID),
CONSTRAINT FK_Location_ID FOREIGN KEY (Location_ID)
REFERENCES  Location(Location_ID)
);


CREATE TABLE IF NOT EXISTS CommandCenter
(
Command_NO   	 INT   	 UNIQUE AUTO_INCREMENT PRIMARY KEY,
Person_ID   	 INT   	 NOT NULL,

CONSTRAINT FK_PersonCommand_ID FOREIGN KEY (Person_ID)
REFERENCES  Person(Person_ID)
);

CREATE TABLE IF NOT EXISTS CallCenter
(
Call_Center_ID   	 INT   		 AUTO_INCREMENT PRIMARY KEY,
Address_ID   		 INT    NOT NULL,
Phone_Number   	 VARCHAR(25)    NOT NULL,

CONSTRAINT FK_Call_Address FOREIGN KEY (Address_ID)REFERENCES Address(Address_ID)
);


CREATE TABLE IF NOT EXISTS Disaster
(
Disaster_ID   	 INT   		 AUTO_INCREMENT PRIMARY KEY,
Encounter_ID   	 INT   		 NOT NULL,

CONSTRAINT FK_Encounter_ID FOREIGN KEY (Encounter_ID)
REFERENCES  ENCOUNTER(Encounter_ID)

);


CREATE TABLE IF NOT EXISTS   Warehouse_product_location

(
Warehouse_product_location_ID   	 INT   	 AUTO_INCREMENT PRIMARY KEY,
Warehouse_ID   			 INT   	 NOT NULL,
Location_ID   				 INT   	 NOT NULL,
Encounter_ID   				 INT   	 NOT NULL,
Address_ID   				 INT   	 NOT NULL,

CONSTRAINT FK_Warehouse_ID FOREIGN KEY (Warehouse_ID)
REFERENCES  Warehouse(Warehouse_ID),
CONSTRAINT FK_Warehouse_Location_ID FOREIGN KEY (Location_ID)
REFERENCES  Location(Location_ID),
CONSTRAINT FK_Warehouse_Encounter_ID FOREIGN KEY (Encounter_ID)
REFERENCES  ENCOUNTER(Encounter_ID),
CONSTRAINT FK_Warehouse_Address_ID FOREIGN KEY (Address_ID)
REFERENCES  Address(Address_ID)
);

CREATE TABLE IF NOT EXISTS Requestor_Order
(
Order_ID     INT    NOT NULL PRIMARY KEY,
Requestor     INT     NULL,
Encounter_ID    INT    NULL,
OrderPriority    INT    NULL,
OrderNum    INT    NULL,
ShipToAddress_ID    INT NULL,
OrderDeliveryType    INT NULL,
OrderPickUpDate    DATE NULL,
Call_In_Order_Qty    VARCHAR(8000) NULL,
Call_In_Order_Desc    VARCHAR(8000) NULL,

CONSTRAINT FK_Requestor_Order_Encounter_ID FOREIGN KEY (ENCOUNTER_ID)
REFERENCES ENCOUNTER(Encounter_ID)
);

CREATE TABLE IF NOT EXISTS   Order_Products

(
Order_Product_ID   		 INT   		 AUTO_INCREMENT PRIMARY KEY,
Order_ID   			 INT   		 NOT NULL,
Product_ID   			 INT   		 NOT NULL,
Warehouse_ID   			 INT   		 NOT NULL,
Order_Status   			 VARCHAR(25)   	 NOT NULL,

CONSTRAINT FK_Order_Products_OrderID_ID FOREIGN KEY (Order_ID)
REFERENCES  Requestor_Order(Order_ID),
CONSTRAINT FK_Order_Product_ID FOREIGN KEY (Product_ID)
REFERENCES  Product(Product_ID),
CONSTRAINT FK_Warehouse_Order_ID FOREIGN KEY (Warehouse_ID)
REFERENCES  Warehouse(Warehouse_ID)
);


