CREATE TABLE groups (
groupID int NOT NULL PRIMARY KEY,
groupName varchar(40) NOT NULL UNIQUE
);

INSERT INTO groups
VALUES (01, 'I.T.'),
(02, 'Sales'),
(03, 'Administration'),
(04, 'Operations');


CREATE TABLE rooms (
roomID int NOT NULL PRIMARY KEY,
roomName varchar(40) NOT NULL UNIQUE
);

INSERT INTO rooms
VALUES (01, '101'),
(02, '102'),
(03, 'Auditorium A'),
(04, 'Auditorium B');


CREATE TABLE users (
userID int NOT NULL PRIMARY KEY,
userName varchar(40) NOT NULL,
groupID int,
constraint groupID_fk FOREIGN KEY (groupID) REFERENCES groups(groupID)
);

INSERT INTO users
VALUES (01, 'Modesto', 01),
(02, 'Ayine', 01), 
(03, 'Christopher', 02),
(04, 'Cheong woo', 02),
(05, 'Salaut', 03),
(06, 'Heidy', NULL);


CREATE TABLE assignments (
assignmentsID int NOT NULL PRIMARY KEY,
groupID int,
roomID int,
FOREIGN KEY (groupID) REFERENCES groups(groupID),
FOREIGN KEY (roomID) REFERENCES rooms(roomID)
);

INSERT INTO assignments
VALUES (01, 01, 01),
(02, 01, 02),
(03, 02, 02),
(04, 02, 03);

/*
All groups, and the users in each group. A group should appear even if there are no users assigned to the group
*/

SELECT groupName, users.userName
FROM groups
LEFT JOIN users
ON groups.groupID = users.groupID;

/*
All rooms, and the groups assigned to each room. The rooms should appear even if no groups have been
assigned to them.
*/

SELECT roomName, groups.groupName
FROM rooms
LEFT JOIN assignments
	INNER JOIN groups
	ON groups.groupID = assignments.groupID
ON assignments.roomID = rooms.roomID;

/*
A list of users, the groups that they belong to, and the rooms to which they are assigned. This should be sorted
alphabetically by user, then by group, then by room.
*/

SELECT users.userName, groups.groupName, rooms.roomName
FROM users
LEFT JOIN groups
ON users.groupID = groups.groupID
LEFT JOIN assignments
ON assignments.groupID = groups.groupID
LEFT JOIN rooms
ON assignments.roomID = rooms.roomID
ORDER BY users.userName ASC, groups.groupName ASC, rooms.roomName ASC;