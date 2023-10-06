CREATE DATABASE Airline_reservation_systems
USE Airline_reservation_systems

--Creating Airport Table--

Create table Airport(
	Airportcode varchar(10) NOT NULL,
	Name varchar(50) NOT NULL,
	City varchar(50) NOT NULL,
	State varchar(50) NOT NULL,
	constraint Airport_pk primary key (Airportcode),
	CONSTRAINT checkAirport_Airportcode check (Airportcode LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9]')
);

--Creating Airplane_Type Table--

Create table Airplane_Type(
	TypeName varchar(50) NOT NULL,
	MaxNumOfSeats varchar(50) NOT NULL,
	Company varchar(50) NOT NULL,
	constraint Airplane_Type_pk primary key (TypeName),
);

--Creating Airplane_Type Table--

Create table Land(
	Airportcode varchar(10) NOT NULL,
	TypeName varchar(50) NOT NULL,
	constraint Land_pk primary key (Airportcode,TypeName),
	constraint Land_fk1 foreign key (Airportcode) REFERENCES Airport (Airportcode),
	constraint Land_fk2 foreign key (TypeName) REFERENCES Airplane_Type (TypeName),
);


--Creating Airplane Table--

Create table Airplane(
	AirplaneID varchar(10) NOT NULL,
	AirName varchar(50) NOT NULL,
	TotalNumOfSeats integer,
	TypeName varchar(50) NOT NULL,
	constraint airplane_pk primary key (AirplaneID),
	constraint airplane_fk foreign key (TypeName) REFERENCES Airplane_Type (TypeName),
	constraint checkAirplane_AirplaneID check (AirplaneID LIKE '[A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
);

--Creating Flight Table--

Create table Flight(
	FlightNo varchar(50) NOT NULL,
	AirlineName varchar(50) NOT NULL,
	ScheduleDate varchar(50) NOT NULL,
	constraint Flight_pk primary key (FlightNo),
	constraint checkFlight_FlightNo check (FlightNo LIKE '[A-Z][A-Z][0-9][0-9][0-9]')
);

--Creating Flight_Leg Table--

Create table Flight_Leg(
	LegNo varchar(10) NOT NULL,
	FlightNo varchar(50) NOT NULL,
	Airportcode varchar(10) NOT NULL,
	constraint Flight_Leg_pk primary key (LegNo,FlightNo),
	constraint Flight_Leg_fk1 foreign key (Airportcode) REFERENCES Airport (Airportcode),
	constraint Flight_Leg_fk2 foreign key (FlightNo) REFERENCES Flight (FlightNo)
);


--Creating Leg_instance Table--

Create table Leg_instance(
	Date date NOT NULL,
	LegNo varchar(10) NOT NULL,
	FlightNo varchar(50) NOT NULL,
	Ava_Seats varchar(50) NOT NULL,
	AirplaneID varchar(10) NOT NULL,
	Airportcode varchar(10) NOT NULL,
	constraint Leg_instance_pk primary key (Date,LegNo,FlightNo),
	constraint Leg_instance_fk1 foreign key (LegNo,FlightNo) REFERENCES Flight_Leg (LegNo,FlightNo),
	constraint Leg_instance_fk2 foreign key (AirplaneID) REFERENCES Airplane (AirplaneID),
	constraint Flight_Leg_fk3 foreign key (Airportcode) REFERENCES Airport (Airportcode),
);


--Creating Seat Table--

Create table Seat(
	Seat_No VARCHAR(10) DEFAULT 'Seat' NOT NULL,
	Date date NOT NULL,
	LegNo varchar(10) NOT NULL,
	FlightNo varchar(50) NOT NULL,
	CusName varchar(50),
	CusPhoneNo varchar(50),
	constraint Seat_pk primary key (Seat_No,Date,LegNo,FlightNo),
	constraint check_Seat_CusPhoneNo check (CusPhoneNo LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	constraint Seat_fk foreign key (Date,LegNo,FlightNo) REFERENCES Leg_instance (Date,LegNo,FlightNo)
);


--Creating Flight_fare Table--

Create table Flight_fare(
	Farecode varchar(20) NOT NULL,
	FlightNo varchar(50) NOT NULL,
	Amount varchar(20) NOT NULL,
	Restriction varchar(50) NOT NULL,
	constraint Flight_fare_pk primary key (Farecode,FlightNo),
	constraint Flight_fare_fk foreign key (FlightNo) REFERENCES Flight (FlightNo)
);


--Creating Airplane_Schedule Table--

CREATE TABLE Airplane_Schedule (
	AirplaneID varchar (10),
	arr_time time NOT NULL,
	dep_time time NOT NULL,
	constraint Airplane_Schedule_PK primary key (AirplaneID),
	constraint Airplane_Schedule_fk foreign key (AirplaneID) REFERENCES Airplane (AirplaneID)
);

--Creating Flight_Schedule Table--


CREATE TABLE Flight_Schedule (
	FlightNo varchar (50) NOT NULL,
	schedule_arr_time time(0) NOT NULL,
	schedule_dep_time time(0) NOT NULL,
	constraint Flight_schedule_PK primary key (FlightNo),  
	constraint Flight_Schedule_fk foreign key (FlightNo) REFERENCES Flight (FlightNo)
);



/*insert airport table*/
insert into Airport values('A020171','Sydney','San Mateo','California');
insert into Airport values('B020221','Frankfurt Airport','Frankfurt','Hesse');
insert into Airport values('C020271','Singapore','Salt Lake City','Utah');
insert into Airport values('D020251','Helsinki Airport','Ivalo','Kemi-Tornio');
insert into Airport values('E020230','Brisbane International Airport','Brisbane','Victoria');
insert into Airport values('F171223','Bandaranaike International Airport','katunayaka','Colombo');


/*insert Airplane_Type*/
insert into Airplane_Type values('Airlines 787','300',' Rolls Royce');
insert into Airplane_Type values('Airbus A330','600','Pratt & Whitney');
insert into Airplane_Type values('Boeing 747','400','Pratt & Whitney');
insert into Airplane_Type values('Boeing 757','500','Miami-based Eastern Airlines');
insert into Airplane_Type values('Douglas 80','200','Pratt & Whitney JT8-D');
insert into Airplane_Type values('Antonov AN28','350','LET Aircraft Industries');


/*insert Land*/
insert into Land values('A020171','Airlines 787');
insert into Land values('B020221','Airbus A330');
insert into Land values('C020271','Boeing 747');
insert into Land values('D020251','Boeing 757');
insert into Land values('E020230','Douglas 80');
insert into Land values('F171223','Antonov AN28');


/*insert Airplane*/
insert into Airplane values('R200171223','Douglas DC-3',295,'Boeing 757');
insert into Airplane values('N987654321','Airbus A321XLR ',467,'Boeing 747');
insert into Airplane values('Q224466889','COMAC C919',440,'Airbus A330');
insert into Airplane values('D779955331','Universal Hydrogen ATR 72',174,'Antonov AN28');


/*insert Flight*/
insert into Flight values('AL987','Air Berlin','2022-12-23');
insert into Flight values('TY456','Belair','2022-10-19');
insert into Flight values('KL203','Paramount','2022-11-04');
insert into Flight values('QE333','Oman Air','2022-10-26');
insert into Flight values('BH912','IndiGo','2023-01-02');
insert into Flight values('LK729','Jetstar Asia','2022-10-23');
insert into Flight values('PR914','SL Airways','2022-12-01');


/*insert Flight_leg*/
insert into Flight_leg values('2','AL987','A020171');
insert into Flight_leg values('3','PR914','B020221');
insert into Flight_leg values('4','AL987','C020271');
insert into Flight_leg values('1','QE333','D020251');
insert into Flight_leg values('2','LK729','E020230');
insert into Flight_leg values('3','BH912','F171223');


/*insert Leg_instance*/
insert into Leg_instance values('2022-11-14','2','AL987','74','R200171223','A020171');
insert into Leg_instance values('2022-12-23','3','PR914','52','N987654321','B020221');
insert into Leg_instance values('2023-01-01','2','LK729','158','D779955331','E020230');
insert into Leg_instance values('2022-12-14','1','QE333','74','Q224466889','D020251');


/*insert seat*/
insert into seat values('11F','2022-11-14','2','AL987','Kaun Perera','0859632147');
insert into seat values('55JH','2022-12-23','3','PR914','Niki watson','0856329741');
insert into seat values('14LA','2023-01-01','2','LK729','Mary Ann','1253698521');
insert into seat values('13HA','2022-12-14','1','QE333','Sadun perera','9476966518');


/*insert Flight_fare*/
insert into Flight_fare values('AF1015','AL987','650000','plastic');
insert into Flight_fare values('CDIJ17','TY456','275000','bring metal');
insert into Flight_fare values('GNQS03','KL203','74000','bring pets and plants');
insert into Flight_fare values('PW4589','QE333','65000','eat fish and meats');
insert into Flight_fare values('YBHKL1','PR914','54000','bring over 50KG travel bags');
insert into Flight_fare values('NQS144','BH912','41000','bring pets');
insert into Flight_fare values('NOQS51','LK729','41265','bring gold,spicies');


/*insert Airplane_Schedule*/
insert into Airplane_Schedule values('D779955331','09:28:48','15:45:47');
insert into Airplane_Schedule values('N987654321','01:11:18','08:15:27');
insert into Airplane_Schedule values('R200171223','11:31:48','19:45:47');
insert into Airplane_Schedule values('Q224466889','13:07:09','23:55:47');


/*insert Flight_Schedule*/
insert into Flight_Schedule values('AL987','08.07.09','14:58:14');
insert into Flight_Schedule values('TY456','00:14:15','07:13:17');
insert into Flight_Schedule values('KL203','10:27:26','18:08:16');
insert into Flight_Schedule values('QE333','12:48:17','00:05:05');
insert into Flight_Schedule values('BH912','07:22:26','14:08:16');
insert into Flight_Schedule values('PR914','17:48:17','04:05:05');





select *
from Airport;

select*
from Airplane_Type;

select*
from Land

select*
from Airplane

select*
from Flight

select*
from Flight_leg

select*
from Leg_instance

select*
from Seat

select*
from Flight_fare

select*
from Airplane_Schedule

--Views--

-- View for Airplane and Airport Details---

Create view Land_Details
As
	Select AP.Airportcode,AP.Name, A_T.TypeName, A_T.Company,A.AirplaneID, A.AirName,A_S.arr_time,A_S.dep_time
	From Airport AP, Airplane A, Airplane_Type A_T, Airplane_Schedule A_S, Land L
	Where AP.Airportcode = L.Airportcode AND 
		  A_T.TypeName = L.TypeName AND
		  A_T.TypeName = A.TypeName AND
		  A.AirplaneID = A_S.AirplaneID

select *
from Land_Details


-- View for Flight aand Flight Leg Details---

Create view FlightView
As
	Select f.FlightNo,F.AirlineName, fl.LegNo,fla.Amount,fla.Farecode, fl.Airportcode
	From  Flight f, Flight_fare fla, Flight_Leg fl
	Where f.FlightNo = fl.FlightNo AND
		  f.FlightNo = fla.FlightNo


select *
from FlightView




--Procedures--



-- procedure Number 01 --

Create Procedure QS1 (@Airport varchar(6) , @leg varchar(20) output )
AS
 begin
		Select  @leg = FL.LegNo
		From Flight_Leg FL, Airport A
		Where FL.Airportcode = A.Airportcode AND
			  A.Name = @Airport
End

Declare @LegN0 varchar(20)

Exec QS1 'Sydney', @LegN0 output

Print 'Leg No : ' + @LegN0


-- procedure Number 02 --

Create Procedure QS2 @AirportName varchar(20) , @Air_name varchar(50) output
AS
 begin
		Select @Air_name = A.airname 
		From  Airport AP , Airplane_Type A_T , Land L , Airplane A
		Where AP.Airportcode = L.Airportcode AND
		      A_T.TypeName = L.TypeName AND
		      A_T.TypeName = A.TypeName AND
	              AP.name = @AirportName
End

DECLARE @A_Name varchar(50)

EXEC QS2 'Singapore' , @A_Name output

print 'Airplane Name : ' + @A_Name

select * 
from Airport

select *
from Airplane_Type

select *
from Airplane


-- procedure Number 03 --

CREATE PROCEDURE QS3 @FlightNO VARCHAR(20) , @increase FLOAT
AS
	BEGIN 
			UPDATE Flight_fare
			SET amount = amount + amount * (@increase/100)
			WHERE FlightNo = @FlightNO
	END

DECLARE @F_NO VARCHAR(20)

EXEC QS3 'KL203' , 20


select * 
from Flight_fare

-- procedure Number 04 --

CREATE PROCEDURE Find_Flight_Details @Cus_Num VARCHAR(20) , @Flight_NO VARCHAR(20) OUTPUT
AS
	BEGIN 
			SELECT @Flight_NO = FL.FlightNo
			FROM Flight_leg FL , Seat S
			WHERE FL.FlightNo= S.FlightNo AND
				  S.CusName = @Cus_Num
    END

DECLARE @F_NO VARCHAR(20)

EXEC Find_Flight_Details 'Mary Ann' , @F_NO OUTPUT 

PRINT 'Flight NO : ' + @F_NO

SELECT * FROM Flight_leg
SELECT * FROM Seat

--Indexes--

--Create index in Number of seats for Airplane--
--index 01

CREATE INDEX NoOfSeats_Airplane_IDX
ON Airplane (AirName , TotalNumOfSeats);

--create index in Flight schedule table for Schedule --
--index 02

CREATE INDEX Flight_details_IDX
ON Flight_schedule (schedule_arr_time , schedule_dep_time)



--Triggers--

--Tigger 01--

--if change the flight flight_number on the flight table immediately update the flight_number of the Flight_schedule table--

CREATE TRIGGER Flight_NO_Update
ON Flight
AFTER UPDATE
AS
BEGIN

	DECLARE @OldFlightNo INT, @NewFlightNo  INT
	SELECT @OldFlightNo = FlightNo FROM deleted
	SELECT @NewFlightNo = FlightNo FROM inserted
	UPDATE Flight_schedule SET FlightNo =@NewFlightNo WHERE FlightNo = @OldFlightNo

END


--Tigger 02--

--if change the Airplane AirplaneID on the Airplane table immediately update the AirplaneID of the Airplane_Schedule table--

CREATE TRIGGER AirplaneID_Update
ON Airplane
AFTER UPDATE
AS
BEGIN

	DECLARE @OldAirplaneID INT, @NewAirplaneID  INT
	SELECT @OldAirplaneID = AirplaneID FROM deleted
	SELECT @NewAirplaneID = AirplaneID FROM inserted
	UPDATE Airplane_Schedule SET AirplaneID =@NewAirplaneID WHERE AirplaneID = @OldAirplaneID

END


--Insert Trigger ---

CREATE TRIGGER Update_Seat_Details
ON Leg_instance
FOR INSERT
AS
BEGIN
DECLARE @S_date DATE , @L_No INT , @F_NO VARCHAR(10)

SELECT @S_date = date , @L_No = LegNo , @F_NO = FlightNo  FROM inserted

INSERT INTO Seat (date,LegNo,FlightNo) values (@S_date,@L_No,@F_NO)

END

select *
from  Leg_instance

insert into Leg_instance values('2022-12-15','3','BH912','79','Q224466889','D020251');

