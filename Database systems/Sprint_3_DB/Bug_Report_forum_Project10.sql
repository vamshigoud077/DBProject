CREATE TABLE `User` (
  `user_ID` varchar(15) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `First_name` varchar(255) NOT NULL,
  `Last_name` varchar(255) NOT NULL,
  `Middle_name` varchar(255) DEFAULT NULL,
  `email_ID` varchar(255) NOT NULL,
  PRIMARY KEY (`user_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Developer` (
  `Developer_ID` varchar(15) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `First_name` varchar(255) NOT NULL,
  `Last_name` varchar(255) NOT NULL,
  `Middle_name` varchar(255) DEFAULT NULL,
  `email_ID` varchar(255) NOT NULL,
  `salary_per_annum` int(30) DEFAULT NULL,
  PRIMARY KEY (`Developer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `EscalationEngineer` (
  `EscalationEngineer_ID` varchar(15) NOT NULL,
  `Password` varchar(45) NOT NULL,
  `First_name` varchar(255) NOT NULL,
  `Last_name` varchar(255) NOT NULL,
  `Middle_name` varchar(255) DEFAULT NULL,
  `email_ID` varchar(255) NOT NULL,
  `Salary_per_annum` int(30) DEFAULT NULL,
  PRIMARY KEY (`EscalationEngineer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Game` (
  `Game_ID` varchar(15) NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Platform` varchar(255) NOT NULL,
  `published_on` date DEFAULT NULL,
  `Published_by` varchar(255) NOT NULL,
  PRIMARY KEY (`Game_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `DevelopersTeams` (
  `Developer_Team_ID` varchar(15) NOT NULL,
  `Game_ID` varchar(15) NOT NULL,
  `Total_members` int(255) DEFAULT NULL,
  PRIMARY KEY (`Developer_Team_ID`),
  KEY `fk_1` (`Game_ID`),
  CONSTRAINT `DevelopersTeams_ibfk_1` FOREIGN KEY (`Game_ID`) REFERENCES `Game` (`Game_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `EscalationTeams` (
  `Escalation_Team_ID` varchar(15) NOT NULL,
  `Game_ID` varchar(15) NOT NULL,
  `Total_members` int(255) DEFAULT NULL,
  PRIMARY KEY (`Escalation_Team_ID`),
  KEY `Game_ID` (`Game_ID`),
  CONSTRAINT `EscalationTeams_ibfk_1` FOREIGN KEY (`Game_ID`) REFERENCES `Game` (`Game_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Developer_Works_for` (
  `Developer_ID` varchar(15) NOT NULL,
  `Team_ID` varchar(15) NOT NULL,
  `Working_since` date DEFAULT NULL,
  PRIMARY KEY (`Developer_ID`,`Team_ID`),
  KEY `fk_devteam` (`Team_ID`),
  CONSTRAINT `Developer_Works_for_ibfk_1` FOREIGN KEY (`Developer_ID`) REFERENCES `Developer` (`Developer_ID`),
  CONSTRAINT `Developer_Works_for_ibfk_2` FOREIGN KEY (`Team_ID`) REFERENCES `DevelopersTeams` (`Developer_Team_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `EscalationEngineer_Works_for` (
  `EscalationEngineer_ID` varchar(15) NOT NULL,
  `Team_ID` varchar(15) NOT NULL,
  `Working_since` datetime DEFAULT NULL,
  PRIMARY KEY (`EscalationEngineer_ID`,`Team_ID`),
  KEY `fk_team` (`Team_ID`),
  CONSTRAINT `EscalationEngineer_Works_for_ibfk_1` FOREIGN KEY (`EscalationEngineer_ID`) REFERENCES `EscalationEngineer` (`EscalationEngineer_ID`),
  CONSTRAINT `EscalationEngineer_Works_for_ibfk_2` FOREIGN KEY (`Team_ID`) REFERENCES `EscalationTeams` (`Escalation_Team_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Games_Played_by_User` (
  `user_ID` varchar(15) NOT NULL,
  `Game_ID` varchar(15) NOT NULL,
  `Playing_since` datetime DEFAULT NULL,
  PRIMARY KEY (`user_ID`,`Game_ID`),
  Foreign key (user_ID) REFERENCES User(User_ID),
  Foreign Key (Game_ID) References Game(Game_ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Bug_Update` (
  `update_ID` varchar(15) NOT NULL,
  `released_by` varchar(15) NOT NULL,
  `Game_ID_for_Update` varchar(15) NOT NULL,
  `Update_version` decimal(10,4) DEFAULT NULL,
  `Description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`update_ID`),
  KEY `released_by` (`released_by`),
  KEY `Game_ID_for_Update` (`Game_ID_for_Update`),
  CONSTRAINT `Bug_Update_ibfk_1` FOREIGN KEY (`released_by`) REFERENCES `Developer` (`Developer_ID`),
  CONSTRAINT `Bug_Update_ibfk_2` FOREIGN KEY (`Game_ID_for_Update`) REFERENCES `Game` (`Game_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Master_Request` (
  `Master_Request_ID` varchar(20) NOT NULL,
  `Opened_by` varchar(15) DEFAULT NULL,
  `Time_created` datetime DEFAULT NULL,
  `Owner_Ship` varchar(15) DEFAULT NULL,
  `Last_modified` datetime DEFAULT NULL,
  `Game_ID_for_Request` varchar(15) DEFAULT NULL,
  `Closed_by` varchar(15) DEFAULT NULL,
  `Assigned_Team_ID` varchar(15) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `Bug_type` varchar(255) DEFAULT NULL,
  `Bug_description` varchar(255) DEFAULT NULL,
  `update_ID` varchar(255) DEFAULT NULL,
  `Priority` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Master_Request_ID`),
  KEY `Owner_Ship` (`Owner_Ship`),
  KEY `Closed_by` (`Closed_by`),
  KEY `update_ID` (`update_ID`),
  KEY `Opened_by` (`Opened_by`),
  KEY `Assigned_Team_ID` (`Assigned_Team_ID`),
  CONSTRAINT `Master_Request_ibfk_1` FOREIGN KEY (`Owner_Ship`) REFERENCES `Developer` (`Developer_ID`),
  CONSTRAINT `Master_Request_ibfk_2` FOREIGN KEY (`Closed_by`) REFERENCES `Developer` (`Developer_ID`),
  CONSTRAINT `Master_Request_ibfk_3` FOREIGN KEY (`update_ID`) REFERENCES `Bug_Update` (`update_ID`),
  CONSTRAINT `Master_Request_ibfk_4` FOREIGN KEY (`Opened_by`) REFERENCES `EscalationEngineer` (`EscalationEngineer_ID`),
  CONSTRAINT `Master_Request_ibfk_5` FOREIGN KEY (`Assigned_Team_ID`) REFERENCES `DevelopersTeams` (`Developer_Team_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `Request` (
  `Request_ID` varchar(20) NOT NULL,
  `Master_Request_ID` varchar(20) DEFAULT NULL,
  `Opened_by` varchar(15) DEFAULT NULL,
  `Time_created` datetime DEFAULT NULL,
  `Owner_Ship` varchar(15) DEFAULT NULL,
  `Last_modified` datetime DEFAULT NULL,
  `Game_ID_for_Request` varchar(15) DEFAULT NULL,
  `Closed_by` varchar(15) DEFAULT NULL,
  `Assigned_Team_ID` varchar(15) DEFAULT NULL,
  `Status` varchar(45) DEFAULT NULL,
  `Bug_type` varchar(255) DEFAULT NULL,
  `Bug_description` varchar(255) DEFAULT NULL,
  `Resolution` varchar(255) DEFAULT NULL,
  `Priority` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Request_ID`),
  KEY `Owner_Ship` (`Owner_Ship`),
  KEY `Closed_by` (`Closed_by`),
  KEY `Opened_by` (`Opened_by`),
  KEY `Assigned_Team_ID` (`Assigned_Team_ID`),
  KEY `fk_master` (`Master_Request_ID`),
  CONSTRAINT `Request_ibfk_1` FOREIGN KEY (`Owner_Ship`) REFERENCES `EscalationEngineer` (`EscalationEngineer_ID`),
  CONSTRAINT `Request_ibfk_2` FOREIGN KEY (`Closed_by`) REFERENCES `EscalationEngineer` (`EscalationEngineer_ID`),
  CONSTRAINT `Request_ibfk_3` FOREIGN KEY (`Opened_by`) REFERENCES `User` (`user_ID`),
  CONSTRAINT `Request_ibfk_4` FOREIGN KEY (`Assigned_Team_ID`) REFERENCES `EscalationTeams` (`Escalation_Team_ID`),
  CONSTRAINT `Request_ibfk_5` FOREIGN KEY (`Master_Request_ID`) REFERENCES `Master_Request` (`Master_Request_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


	insert into User values('user1','romonoff','john','smith','lynn','johnsmit@gmail.com'),('user2','cringe','tom','cruise','ethan','tom@gmail.com'),
	('user3','cliffhord','jisoo','black','pink','jisoo@gmail.com'),('user4','gerard','gerard','buttler','lynn','gerard105@gmail.com');

Select *from User;

	insert into  Developer values('dev1','deadlift','elon','musk','Winter','elon@gmail.com',130000),
	('dev2','crono','faceless','void','freeman','faceless@gmail.com',160000),
	('dev3','omnilash','juggernaut','mask','sword','juggy@gmail.com',130000),
	('dev4','crit','aegon','targaryen','Henry','targaryen@gmail.com',120000),
	('dev5','sniper','jorah','mormont','Allan','jorah@gmail.com',115000);

Select*from Developer;

	Insert into EscalationEngineer values('esc1','looper','maisie','williams','lake','maisie@gmail.com',85000),('esc2','cooper234','john','wick','Ash','johnwick@gmail.com',90000),
	('esc3','diehard223','william','wallace','rio','wallace@gmail.com',70000),('esc4','jan231995','thomas','hank','jofferey','tomhank@gmail.com',80000),
	('esc5','bohthard','lee','cooper','joy','coopsloops@gmail.com',90000);

Select *from EscalationEngineer;

	Insert INTO Game values('GM1','Apex Legends','PC','2019-02-04','Respawn'),('GM2','Apex Legends','XBOX','2019-02-04','Respawn'),
	('GM3','Dota2','PC','2013-07-09','Valve Corporation'),('GM4','PUBG','PC','2017-03-23','Bluehole'),('GM5','WARFRAME','PC','2013-03-25','Digital Extremes'),
	('GM6','Call of Duty:Black Ops 4','PC','2018-10-12','Activision'),('GM7','Witcher3: wild Hunt','PC','2015-04-19','CD Projekt'),
	('GM8','Counter-Strike: Global Offensive','PC','2012-08-21','Valve Corporation'),('GM9','Far Cry 3','PC','2012-11-29','Ubisoft'),
	('GM10','God of War 2018','PC','2018-04-20','Sony Interactive Entertainment');

Select *from Game;

	INSERT INTO DevelopersTeams values('DT1','GM1',5),('DT2','GM2',3),('DT3','GM3',7),('DT4','GM4',6),
	('DT5','GM5',7),('DT6','GM6',8),('DT7','GM7',3),('DT8','GM8',4),('DT9','GM9',5),('DT10','GM10',5);

Select *from DevelopersTeams;

	INSERT INTO EscalationTeams values('ET1','GM1',2),('ET2','GM2',1),('ET3','GM3',3),('ET4','GM4',2),
	('ET5','GM5',4),('ET6','GM6',4),('ET7','GM7',2),('ET8','GM8',4),('ET9','GM9',2),('ET10','GM10',3);

Select *from EscalationTeams;

	INSERT INTO Developer_Works_for values ('dev1','DT1','2018-03-15'),('dev2','DT2','2012-06-19'),('dev3','DT3','2009-02-27'),
	('dev4','DT4','2005-03-17'),('dev5','DT5','2016-02-12'),('dev3','DT8','2009-02-27');

Select *from Developer_Works_for;

	INSERT INTO EscalationEngineer_Works_for values('esc1','ET1','2018-03-12'),('esc2','ET2','2011-12-31'),
	('esc3','ET3','2002-06-26'),('esc4','ET4','2001-02-11'),('esc5','ET5','2003-05-01'),('esc3','ET8','2015-11-18');

Select *from EscalationEngineer_Works_for;

	INSERT INTO Games_Played_by_User values('user1','GM1','2019-03-15'),('user1','GM3','2016-02-21'),('user1','GM5','2015-04-21'),('user1','GM6','2016-04-12'),('user2','GM5','2014-11-11'),
	('user2','GM8','2015-05-13'),('user3','GM7','2016-05-15'),('user3','GM3','2014-01-21'),('user3','GM9','2013-01-18'),('user3','GM2','2019-03-16'),('user4','GM4','2018-02-02'),
	('user4','GM10','2018-07-19'),('user4','GM2','2019-04-03');
    
Select *from Games_Played_by_User; 
    
    INSERT INTO Bug_Update values('BU1','dev1','GM1','1.2','server connection problems are rectcified');
	INSERT INTO Bug_Update values('BU2','dev2','GM2','1.3','server connection problems are rectcified'),('BU3','dev3','GM3','3.3','Graphics and sound issue resolved'),('BU4','dev3','GM3','3.4','Crash to desktop issue resolved'),
	('BU5','dev3','GM3','3.5','As per the customers feedback added new  map'),('BU6','dev4','GM4','4.1','minor bugs removed'),('BU7','dev4','GM4','4.2','New hoods added to improve customers experience'),('BU8','dev4','GM4','4.3','Ccrash to desktop issue resolved');
	INSERT INTO Bug_Update values('BU9','dev5','GM5','5.1','Sabotage map added'),('BU10','dev5','GM5','5.2','New missions added and incorporated rocket boostein hero\'s suite.');
	INSERT INTO Bug_Update values('BU11','dev5','GM5','5.2','Bug related to gun jamming is resolved');
	INSERT INTO Bug_Update values('BU12','dev3','GM8','8.1','De_dust map added'),('BU13','dev3','GM8','8.2','Graphics & Sound issues addressed'),
	('BU14','dev3','GM8','8.3','enhanced quality of mic');

Select *from Bug_Update;

	INSERT INTO Master_Request values('MR1','esc1','2019-04-16','dev1',now(),'GM1',NULL,'DT1','work in progress','crash to Desktop','Game crashed suddenly while i was playing. please help',NULL,'P1');
	INSERT INTO Master_Request values('MR4','esc2',now(),'dev2',now(),'GM2',NULL,'DT2','work in progress','crash to Desktop','Game crashed suddenly while i was playing. please help',NULL,'P1');
	INSERT INTO Master_Request values('MR2','esc1','2019-03-22','dev1','2019-04-22','GM1','dev1','DT1','closed','server','couldnt open doorthat was supposed to open to advance to the next room.','BU1','P2');
	INSERT INTO Master_Request values('MR3','esc2','2019-02-25','dev2','2019-03-02','GM2','dev2','DT2','closed','server','couldnt open doorthat was supposed to open to advance to the next room.','BU2','P2');
	INSERT INTO Master_Request values('MR5','esc3','2019-02-12','dev3','2019-02-22','GM3','dev3','DT3','closed','Graphics and Sound issues','customers are observing lag between action and sound.Can you please look in to this ','BU3','P2');
	INSERT INTO Master_Request values('MR6','esc3','2019-04-16','dev3','2019-04-21','GM3','dev3','DT3','closed','crash to desktop','Game is crashing all of a sudden','BU4','P1');
	Insert Into Master_Request values('MR7','esc3','2019-01-17','dev3','2019-03-21','GM3','dev3','DT3','closed','Customers got bored of old map','please develop new map customers are raising requests for adding new maps','BU5','P3');
	Insert Into Master_Request values('MR8','esc4','2018-12-15','dev4','2019-02-01','GM4','dev4','DT4','closed','minor bugs','There\'s no sync between lip moment and voice of character','BU6','P3');
    Insert Into Master_Request values('MR9','esc4','2019-02-18','dev4','2018-03-25','GM4','dev4','DT4','closed','Customers requesting for new hoods','Customer\'s requesting for new hoods','BU7','P3');
	Insert Into Master_Request values('MR10','esc4','2019-03-18','dev4','2019-03-30','GM4','dev4','DT4','closed','Crash to desktop','All of a sudden game is crashing','BU8','P1');
	Insert Into Master_Request values('MR11','esc5','2018-11-03','dev5','2019-03-16','GM5','dev5','DT5','closed','Add new maps','Add new maps','BU9','P3');
	Insert Into Master_Request values('MR12','esc5','2018-12-03','dev5','2019-03-16','GM5','dev5','DT5','closed','Add new missions','Users requesting for new missions','BU10','P3');
	Insert Into Master_Request values('MR13','esc5','2019-02-01','dev5','2019-02-23','GM5','dev5','DT5','closed','weapon autofiring','weapon started autofiring without pulling trigger','BU11','P2');
    INSERT INTO Master_Request values('MR14','esc3','2019-01-15','dev3','2019-02-25','GM8','dev3','DT8','closed','Add new maps','user\'s are requesting for new maps','BU12','P3');
    INSERT INTO Master_Request values('MR15','esc3','2019-03-12','dev3','2019-03-21','GM8','dev3','DT8','closed','Graphics and sound issues','User\'s facing issue with game sound and graphics','BU13','P2');
    INSERT INTO Master_Request values('MR16','esc3','2019-03-02','dev3','2019-03-28','GM8','dev3','DT8','closed','mic issue','Streamers facing interference issues','BU14','P2');
	
Select *from Master_Request;
    
    INSERT INTO Request values('R1','MR1','user1','2019-04-15','esc1','2019-04-17','GM1',NULL,'ET1','work in progress','crash to Desktop','Game crashed suddenly while i was playing. please help',NULL,'P1');
	INSERT INTO Request values('R2','MR2','user2','2019-03-15','esc1','2019-03-22','GM1','esc1','ET1','closed','server','couldnt open doorthat was supposed to open to advance to the next room.','refer master ticket for resolution','P2');
    INSERT INTO Request values('R3','MR3','user3','2019-02-21','esc2','2019-03-02','GM2','esc2','ET2','closed','server','couldnt open doorthat was supposed to open to advance to the next room.','refer master ticker','P2');
    INSERT INTO Request values('R4','MR3','user4','2019-02-20','esc2','2019-03-02','GM2','esc2','ET2','closed','server','couldnt open doorthat was supposed to open to advance to the next room.','refer master ticket','P2');
	INSERT INTO Request values('R5','MR4','user3','2019-04-22','esc2',now(),'GM2',NULL,'ET2','work in progress','crash to Desktop','Game crashed suddenly while i was playing. please help','refer  master request','P1');
	INSERT INTO Request values('R6','MR4','user4','2019-04-20','esc2',now(),'GM2',NULL,'ET2','work in progress','crash to Desktop','Game crashed suddenly while i was playing. please help','refer  master request','P1');
    INSERT INTO Request values('R7','MR5','user1','2019-02-10','esc3','2019-02-22','GM3','esc3','ET3','closed','Graphics and Sound issues','customers are observing lag between action and sound.Can you please look in to this ','Refer master ticket field','P2');
    INSERT INTO Request values('R8','MR5','user3','2019-02-08','esc3','2019-02-22','GM3','esc3','ET3','closed','Graphics and Sound issues','customers are observing lag between action and sound.Can you please look in to this ','Refer master ticket field','P2');
	INSERT INTO Request values('R9','MR6','user1','2019-04-13','esc3','2019-04-21','GM3','esc3','ET3','closed','crash to desktop','Game is crashing all of a sudden','refer master request field','P1');
	INSERT INTO Request values('R10','MR6','user3','2019-04-13','esc3','2019-04-21','GM3','esc3','ET3','closed','crash to desktop','Game is crashing all of a sudden','refer master request field','P1');
	Insert Into Request values('R11','MR7','user3','2019-01-16','esc3','2019-03-21','GM3','esc3','ET3','closed','Customers got bored of old map','please develop new map customers are raising requests for adding new maps','refer master request','P3');
	Insert Into Request values('R12','MR8','user4','2018-12-14','esc4','2019-02-01','GM4','esc4','ET4','closed','minor bugs','There\'s no sync between lip moment and voice of character','refer master request','P3');
    Insert Into Request values('R13','MR9','user4','2019-02-17','esc4','2018-03-25','GM4','esc4','ET4','closed','Customers requesting for new hoods','Customer\'s requesting for new hoods','refer master request','P3');
	Insert Into Request values('R14','MR10','user4','2019-03-17','esc4','2019-03-30','GM4','esc4','ET4','closed','Crash to desktop','All of a sudden game is crashing','Refer master request field','P1');
	Insert Into Request values('R15','MR11','user1','2018-11-02','esc5','2019-03-16','GM5','esc5','ET5','closed','Add new maps','Add new maps','refer master request field','P3');
	Insert Into Request values('R16','MR11','user2','2018-11-01','esc5','2019-03-16','GM5','esc5','ET5','closed','Add new maps','Add new maps','refer master request','P3');
    Insert Into Request values('R17','MR12','user1','2018-12-02','esc5','2019-03-16','GM5','esc5','ET5','closed','Add new missions','Users requesting for new missions','refer master request','P3');
    Insert Into Request values('R18','MR12','user2','2018-12-02','esc5','2019-03-16','GM5','esc5','ET5','closed','Add new missions','Users requesting for new missions','refer master request','P3');
	Insert Into Request values('R19','MR13','user1','2019-01-31','esc5','2019-02-23','GM5','esc5','ET5','closed','weapon autofiring','weapon started autofiring without pulling trigger','refer master request field','P2');
    INSERT INTO Request values('R20','MR14','user2','2019-01-14','esc3','2019-02-25','GM8','esc3','ET8','closed','Add new maps','user\'s are requesting for new maps','refer master reqqest field','P3');
    INSERT INTO Request values('R21','MR15','user2','2019-03-11','esc3','2019-03-21','GM8','esc3','ET8','closed','Graphics and sound issues','User\'s facing issue with game sound and graphics','refer master request','P2');
    INSERT INTO Request values('R22','MR16','user2','2019-03-01','esc3','2019-03-28','GM8','esc3','ET8','closed','mic issue','Streamers facing interference issues','Refer master request','P2');
	
Select *from Request;

Select t1.Request_ID,t2.EscalationEngineer_ID,t4.Developer_ID,t6.Game_ID,t6.Name Game_Name,t1.Priority,
t1.Status,t5.update_ID,t5.Description Bug_description
from Request t1
INNER JOIN EscalationEngineer t2 ON t2.EscalationEngineer_ID = t1.Owner_Ship
INNER JOIN Master_Request t3 ON t3.Master_Request_ID = t1.Master_Request_ID
INNER JOIN Developer t4 ON t4.Developer_ID = t3.Owner_Ship
INNER JOIN Bug_Update t5 ON t5.update_ID = t3.update_ID
INNER JOIN Game t6 ON t6.Game_ID = t1.Game_ID_for_Request
WHERE t1.Request_ID = 'R11';

call Request_Details('R11');

Select t1.Developer_ID,concat(t1.First_name,' ',t1.Middle_name,' ',t1.Last_name) Developer_name,t2.Team_ID Team,
t4.Game_ID,t4.Name Game_Name,t6.Request_ID,t2.Working_since
from Developer t1
INNER JOIN Developer_Works_for t2 On t2.Developer_ID = t1. Developer_ID
INNER JOIN DevelopersTeams t3 ON t3.Developer_Team_ID = t2.Team_ID
INNER JOIN Game t4 ON t4.Game_ID = t3.Game_ID
INNER JOIN Games_Played_by_User t5 ON t5.Game_ID = t4.Game_ID
INNER JOIN Request t6 ON t6.Opened_by = t5.user_ID
WHERE t1.Developer_ID = 'dev5'
ORDER BY t6.Request_ID;

call Developer_Details('dev5');

Select *from User;

Select t1.user_ID, concat(t1.First_name,' ',t1.Middle_name,' ',t1.Last_name) User_name,t2.Request_ID, t2.Status, 
t2.Priority, t2.Time_created, t3.Game_ID, t3.Name Game_Name, t4.update_ID, t4.released_by 
from User t1
INNER JOIN Request t2 ON t2.Opened_by = t1.user_ID
INNER JOIN Game t3 ON t3.Game_ID = t2.Game_ID_for_Request
INNER JOIN Bug_Update t4 ON t4.Game_ID_for_Update = t3.Game_ID
Where t1.user_ID = 'user4'
GROUP BY (Request_ID);

Select t1.Game_ID,t1.Name Game_Name,count(t2.Request_ID) Number_of_Requests,t4.Developer_ID,
concat(t4.First_name,' ',t4.Middle_name,' ',t4.Last_name) Developer_name 
from Game t1
INNER JOIN Request t2 ON t2.Game_ID_for_Request = t1.Game_ID
INNER JOIN Master_Request t3 ON t3.Master_Request_ID = t2.Request_ID
INNER JOIN Developer t4 On t3.Owner_Ship = t4.Developer_ID
Where t1.Game_ID = 'GM4'
GROUP BY (t1.Game_ID);

Select t1.Game_ID,t1.Name Game_Name,count(t2.Request_ID) Number_of_Requests 
from Game t1
INNER JOIN Request t2 ON t2.Game_ID_for_Request = t1.Game_ID
Where t1.Game_ID = 'GM4'
GROUP BY (t1.Game_ID);

CREATE VIEW Request_Details AS
Select Request_ID,Opened_by,Closed_by,Status from Request;

CREATE VIEW Game_Requests AS
Select t1.Game_ID,t1.Name Game_Name,count(t2.Request_ID) Number_of_Requests 
from Game t1
INNER JOIN Request t2 ON t2.Game_ID_for_Request = t1.Game_ID
Where t1.Game_ID = 'GM5'
GROUP BY (t1.Game_ID);

CREATE VIEW User_EscalationEngineer_View AS
Select t1.user_ID, concat(t1.First_name,' ',t1.Middle_name,' ',t1.Last_name) User_name,t2.Request_ID, t2.Status, 
t2.Priority, t2.Time_created, t3.Game_ID, t3.Name Game_Name, t4.update_ID, t4.released_by 
from User t1
INNER JOIN Request t2 ON t2.Opened_by = t1.user_ID
INNER JOIN Game t3 ON t3.Game_ID = t2.Game_ID_for_Request
INNER JOIN Bug_Update t4 ON t4.Game_ID_for_Update = t3.Game_ID
Where t1.user_ID = 'user1'
GROUP BY (Request_ID);

Select t1.update_ID,t1.released_by Developer_ID,t1.Description,t2.Game_ID,t2.Name,t4.Request_ID
from Bug_Update t1
INNER JOIN Game t2 ON t2.Game_ID = t1.Game_ID_for_Update
INNER JOIN Request t4 ON t4.Request_ID = t1.Bug_Request
Where t4.Request_ID = 'R1';

Select *from User_EscalationEngineer_View;

Select *from Game_Requests;
Select *from Request_Details;

Select *from Request_Details;

CREATE INDEX User_full_name ON User (First_name, Last_name);
CREATE INDEX User_Email ON User (email_ID);
SHOW INDEX FROM User;

CREATE INDEX Developer_full_name ON Developer (First_name, Last_name);
CREATE INDEX Developer_Email_ID ON Developer (email_ID);
CREATE INDEX Developer_Salary ON Developer (salary_per_annum ASC);
SHOW INDEX FROM Developer;
Select *from Developer;

CREATE INDEX EscalationEngineer_full_name ON EscalationEngineer (First_name, Last_name);
CREATE INDEX EscalationEngineer_Email_ID ON EscalationEngineer (email_ID);
CREATE INDEX EscalationEngineer_Salary ON EscalationEngineer (salary_per_annum ASC);
SHOW INDEX FROM EscalationEngineer;
Select *from EscalationEngineer;

Select *from Game;

CREATE INDEX Game_Name ON Game (Name);
CREATE INDEX Game_Publisher ON Game (Published_by);
SHOW INDEX FROM Game;

SHOW INDEX FROM DevelopersTeams;

SHOW INDEX FROM EscalationTeams;

CREATE INDEX Developer_WorkingPeriod ON Developer_Works_for (Working_since ASC);
SHOW INDEX FROM Developer_Works_for;
Select *from Developer_Works_for;

CREATE INDEX Escalation_WorkingPeriod ON EscalationEngineer_Works_for (Working_since ASC);
SHOW INDEX FROM EscalationEngineer_Works_for;
Select *from EscalationEngineer_Works_for;

CREATE INDEX User_PlayingPeriod ON Games_Played_by_User (Playing_since ASC);
SHOW INDEX FROM Games_Played_by_User;
Select *from Games_Played_by_User;

SHOW INDEX FROM Bug_Update;

CREATE INDEX Master_Request_CreatedTime ON Master_Request (Time_created ASC);
CREATE INDEX Master_Request_Status ON Master_Request (Status);
CREATE INDEX Master_Request_Priority ON Master_Request (Priority);
SHOW INDEX FROM Master_Request;
Select *from Master_Request;

CREATE INDEX Request_CreatedTime ON Request (Time_created ASC);
CREATE INDEX Request_Status ON Request (Status);
CREATE INDEX Request_Priority ON Request (Priority);
SHOW INDEX FROM Request;
Select *from Request;

DELIMITER $$
CREATE TRIGGER after_request_insert
before insert ON request
FOR EACH ROW
BEGIN
SET 
new.Last_modified = current_timestamp();
END  $$
DELIMITER ;

INSERT INTO Request values('R23','MR17','user2','2019-03-09','esc4','2019-08-31',
'GM8','esc3','ET8','closed','keybord issue','UI issue','Refer master request','P2');

DELIMITER $$
CREATE TRIGGER after_update_master_request
after update ON master_request
FOR EACH ROW
BEGIN
if new.status="closed" then
update request set status="closed" where Master_Request_ID=new.Master_Request_ID;
end if;
END  $$
DELIMITER ;

UPDATE  master_request set status="closed" where  Master_Request_ID="MR1";

Select *from Master_Request;
Select *from Request;

DELIMITER $$
CREATE EVENT Last_modified_Deletion
ON SCHEDULE EVERY 1 day
STARTS CURRENT_TIMESTAMP
DO 
BEGIN
DELETE FROM Master_Request
WHERE Last_modified < DATE_SUB(curdate(), INTERVAL 365 DAY);
END$$
DELIMITER ;

DELIMITER $$
CREATE EVENT Last_modified_Deletion_Request
ON SCHEDULE EVERY 1 day
STARTS CURRENT_TIMESTAMP
DO 
BEGIN
DELETE FROM Request
WHERE Last_modified < DATE_SUB(curdate(), INTERVAL 365 DAY);
END$$
DELIMITER ;



