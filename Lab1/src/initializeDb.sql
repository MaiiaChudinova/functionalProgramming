-- USE sql11405509;
-- uncomment previous line to use in phpMyAdmin query window

DROP TABLE IF EXISTS students;
CREATE TABLE students
(
    id             SERIAL           PRIMARY KEY,
    name           VARCHAR(50)      NOT NULL,
    surname        VARCHAR(50)      NOT NULL,
    enrollYear     INT      		NOT NULL,
    groupId    	   INT              REFERENCES groups (id)
);

DROP TABLE IF EXISTS groups;
CREATE TABLE groups
(
    id   SERIAL         PRIMARY KEY,
    name VARCHAR(50)    NOT NULL
);

DROP TABLE IF EXISTS lecturers;
CREATE TABLE lecturers
(
    id      SERIAL      PRIMARY KEY,
    name    VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL
);

DROP TABLE IF EXISTS themes;
CREATE TABLE themes
(
    id      		SERIAL      	PRIMARY KEY,
    name    		VARCHAR(100) 	NOT NULL,
    additionalInfo  VARCHAR(5000) 	NULL
);

DROP TABLE IF EXISTS themeProgresses;
CREATE TABLE themeProgresses
(
    studentId  			INT     REFERENCES students (id),
    themeId    			INT     REFERENCES themes (id)
    progressPercentage  INT   	NULL
);

DROP TABLE IF EXISTS qna;
CREATE TABLE qna
(
	id			SERIAL			PRIMARY KEY,
    studentId  	INT     		REFERENCES students (id),
    lecturerId  INT				REFERENCES lecturers (id),
    question    VARCHAR(300)    NOT NULL,
	answer		VARCHAR(500)	NULL
);

DROP TABLE IF EXISTS timetable;
CREATE TABLE timetable
(
	id			SERIAL		PRIMARY KEY,
    lecturerId  INT			REFERENCES lecturers (id),
    themeId  	INT			REFERENCES themes (id),
    groupId     INT     	REFERENCES groups (id),
    lessonDate  DATETIME    NOT NULL
);


INSERT INTO     groups (name)     VALUES ('IPS-41');
INSERT INTO     groups (name)     VALUES ('IPS-42');

INSERT INTO     lecturers (name, surname)  VALUES ('Larysa', 'Katerynych');
INSERT INTO     lecturers (name, surname)  VALUES ('Yevhen', 'Demkivsky');
INSERT INTO     lecturers (name, surname)  VALUES ('Oksana', 'Shkilniak');

INSERT INTO     students (name, surname, enrollYear, groupId) VALUES ('Maiia', 'Chudinova', 2017, 2);
INSERT INTO     students (name, surname, enrollYear, groupId) VALUES ('Valeriia', 'Yaroshenko', 2017, 1);
INSERT INTO     students (name, surname, enrollYear, groupId) VALUES ('Oleksandra', 'Kmett', 2017, 2);
INSERT INTO     students (name, surname, enrollYear, groupId) VALUES ('Olha', 'Karpyshyn', 2017, 1);

INSERT INTO     themes (name, additionalInfo)   VALUES ('OOP', NULL);
INSERT INTO     themes (name, additionalInfo)   VALUES ('Scientific World View', NULL);
INSERT INTO     themes (name, additionalInfo)   VALUES ('Computer Networks', 'Google Meet link: https://meet.google.com/ijh-davh-yju');

INSERT INTO     qna (studentId, lecturerId, question, answer)    VALUES (1, 2, 'Can any router in the world support broadcasting?', 'Check references');
INSERT INTO     qna (studentId, lecturerId, question, answer)    VALUES (2, 2, 'What is IPv6 header size? Why without params?', 'To impove QoS, 40 bytes fixed');
INSERT INTO     qna (studentId, lecturerId, question, answer)    VALUES (3, 1, 'How can we optimize 3dsMax render time?', NULL);

INSERT INTO     themeProgresses (studentId, themeId, progressPercentage) VALUES (1, 3, 90);
INSERT INTO     themeProgresses (studentId, themeId, progressPercentage) VALUES (2, 2, 45);
INSERT INTO     themeProgresses (studentId, themeId, progressPercentage) VALUES (3, 1, 85);
INSERT INTO     themeProgresses (studentId, themeId, progressPercentage) VALUES (4, 1, NULL);
INSERT INTO     themeProgresses (studentId, themeId, progressPercentage) VALUES (1, 2, 20);

INSERT INTO     timetable (lecturerId, themeId, groupId, lessonDate) VALUES (2, 3, 1, '2021-03-11 10:35:00');
INSERT INTO     timetable (lecturerId, themeId, groupId, lessonDate) VALUES (2, 3, 2, '2021-03-11 12:10:00');

COMMIT;

