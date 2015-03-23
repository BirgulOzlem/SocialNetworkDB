
CREATE TABLE MEMBER
(
	Member_id INT IDENTITY(1,1),
	Password VARCHAR(45) NOT NULL,
	First_Name VARCHAR(45) NOT NULL,
	Middle_Name VARCHAR(45),
	Last_Name VARCHAR(45) NOT NULL,
	Nick_name VARCHAR(45),
	E_mail VARCHAR(100) NOT NULL,
	Date_of_joined DATETIME NOT NULL DEFAULT(GETDATE()),
	Active BIT NOT NULL DEFAULT 1,
	Online BIT NOT NULL DEFAULT 1,
	
	CONSTRAINT MEMBER_PK PRIMARY KEY(Member_id),
	CONSTRAINT MEMBER_UK1 UNIQUE(E_mail),
	CONSTRAINT MEMBER_CK CHECK(len(Password) > 6)
);


CREATE TABLE ORGANIZATION
(
	Org_id INT IDENTITY(1,1),
	Org_name VARCHAR(45) NOT NULL,
	Date_start DATE,
	Description VARCHAR(255), 

	CONSTRAINT ORG_PK PRIMARY KEY(Org_id),
	CONSTRAINT ORG_UK UNIQUE(Org_name)
);


CREATE TABLE GROUPS
(
	Group_id INT IDENTITY(1,1),
	Creator_member_id INT NOT NULL,
	Group_name VARCHAR(45) NOT NULL,
	Description VARCHAR(255), 
	Date_start DATETIME NOT NULL DEFAULT(GETDATE()),
	Date_end DATETIME,
	
	CONSTRAINT GRP_PK PRIMARY KEY(Group_id),
	CONSTRAINT GRP_FK FOREIGN KEY(Creator_member_id) REFERENCES MEMBER(Member_id) ON DELETE CASCADE ON UPDATE CASCADE
);



CREATE TABLE PROFILE
(
	Profile_id INT IDENTITY(1,1),
	Member_id INT NOT NULL,
	Picture VARCHAR(255) NOT NULL DEFAULT 'http://graph.photo.default.facebook.com',
	Privacy_type VARCHAR(45) NOT NULL DEFAULT 'Public',
	Relationship VARCHAR(45),
	Date_of_Birth DATE NOT NULL,
	Sex VARCHAR(10) NOT NULL,
	Looking_for VARCHAR(10),
	Everything_else VARCHAR(255),
	
	CONSTRAINT PROFILE_PK PRIMARY KEY(Profile_id),
	CONSTRAINT PROFILE_FK FOREIGN KEY (Member_id) REFERENCES MEMBER(Member_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT PROFILE_UK UNIQUE(Member_id),
	CONSTRAINT PROFILE_CK CHECK (Sex='Woman' or Sex='Man'),
	CONSTRAINT PROFILE_CK1 CHECK (Looking_for='Woman' or Looking_for='Man'),
	CONSTRAINT PROFILE_CK2 CHECK (Privacy_type='Public' or Privacy_type='Friends' or Privacy_type='Just me')
);

	
CREATE TABLE HOBIE
(
	Hobie_id INT IDENTITY(1,1),
	Hobie_name VARCHAR(45) NOT NULL,
	
	CONSTRAINT HOBIE_PK PRIMARY KEY(Hobie_id),
	CONSTRAINT HOBIE_UK UNIQUE(Hobie_name)
);


CREATE TABLE FAVOURITE_HOBIE 
(
	Profile_id INT NOT NULL,
	Hobie_id INT NOT NULL,

	CONSTRAINT FVRHB_PK PRIMARY KEY(Profile_id,Hobie_id),
	CONSTRAINT FVRHB_FK FOREIGN KEY (Profile_id) REFERENCES PROFILE(Profile_id) ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT FVRHB_FK1 FOREIGN KEY (Hobie_id) REFERENCES HOBIE(Hobie_id) ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE MOVIE
(
	Movie_id INT IDENTITY(1,1),
	Movie_name VARCHAR(45) NOT NULL,
	Director VARCHAR(45),
	
	CONSTRAINT MOVIE_PK PRIMARY KEY(Movie_id),
	CONSTRAINT MOVIE_UK UNIQUE(Movie_name)
);


CREATE TABLE FAVOURITE_MOVIE
(
	Movie_id INT NOT NULL,
	Profile_id INT NOT NULL,

	CONSTRAINT FVRMV_PK PRIMARY KEY(Profile_id,Movie_id),
	CONSTRAINT FVRMV_FK FOREIGN KEY (Profile_id) REFERENCES PROFILE(Profile_id) ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT FVRMV_FK1 FOREIGN KEY (Movie_id) REFERENCES MOVIE(Movie_id) ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE BOOK
(
	Book_id INT IDENTITY(1,1),
	Book_name VARCHAR(45) NOT NULL,
	Author_name VARCHAR(45) NOT NULL,
	
	CONSTRAINT BOOK_PK PRIMARY KEY(Book_id),
	CONSTRAINT BOOK_UK UNIQUE(Book_name,Author_name)
);


CREATE TABLE FAVOURITE_BOOK
(
	Book_id INT NOT NULL,
	Profile_id INT NOT NULL,
	
	CONSTRAINT FVRBO_PK PRIMARY KEY(Profile_id,Book_id),
	CONSTRAINT FVRBO_FK FOREIGN KEY (Profile_id) REFERENCES PROFILE(Profile_id) ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT FVRBO_FK1 FOREIGN KEY (Book_id) REFERENCES BOOK(Book_id) ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE ARTIST
(
	Artist_id INT IDENTITY(1,1),
	Artist_name VARCHAR(45) NOT NULL,
	
	CONSTRAINT ARTIST_PK PRIMARY KEY(Artist_id),
	CONSTRAINT ARTIST_UK UNIQUE(Artist_name)
);


CREATE TABLE FAVOURITE_ARTIST
(
	Artist_id INT NOT NULL,
	Profile_id INT NOT NULL,
	
	CONSTRAINT FVRAR_PK PRIMARY KEY(Profile_id,Artist_id),
	CONSTRAINT FVRAR_FK FOREIGN KEY (Profile_id) REFERENCES PROFILE(Profile_id) ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT FVRAR_FK1 FOREIGN KEY (Artist_id) REFERENCES ARTIST(Artist_id) ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE ANIMAL
(
	Animal_id INT IDENTITY(1,1),
	Animal_name VARCHAR(45) NOT NULL,
	
	CONSTRAINT ANIMAL_PK PRIMARY KEY(Animal_id),
	CONSTRAINT ANIMAL_UK UNIQUE(Animal_name)
);


CREATE TABLE FAVOURITE_ANIMAL
(
	Animal_id INT NOT NULL,
	Profile_id INT NOT NULL,
	
	CONSTRAINT FVRAN_PK PRIMARY KEY(Profile_id,Animal_id),
	CONSTRAINT FVRAN_FK FOREIGN KEY (Profile_id) REFERENCES PROFILE(Profile_id) ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT FVRAN_FK1 FOREIGN KEY (Animal_id) REFERENCES ANIMAL(Animal_id) ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE FRIEND
(
	Friend_relation_id INT IDENTITY(1,1),
	Member_id INT NOT NULL,
	Friend_Member_id INT NOT NULL,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	Privacy_type VARCHAR(45) NOT NULL DEFAULT 'Public',
	
	CONSTRAINT FRIEND_PK PRIMARY KEY(Friend_relation_id),
	CONSTRAINT FRIEND_UK UNIQUE(Member_id,Friend_Member_id),
	CONSTRAINT FRIEND_FK FOREIGN KEY (Member_id) REFERENCES MEMBER(Member_id),
	CONSTRAINT FRIEND_FK1 FOREIGN KEY (Friend_Member_id) REFERENCES MEMBER(Member_id),
	CONSTRAINT FRIEND_CK CHECK (Privacy_type='Public' or Privacy_type='Friends' or Privacy_type='Just me')
);


CREATE TABLE FRIEND_CATEGORY
(
	Friend_category_id INT IDENTITY(1,1),
	Friend_relation_id INT NOT NULL,
	Category_name VARCHAR(45) NOT NULL,
	
	CONSTRAINT FRIEND_CATEGORY_PK PRIMARY KEY(Friend_category_id),
	CONSTRAINT FRIEND_CATEGORY_CK CHECK (Category_name='University' or  Category_name= 'High school' or Category_name='Current city'or 
	Category_name='Home town'or Category_name='Job'),
	CONSTRAINT FRIEND_CATEGORY_FK FOREIGN KEY (Friend_relation_id) REFERENCES FRIEND(Friend_relation_id) 
									ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE MESSAGE
(
	Message_id INT IDENTITY(1,1),
	Message VARCHAR(255) NOT NULL,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	Is_read BIT NOT NULL DEFAULT 0,
	Is_spam BIT NOT NULL DEFAULT 0,
	Member_id INT NOT NULL,
	To_id INT NOT NULL,
	Is_reply BIT NOT NULL DEFAULT 0,
	
	CONSTRAINT MESSAGE_PK PRIMARY KEY(Message_id),
	CONSTRAINT MESSAGE_FK FOREIGN KEY(Member_id) REFERENCES MEMBER(Member_id) ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT MESSAGE_FK1 FOREIGN KEY (To_id) REFERENCES MEMBER(Member_id)
);


CREATE TABLE NOTIFICATION
(
	Notification_id INT IDENTITY(1,1),
	Member_id INT NOT NULL,
	Msg VARCHAR(255) NOT NULL,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	
	CONSTRAINT NOTIFICATION_PK PRIMARY KEY(Notification_id),
	CONSTRAINT NOTIFICATION_FK FOREIGN KEY(Member_id) REFERENCES MEMBER(Member_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ADDRESS
(
	Address_id INT IDENTITY(1,1),
	Profile_id INT NOT NULL,
	Move_date DATETIME,
	City VARCHAR(45) NOT NULL,
	Country VARCHAR(45) NOT NULL,
	Post_code VARCHAR(45) NOT NULL,
	Line1 VARCHAR(45),
	Line2 VARCHAR(45),
	Line3 VARCHAR(45),
	Privacy_type VARCHAR(45) NOT NULL DEFAULT 'Public',
	
	CONSTRAINT ADDRESS_PK PRIMARY KEY(Address_id),
	CONSTRAINT ADDRESS_FK1 FOREIGN KEY (Profile_id) REFERENCES PROFILE(Profile_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT ADDRESS_CK CHECK (Privacy_type='Public' or Privacy_type='Friends' or Privacy_type='Just me')
);

CREATE TABLE OBJECT_BEING_FOLLOWED
(
	Member_id INT NOT NULL,
	Object_id INT NOT NULL,
	Object_type INT NOT NULL,/*1-member 2-organization 3-group*/
	Date_start DATETIME NOT NULL DEFAULT(GETDATE()),
	Date_end DATETIME,
	
	CONSTRAINT OBJF_PK PRIMARY KEY(Member_id,Object_id,Object_type),
	CONSTRAINT OBJF_FK FOREIGN KEY (Member_id) REFERENCES MEMBER(Member_id) 
									ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE CVS
(
	Cv_id INT IDENTITY(1,1),
	Member_id INT NOT NULL,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	
	CONSTRAINT CV_PK PRIMARY KEY(Cv_id),
	CONSTRAINT CV_FK FOREIGN KEY (Member_id) REFERENCES MEMBER(Member_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE LANGUAGE
(
	Language_id INT IDENTITY(1,1),
	Language_name VARCHAR(45) NOT NULL,
	
	CONSTRAINT LANGUAGE_PK PRIMARY KEY(Language_id),
	CONSTRAINT LANGUAGE_UK UNIQUE(Language_name)
);


CREATE TABLE SPEAKS
(
	Profile_id INT NOT NULL,
	Language_id INT NOT NULL,
	Learned_at VARCHAR(45),
	Level VARCHAR(45) NOT NULL,
	CONSTRAINT SPEAKS_PK PRIMARY KEY(Profile_id,Language_id),
	CONSTRAINT SPEAKS_CK CHECK (Level='Upper' or  Level= 'Intermediate' or Level='Beginner'),
	CONSTRAINT SPEAKS_FK FOREIGN KEY (Profile_id) REFERENCES PROFILE(Profile_id) 
									ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT SPEAKS_FK1 FOREIGN KEY (Language_id) REFERENCES LANGUAGE(Language_id) 
									ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE EDUCATION
(
	Education_id INT IDENTITY(1,1),
	Profile_id INT NOT NULL,
	Category VARCHAR(45) NOT NULL,
	School_name CHAR(45) NOT NULL,
	Department CHAR(45),
	Date_start DATETIME NOT NULL,
	Date_end DATETIME,
	Degree FLOAT,
	
	CONSTRAINT GRADUATED_PK PRIMARY KEY(Education_id),
	CONSTRAINT GRADUATED_FK FOREIGN KEY (Profile_id) REFERENCES PROFILE(Profile_id) 
									ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT GRADUATED_UK UNIQUE(Profile_id,Category,School_name,Department),
	CONSTRAINT GRADUATED_CK CHECK (Category='Master' or  Category='Bachelor' or Category='High school' or Category='Primary school')
);


CREATE TABLE EXPERIENCE
(
	Experience_id INT IDENTITY(1,1),
	Cv_id INT NOT NULL,
	Org_name VARCHAR(45) NOT NULL,
	Date_start DATETIME NOT NULL,
	Date_end DATETIME,
	Position VARCHAR(45) NOT NULL,
	
	CONSTRAINT EXPERIENCE_PK PRIMARY KEY(Experience_id),
	CONSTRAINT EXPERIENCE_FK FOREIGN KEY (Cv_id) REFERENCES CVS(Cv_id) 
									ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE SKILLS
(
	Skill_id INT IDENTITY(1,1),
	Skill_name VARCHAR(45) NOT NULL,
	CONSTRAINT SKILLS_PK PRIMARY KEY(Skill_id),
	CONSTRAINT SKILLS_UK UNIQUE(Skill_name)
);


CREATE TABLE HAVE_SKILLS
(
	Cv_id INT NOT NULL,
	Skill_id INT NOT NULL,
	CONSTRAINT HAVE_SKILLS_PK PRIMARY KEY(Cv_id,Skill_id),
	CONSTRAINT HAVE_SKILLS_FK FOREIGN KEY (Cv_id) REFERENCES CVS(Cv_id) 
									ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT HAVE_SKILLS_FK1 FOREIGN KEY (Skill_id) REFERENCES SKILLS(Skill_id) 
									ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE CERTFICATIONS
(
	Certication_id INT IDENTITY(1,1),
	Cv_id INT NOT NULL,
	Certification_name VARCHAR(45) NOT NULL,
	Explanation VARCHAR(255),
	CONSTRAINT CERTFICATIONS_PK PRIMARY KEY(Certication_id),
	CONSTRAINT CERTFICATIONS_FK FOREIGN KEY (Cv_id) REFERENCES CVS(Cv_id) 
									ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE STATUS
(
	Status_id INT IDENTITY(1,1),
	Member_id INT NOT NULL,
	Like_number INT NOT NULL DEFAULT 0,
	Dislike_number INT NOT NULL DEFAULT 0,
	Message VARCHAR(255) NOT NULL,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	Privacy_type VARCHAR(45) NOT NULL DEFAULT 'Public',
	
	CONSTRAINT STATUS_PK PRIMARY KEY(Status_id),
	CONSTRAINT STATUS_FK FOREIGN KEY (Member_id) REFERENCES MEMBER(Member_id) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT STATUS_CK CHECK (Privacy_type='Public' or Privacy_type='Friends' or Privacy_type='Just me')
);


CREATE TABLE BLOG
(
	Blog_id INT IDENTITY(1,1),
	Member_id INT NOT NULL,
	Like_number INT NOT NULL DEFAULT 0,
	Dislike_number INT NOT NULL DEFAULT 0,
	Message VARCHAR(255) NOT NULL,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	
	CONSTRAINT BLOG_PK PRIMARY KEY(Blog_id),
	CONSTRAINT BLOG_FK FOREIGN KEY (Member_id) REFERENCES MEMBER(Member_id) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE LIKE_DISLIKE
(
	Like_dislike_id INT IDENTITY(1,1),
	Flag BIT NOT NULL,/*0-dislike 1-like*/
	Object_id INT NOT NULL,
	Object_type BIT NOT NULL,/*0-status 1-blog*/
	Friend_relation_id INT NOT NULL,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),

	CONSTRAINT LIKE_DISLIKE_PK PRIMARY KEY(Like_dislike_id),
	CONSTRAINT LIKE_DISLIKE_UK UNIQUE(Friend_relation_id,Object_id),
	CONSTRAINT LIKE_DISLIKE_FK FOREIGN KEY (Friend_relation_id) REFERENCES FRIEND(Friend_relation_id)
								ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE COMMENT
(
	Comment_id INT IDENTITY(1,1),
	Message VARCHAR(255) NOT NULL,
	Object_id INT NOT NULL,
	Object_type BIT NOT NULL,/*0-status 1-blog*/
	Friend_relation_id INT NOT NULL,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	
	CONSTRAINT COMMENT_PK PRIMARY KEY(Comment_id),
	CONSTRAINT COMMENT_FK FOREIGN KEY (Friend_relation_id) REFERENCES FRIEND(Friend_relation_id)
								ON DELETE CASCADE  ON UPDATE CASCADE
);


CREATE TABLE FEED_CATEGORY
(
	Feed_category_id INT IDENTITY(1,1),
	Name VARCHAR(45) NOT NULL,
	
	CONSTRAINT FEED_CATEGORY_PK PRIMARY KEY(Feed_category_id)
);


CREATE TABLE FEED_SUB_CATEGORY
(
	Feed_sub_category_id INT IDENTITY(1,1),
	Feed_category_id INT NOT NULL,
	Name VARCHAR(45) NOT NULL,
	
	CONSTRAINT FEED_SUB_CATEGORY_PK PRIMARY KEY(Feed_sub_category_id),
	CONSTRAINT FEED_SUB_CATEGORY_FK FOREIGN KEY (Feed_category_id) REFERENCES FEED_CATEGORY(Feed_category_id) 
					ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE FEED
(
	Feed_id INT IDENTITY(1,1),
	Feed_sub_category_id INT NOT NULL,
	Feed_category_id INT NOT NULL,
	Feed_url VARCHAR(255) NOT NULL,
	Rating INT NOT NULL DEFAULT 0,
	Privacy_type VARCHAR(45) NOT NULL DEFAULT 'Public',
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	
	CONSTRAINT FEED_PK PRIMARY KEY(Feed_id),
	CONSTRAINT FEED_UK UNIQUE(Feed_url),
	CONSTRAINT FEED_FK FOREIGN KEY (Feed_category_id) REFERENCES FEED_CATEGORY(Feed_category_id), 
	CONSTRAINT FEED_FK1 FOREIGN KEY (Feed_sub_category_id) REFERENCES FEED_SUB_CATEGORY(Feed_sub_category_id),
	CONSTRAINT FEED_CK CHECK (Privacy_type='Public' or Privacy_type='Friends' or Privacy_type='Just me')
);


CREATE TABLE FEED_INFO
(
	Feed_info_id INT IDENTITY(1,1),
	Feed_id INT NOT NULL,
	Member_id INT NOT NULL,
	Favourite BIT NOT NULL DEFAULT 0,
	Privacy_type VARCHAR(45) NOT NULL DEFAULT 'Public',
	Clicks INT NOT NULL DEFAULT 0,
	
	CONSTRAINT FEED_INFO_PK PRIMARY KEY(Feed_info_id),
	CONSTRAINT FEED_INFO_FK FOREIGN KEY(Member_id) REFERENCES MEMBER(Member_id) ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT FEED_INFO_FK1 FOREIGN KEY(Feed_id) REFERENCES FEED(Feed_id), /*ON DELETE CASCADE  ON UPDATE CASCADE,*/
	CONSTRAINT FEED_INFO_CK CHECK (Privacy_type='Public' or Privacy_type='Friends' or Privacy_type='Just me')
);


CREATE TABLE BOOKMARK_CATEGORY
(
	Bookmark_cat_id INT IDENTITY(1,1),
	Name VARCHAR(45) NOT NULL,
	
	CONSTRAINT BOOKMARK_CATEGORY_PK PRIMARY KEY(Bookmark_cat_id)
);


CREATE TABLE BOOKMARK_SUB_CATEGORY
(
	Bookmark_subcat_id INT IDENTITY(1,1),
	Bookmark_cat_id INT NOT NULL,
	Name VARCHAR(45) NOT NULL,

	CONSTRAINT BOOKMARK_SUB_CATEGORY_PK PRIMARY KEY(Bookmark_subcat_id),
	CONSTRAINT BOOKMARK_SUB_CATEGORY_FK FOREIGN KEY(Bookmark_cat_id) REFERENCES BOOKMARK_CATEGORY(Bookmark_cat_id) 
						ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE BOOKMARK
(
	Bookmark_id INT IDENTITY(1,1),
	Bookmark_subcat_id INT NOT NULL,
	Bookmark_cat_id INT NOT NULL,
	Bookmark_url VARCHAR(255) NOT NULL,
	Rating INT NOT NULL DEFAULT 0,
	Created_at DATETIME NOT NULL DEFAULT(GETDATE()),
	Privacy_type VARCHAR(45) NOT NULL DEFAULT 'Public',
	
	CONSTRAINT BOOKMARK_PK PRIMARY KEY(Bookmark_id),
	CONSTRAINT BOOKMARK_UK UNIQUE(Bookmark_url),
	CONSTRAINT BOOKMARK_FK FOREIGN KEY(Bookmark_cat_id) REFERENCES BOOKMARK_CATEGORY(Bookmark_cat_id),
	CONSTRAINT BOOKMARK_FK1 FOREIGN KEY(Bookmark_subcat_id) REFERENCES BOOKMARK_SUB_CATEGORY(Bookmark_subcat_id),
	CONSTRAINT BOOKMARK_CK CHECK (Privacy_type='Public' or Privacy_type='Friends' or Privacy_type='Just me')
);


CREATE TABLE BOOKMARK_INFO
(
	Bookmark_info_id INT IDENTITY(1,1),
	Bookmark_id INT NOT NULL,
	Member_id INT NOT NULL,
	Favourite BIT NOT NULL DEFAULT 0,
	Privacy_type VARCHAR(45) NOT NULL DEFAULT 'Public',
	Clicks INT NOT NULL DEFAULT 0,

	CONSTRAINT BOOKMARK_INFO_PK PRIMARY KEY(Bookmark_info_id),
	CONSTRAINT BOOKMARK_INFO_FK FOREIGN KEY(Member_id) REFERENCES MEMBER(Member_id)
						ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT BOOKMARK_INFO_FK1 FOREIGN KEY(Bookmark_id) REFERENCES BOOKMARK(Bookmark_id)
						ON DELETE CASCADE  ON UPDATE CASCADE,
	CONSTRAINT BOOKMARK_INFO_CK CHECK (Privacy_type='Public' or Privacy_type='Friends' or Privacy_type='Just me')
);



/* -----------------------------------------------------------------------------------------------------------------------------------*/

/*ilk 4 trigger ayni*/
go
CREATE TRIGGER BLOG_DISLIKES_NUMBER
ON dbo.LIKE_DISLIKE
AFTER INSERT 
AS BEGIN

     UPDATE dbo.BLOG SET dbo.BLOG.Like_number = dbo.BLOG.Like_number + 1 
     FROM dbo.BLOG,inserted,dbo.FRIEND 
           WHERE inserted.Friend_relation_id=dbo.FRIEND.Friend_relation_id 
				 and dbo.FRIEND.Member_id = BLOG.Member_id 
				 and inserted.Object_type =1
				 and inserted.Flag = 1
				
END
go
CREATE TRIGGER BLOG_DISLIKES_NUMBER2 
ON dbo.LIKE_DISLIKE
AFTER INSERT 
AS BEGIN

     UPDATE dbo.BLOG SET dbo.BLOG.Dislike_number = dbo.BLOG.Dislike_number + 1 
     FROM dbo.BLOG,inserted,dbo.FRIEND 
           WHERE inserted.Friend_relation_id=dbo.FRIEND.Friend_relation_id 
				 and dbo.FRIEND.Member_id = BLOG.Member_id 
				 and inserted.Object_type =1
				 and inserted.Flag = 0
				
END
go
CREATE TRIGGER STATUS_DISLIKES_NUMBER 
ON dbo.LIKE_DISLIKE
AFTER INSERT 
AS BEGIN

     UPDATE dbo.STATUS SET dbo.STATUS.Like_number = dbo.STATUS.Like_number + 1 
     FROM dbo.STATUS,inserted,dbo.FRIEND 
           WHERE inserted.Friend_relation_id=dbo.FRIEND.Friend_relation_id 
				 and dbo.FRIEND.Member_id = STATUS.Member_id 
				 and inserted.Object_type =1
				 and inserted.Flag = 1
				
END
go
CREATE TRIGGER STATUS_DISLIKES_NUMBER2 
ON dbo.LIKE_DISLIKE
AFTER INSERT 
AS BEGIN

     UPDATE dbo.STATUS SET dbo.STATUS.Dislike_number = dbo.STATUS.Dislike_number + 1 
     FROM dbo.STATUS,inserted,dbo.FRIEND 
           WHERE inserted.Friend_relation_id=dbo.FRIEND.Friend_relation_id 
				 and dbo.FRIEND.Member_id = STATUS.Member_id 
				 and inserted.Object_type =1
				 and inserted.Flag = 0
				
END

go 
 CREATE TRIGGER COMMENT_NOTIFICATION 
 ON COMMENT 
 AFTER INSERT
 AS BEGIN
 DECLARE @userID int
 DECLARE @friendName VARCHAR(45)
 DECLARE @msg VARCHAR(65)
 set @userID = (select MEMBER.Member_id from MEMBER,FRIEND,inserted where MEMBER.Member_id=FRIEND.Member_id and
  inserted.Friend_relation_id=FRIEND.Friend_relation_id);
  set @friendName = (select MEMBER.First_Name from MEMBER,FRIEND,inserted where MEMBER.Member_id=FRIEND.Member_id and
  inserted.Friend_relation_id=FRIEND.Friend_relation_id);
  set @msg = @friendName+' has commented on your status'
  insert into NOTIFICATION(Member_id,Msg) values(@userID,@msg);
  
  end
  
  GO 
  CREATE TRIGGER DELETE_FRIEND
  ON MEMBER
  INSTEAD OF DELETE
  AS BEGIN
  DELETE FROM FRIEND WHERE FRIEND.Member_id IN(SELECT Member_id FROM deleted) OR FRIEND.Friend_Member_id IN(SELECT Member_id FROM deleted);
  DELETE FROM MEMBER WHERE MEMBER.Member_id IN(SELECT Member_id FROM DELETED);
  END
  
  GO 
  CREATE TRIGGER DELETE_ORGANIZATION
  ON ORGANIZATION
  INSTEAD OF DELETE 
  AS BEGIN
  DELETE FROM OBJECT_BEING_FOLLOWED WHERE OBJECT_BEING_FOLLOWED.Object_id IN(SELECT Object_id FROM OBJECT_BEING_FOLLOWED,DELETED
		WHERE OBJECT_BEING_FOLLOWED.Object_type=2 AND OBJECT_BEING_FOLLOWED.Object_id=DELETED.Org_id)
  DELETE FROM ORGANIZATION WHERE ORGANIZATION.Org_id IN(SELECT Org_id FROM DELETED);
  END
 
 


 /*---------------------------------------------------------------------------------------------------------------------------------------------*/





 delete from MEMBER where First_Name='Tayfun';
delete from SKILLS where Skill_name='Java';
delete from ORGANIZATION where Org_name='Microsoft'

update MEMBER set E_mail='default@yahoo.com' where Member_id=1
update SKILLS set Skill_name='Python' where Skill_name='Java'
update ORGANIZATION set Org_name='Apple' where Org_name='Microsoft'

INSERT INTO MEMBER(Password,First_Name,Last_Name,E_mail) VALUES('1234567','Tayfun','Ozturk','default@gmail.com');
INSERT INTO MEMBER(Password,First_Name,Last_Name,E_mail) VALUES('1234567','Fadime','Savas','default1@gmail.com');
INSERT INTO MEMBER(Password,First_Name,Last_Name,E_mail) VALUES('1234567','Recai','Huseyin','default2@gmail.com');
INSERT INTO MEMBER(Password,First_Name,Last_Name,E_mail) VALUES('1234567','Birgul','Ozlem','default3@gmail.com');
INSERT INTO MEMBER(Password,First_Name,Last_Name,E_mail) VALUES('1234567','','','defaujlt3@gmail.com');
select * from MEMBER;

INSERT INTO ORGANIZATION(Org_name) VALUES('Microsoft');
INSERT INTO ORGANIZATION(Org_name) VALUES('Apid');
select * from ORGANIZATION;

INSERT INTO FRIEND(Member_id,Friend_Member_id) VALUES(1,2);
INSERT INTO FRIEND(Member_id,Friend_Member_id) VALUES(1,3);
INSERT INTO FRIEND(Member_id,Friend_Member_id) VALUES(1,4);
INSERT INTO FRIEND(Member_id,Friend_Member_id) VALUES(2,3);
select * from FRIEND;

INSERT INTO FRIEND_CATEGORY(Friend_relation_id,Category_name) VALUES(1,'University');
INSERT INTO FRIEND_CATEGORY(Friend_relation_id,Category_name) VALUES(2,'High school');
INSERT INTO FRIEND_CATEGORY(Friend_relation_id,Category_name) VALUES(3,'Job');
select * from FRIEND_CATEGORY;

INSERT INTO GROUPS(Group_name,Creator_member_id) VALUES('Spor Haber',1);
INSERT INTO GROUPS(Group_name,Creator_member_id) VALUES('Bilmuh',2);
select * from GROUPS;

INSERT INTO PROFILE(Member_id,Date_of_Birth,Sex) VALUES(1,'1990-09-01','Man');
INSERT INTO PROFILE(Member_id,Date_of_Birth,Sex) VALUES(2,'1990-09-01','Woman');
INSERT INTO PROFILE(Member_id,Date_of_Birth,Sex) VALUES(3,'1990-09-01','Man');
INSERT INTO PROFILE(Member_id,Date_of_Birth,Sex) VALUES(4,'1990-09-01','Woman');
select * from PROFILE;

INSERT INTO HOBIE(Hobie_name) VALUES('Avcilik');
INSERT INTO HOBIE(Hobie_name) VALUES('Ata binmek');
INSERT INTO HOBIE(Hobie_name) VALUES('Ders calismak');
select * from HOBIE;

INSERT INTO FAVOURITE_HOBIE(Profile_id,Hobie_id) VALUES(1,1);
INSERT INTO FAVOURITE_HOBIE(Profile_id,Hobie_id) VALUES(1,2);
INSERT INTO FAVOURITE_HOBIE(Profile_id,Hobie_id) VALUES(1,3);
select * from FAVOURITE_HOBIE;

INSERT INTO MOVIE(Movie_name) VALUES('Avatar');
INSERT INTO MOVIE(Movie_name) VALUES('Hobit');
select * from MOVIE;


INSERT INTO FAVOURITE_MOVIE(Profile_id,Movie_id) VALUES(1,1);
INSERT INTO FAVOURITE_MOVIE(Profile_id,Movie_id) VALUES(2,1);
INSERT INTO FAVOURITE_MOVIE(Profile_id,Movie_id) VALUES(3,1);
INSERT INTO FAVOURITE_MOVIE(Profile_id,Movie_id) VALUES(4,2);
select * from FAVOURITE_MOVIE;

INSERT INTO BOOK(Book_name,Author_name) VALUES('Yabanci','Slbert Camus');
INSERT INTO BOOK(Book_name,Author_name) VALUES('Gunluk yasamin psikopatolojisi','Sigmund Freud');
select * from BOOK;


INSERT INTO FAVOURITE_BOOK(Profile_id,Book_id) VALUES(1,1);
INSERT INTO FAVOURITE_BOOK(Profile_id,Book_id) VALUES(1,2);
select * from FAVOURITE_BOOK;

INSERT INTO ARTIST(Artist_name) VALUES('Cem Yilmaz');
INSERT INTO ARTIST(Artist_name) VALUES('Ahmet Kural');
select * from ARTIST;

INSERT INTO FAVOURITE_ARTIST(Profile_id,Artist_id) VALUES(1,1);
INSERT INTO FAVOURITE_ARTIST(Profile_id,Artist_id) VALUES(1,2);
select * from FAVOURITE_ARTIST;

INSERT INTO ANIMAL(Animal_name) VALUES('Aslan');
INSERT INTO ANIMAL(Animal_name) VALUES('Kedi');
select * from ANIMAL;

INSERT INTO FAVOURITE_ANIMAL(Profile_id,Animal_id) VALUES(1,1);
INSERT INTO FAVOURITE_ANIMAL(Profile_id,Animal_id) VALUES(1,2);
select * from FAVOURITE_ANIMAL;

INSERT INTO CVS(Member_id) VALUES(1);
INSERT INTO CVS(Member_id) VALUES(2);
select * from CVS;

INSERT INTO CERTFICATIONS(Cv_id,Certification_name) VALUES(1,'bla bla');
INSERT INTO CERTFICATIONS(Cv_id,Certification_name) VALUES(2,'bla bla');
select * from CERTFICATIONS;

INSERT INTO STATUS(Member_id,Message) VALUES(1,'bla bla');
INSERT INTO STATUS(Member_id,Message) VALUES(1,'bla bla');
INSERT INTO STATUS(Member_id,Message) VALUES(2,'bla bla');
select * from STATUS;

INSERT INTO BLOG(Member_id,Message) VALUES(1,'bla bla');
INSERT INTO BLOG(Member_id,Message) VALUES(2,'bla bla');
select * from BLOG;

INSERT INTO LIKE_DISLIKE(Flag,Object_id,Object_type,Friend_relation_id) VALUES(1,1,1,1);/*blog like*/
INSERT INTO LIKE_DISLIKE(Flag,Object_id,Object_type,Friend_relation_id) VALUES(0,1,1,2);/*blog dislike*/
INSERT INTO LIKE_DISLIKE(Flag,Object_id,Object_type,Friend_relation_id) VALUES(1,1,0,3);/*status like*/
INSERT INTO LIKE_DISLIKE(Flag,Object_id,Object_type,Friend_relation_id) VALUES(0,1,0,4);/*status dislike*/
select * from LIKE_DISLIKE;

INSERT INTO COMMENT(Message,Object_id,Object_type,Friend_relation_id) VALUES('bla bla',1,1,1);
INSERT INTO COMMENT(Message,Object_id,Object_type,Friend_relation_id) VALUES('bla bla',1,1,1);
select * from COMMENT;
select * from NOTIFICATION;

INSERT INTO FEED_CATEGORY(Name) VALUES('bla bla');
INSERT INTO FEED_CATEGORY(Name) VALUES('bla bla');
select * from FEED_CATEGORY;

INSERT INTO FEED_SUB_CATEGORY(Feed_category_id,Name) VALUES(1,'bla bla');
INSERT INTO FEED_SUB_CATEGORY(Feed_category_id,Name) VALUES(1,'bla bla');
select * from FEED_SUB_CATEGORY;

INSERT INTO FEED(Feed_sub_category_id,Feed_category_id,Feed_url) VALUES(1,1,'fb.com/23423');
INSERT INTO FEED(Feed_sub_category_id,Feed_category_id,Feed_url) VALUES(1,2,'fb.com/2342');
select * from FEED;

INSERT INTO FEED_INFO(Feed_id,Member_id) VALUES(1,1);
INSERT INTO FEED_INFO(Feed_id,Member_id) VALUES(2,2);
select * from FEED_INFO;

INSERT INTO BOOKMARK_CATEGORY(Name) VALUES('Groups');
INSERT INTO BOOKMARK_CATEGORY(Name) VALUES('Organization');
select * from BOOKMARK_CATEGORY;

INSERT INTO BOOKMARK_SUB_CATEGORY(Bookmark_cat_id,Name) VALUES(1,'Spor groups');
INSERT INTO BOOKMARK_SUB_CATEGORY(Bookmark_cat_id,Name) VALUES(1,'Food groups');
select * from BOOKMARK_SUB_CATEGORY;

INSERT INTO BOOKMARK(Bookmark_subcat_id,Bookmark_cat_id,Bookmark_url) VALUES(1,1,'fb.com/3423');
INSERT INTO BOOKMARK(Bookmark_subcat_id,Bookmark_cat_id,Bookmark_url) VALUES(1,2,'fb.com/242');
select * from BOOKMARK;

INSERT INTO BOOKMARK_INFO(Bookmark_id,Member_id) VALUES(1,1);
INSERT INTO BOOKMARK_INFO(Bookmark_id,Member_id) VALUES(1,2);
select * from BOOKMARK_INFO;

INSERT INTO MESSAGE(Message,Member_id,To_id) VALUES('bla bla',1,2);
INSERT INTO MESSAGE(Message,Member_id,To_id) VALUES('bla bla',1,3);
select * from MESSAGE;

INSERT INTO ADDRESS(Profile_id,City,Country,Post_code) VALUES(1,'Ankara','Turkiye','235');
INSERT INTO ADDRESS(Profile_id,City,Country,Post_code) VALUES(2,'Izmir','Turkiye','3423');
select * from ADDRESS;

INSERT INTO OBJECT_BEING_FOLLOWED(Member_id,Object_id,Object_type) VALUES(1,1,1);
INSERT INTO OBJECT_BEING_FOLLOWED(Member_id,Object_id,Object_type) VALUES(2,1,1);
INSERT INTO OBJECT_BEING_FOLLOWED(Member_id,Object_id,Object_type) VALUES(2,1,2);
select * from OBJECT_BEING_FOLLOWED;

INSERT INTO LANGUAGE(Language_name) VALUES('Turkish');
INSERT INTO LANGUAGE(Language_name) VALUES('English');
select * from LANGUAGE;

INSERT INTO SPEAKS(Profile_id,Language_id,Level) VALUES(1,1,'Upper');
INSERT INTO SPEAKS(Profile_id,Language_id,Level) VALUES(2,1,'Upper');
select * from SPEAKS;

INSERT INTO EDUCATION(Profile_id,Category,School_name,Date_start) VALUES(1,'Master','Ege','2013-01-04');
INSERT INTO EDUCATION(Profile_id,Category,School_name,Date_start) VALUES(2,'Bachelor','Ege','2013-01-04');
select * from EDUCATION;

INSERT INTO EXPERIENCE(Cv_id,Org_name,Date_start,Position) VALUES(1,'Apid','2013-01-04','Stajyer');
INSERT INTO EXPERIENCE(Cv_id,Org_name,Date_start,Position) VALUES(2,'Galaksiya','2013-01-04','Stajyer');
select * from EXPERIENCE;

INSERT INTO SKILLS(Skill_name) VALUES('Java');
INSERT INTO SKILLS(Skill_name) VALUES('Python');
select * from SKILLS;

INSERT INTO HAVE_SKILLS(Cv_id,Skill_id) VALUES(1,1);
INSERT INTO HAVE_SKILLS(Cv_id,Skill_id) VALUES(2,1);
select * from HAVE_SKILLS;


/*sorgular*/
SELECT Group_name
FROM GROUPS
WHERE Group_name LIKE 'B%';

SELECT Relationship
FROM PROFILE
WHERE Looking_for='Man';

SELECT First_name,Last_name
FROM MEMBER
WHERE E_mail LIKE '%@gmail.com';

SELECT First_name,Last_name
FROM MEMBER,PROFILE
WHERE MEMBER.Member_id=PROFILE.Member_id AND Sex='Man';

SELECT First_name,Last_name
FROM MEMBER
WHERE (SELECT COUNT(*) FROM FRIEND WHERE FRIEND.Member_id=MEMBER.Member_id)>2;

SELECT First_name,Last_name
FROM MEMBER,FRIEND
WHERE FRIEND.Member_id=MEMBER.Member_id AND FRIEND.Friend_Member_id IN( SELECT Member_id FROM MEMBER WHERE First_Name='Recai');

SELECT Status_id
FROM STATUS,MEMBER,PROFILE,ARTIST,FAVOURITE_ARTIST
WHERE MEMBER.Member_id=PROFILE.Member_id AND PROFILE.Date_of_Birth < '2000-01-01' AND PROFILE.Profile_id=FAVOURITE_ARTIST.Profile_id 
AND FAVOURITE_ARTIST.Artist_id = ARTIST.Artist_id AND ARTIST.Artist_name = 'cem yilmaz' AND MEMBER.Member_id=STATUS.Member_id;

SELECT First_name,Last_name
FROM MEMBER,GROUPS
WHERE MEMBER.Member_id=GROUPS.Creator_member_id AND GROUPS.Group_name='issizler';

SELECT First_name,Last_name
FROM MEMBER,PROFILE,FAVOURITE_HOBIE,HOBIE
WHERE MEMBER.Member_id=PROFILE.Member_id AND PROFILE.Profile_id=FAVOURITE_HOBIE.Profile_id AND FAVOURITE_HOBIE.Hobie_id=HOBIE.Hobie_id 
AND HOBIE.Hobie_name='ata binmek';

SELECT Skill_name
FROM SKILLS
WHERE Skill_id IN( 
	SELECT Skill_id
	FROM LIKE_DISLIKE,HAVE_SKILLS,MEMBER,BLOG,FRIEND,CVS
	WHERE LIKE_DISLIKE.Flag=1 AND LIKE_DISLIKE.Object_type=1 AND LIKE_DISLIKE.Object_id=1 AND LIKE_DISLIKE.Friend_relation_id=FRIEND.Friend_relation_id
	AND FRIEND.Member_id=MEMBER.Member_id AND CVS.Member_id=MEMBER.Member_id AND CVS.Cv_id=HAVE_SKILLS.Cv_id AND HAVE_SKILLS.Skill_id=SKILLS.Skill_id);

