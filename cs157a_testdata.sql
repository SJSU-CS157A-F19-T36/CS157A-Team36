USE cs157a;

LOCK TABLES users WRITE;
INSERT INTO users (email, username, password)
VALUES
	("user1@gmail.com", "user1", "randomPass1"),
	("user2@gmail.com", "user2", "randomPass1"),
	("user3@gmail.com", "user3", "randomPass1"),
	("user4@gmail.com", "user4", "randomPass1"),
	("user5@gmail.com", "user5", "randomPass1"),
	("user6@gmail.com", "user6", "randomPass1"),
	("user7@gmail.com", "user7", "randomPass1"),
	("user8@gmail.com", "user8", "randomPass1"),
	("user9@gmail.com", "user9", "randomPass1"),
	("user10@gmail.com", "user10", "randomPass1"),
	("user11@gmail.com", "user11", "randomPass1"),
	("user12@gmail.com", "user12", "randomPass1"),
	("user13@gmail.com", "user13", "randomPass1"),
	("user14@gmail.com", "user14", "randomPass1"),
	("user15@gmail.com", "user15", "randomPass1"),
	("user16@gmail.com", "user16", "randomPass1"),
	("user17@gmail.com", "user17", "randomPass1"),
	("user18@gmail.com", "user18", "randomPass1"),
	("user19@gmail.com", "user19", "randomPass1"),
	("user20@gmail.com", "user20", "randomPass1"),
	("user21@gmail.com", "user21", "randomPass1"),
	("user22@gmail.com", "user22", "randomPass1"),
	("user23@gmail.com", "user23", "randomPass1"),
	("user24@gmail.com", "user24", "randomPass1"),
	("user25@gmail.com", "user25", "randomPass1"),
	("user26@gmail.com", "user26", "randomPass1"),
	("user27@gmail.com", "user27", "randomPass1"),
	("user28@gmail.com", "user28", "randomPass1"),
	("user29@gmail.com", "user29", "randomPass1"),
	("user30@gmail.com", "user30", "randomPass1");
UNLOCK TABLES;
LOCK TABLES admin WRITE;
INSERT INTO admin
VALUES
	(1, 1, 1),
	(2, 1, 1),
	(3, 1, 1),
	(4, 1, 1),
	(5, 1, 1),
	(6, 1, 1),
	(7, 0, 0),
	(8, 0, 0),
	(9, 1, 1),
	(10, 1, 1),
	(11, 1, 1),
	(12, 1, 1),
	(13, 1, 1),
	(14, 1, 1),
	(15, 1, 0);
UNLOCK TABLES;
LOCK TABLES recipes WRITE;
INSERT INTO recipes (ingredient, author, instruction, prepTime, cookTime, course, servingSize, image_url)
VALUES
	("Pasta, Sauce, Meatballs", NULL, "This is a placeholder for recipe instructions.", 30, 10, "Dinner", 4, "https://www.thespruceeats.com/thmb/iGd5JZLcKvOCtr0vtn8S3b9W24s=/3651x2054/smart/filters:no_upscale()/spaghettimeatballs-135583313-56bdcea15f9b5829f85ee94a.jpg"),
    ("Pasta, Sauce, Meatballs", NULL, "This is a placeholder for recipe instructions.", 30, 10, "Dinner", 4, "https://www.thespruceeats.com/thmb/iGd5JZLcKvOCtr0vtn8S3b9W24s=/3651x2054/smart/filters:no_upscale()/spaghettimeatballs-135583313-56bdcea15f9b5829f85ee94a.jpg");
UNLOCK TABLES;
LOCK TABLES reportedRecipes WRITE;
INSERT INTO reportedRecipes
VALUES
	(1, "context1"),
	(2, "context2"),
	(3, "context3"),
	(4, "context4"),
	(5, "context5"),
	(6, "context6"),
	(7, "context7"),
	(8, "context8"),
	(9, "context9"),
	(10, "context10"),
	(11, "context11"),
	(12, "context12"),
	(13, "context13"),
	(14, "context14"),
	(15, "context15");
UNLOCK TABLES;
LOCK TABLES searchCategories WRITE;
INSERT INTO searchCategories
VALUES
	(1, "Spaghetti and Meatballs", 0, 0),
    (2, "Chocolate Cake", 0, 0),
    (3, "Vegan Chocolate Cake", 1, 1),
    (4, "Ratatouille", 0, 1),
    (5, "Margherita Pizza", 0, 1),
    (6, "Beef Stew", 0, 0),
    (7, "Chow Mein", 0, 0),
    (8, "Beef Tacos", 0, 0),
    (9, "Stir Fry", 0, 0),
    (10, "Ice Cream", 0, 1),
    (11, "Chili con Carne", 0, 0),
    (12, "Eggplant Parmesan", 0, 1),
    (13, "Colorado Omelette", 0, 0),
    (14, "Chicago Dog", 0, 0),
    (15, "Apple Pie", 0, 1);
UNLOCK TABLES;
LOCK TABLES own WRITE;
INSERT INTO own
VALUES
	(11, 1),
    (11, 5),
    (11, 14),
    (12, 2),
    (12, 9),
    (13, 3),
    (14, 4),
    (15, 12),
    (16, 8),
    (17, 7),
    (17, 13),
    (21, 6),
    (22, 15),
    (23, 10),
    (24, 11);
UNLOCK TABLES;
LOCK TABLES rate WRITE;
INSERT INTO rate
VALUES
	(10, 1, 2),
    (11, 1, 3),
    (14, 3, 4),
    (22, 3, 2),
    (14, 5, 2),
    (17, 5, 4),
    (17, 8, 2),
    (17, 9, 5),
    (19, 1, 4),
    (20, 1, 3),
    (11, 13, 2),
    (11, 14, 4),
    (19, 14, 5),
    (19, 9, 2),
    (20, 2, 1);
UNLOCK TABLES;
LOCK TABLES favorite WRITE;
INSERT INTO favorite
VALUES
	(10, 1),
    (11, 2),
    (12, 3),
    (13, 4),
    (14, 5),
    (15, 6),
    (16, 7),
    (17, 8),
    (18, 9),
    (19, 10),
    (20, 11),
    (21, 12),
    (22, 13),
    (23, 14),
    (24, 15);
UNLOCK TABLES;
LOCK TABLES report WRITE;
INSERT INTO report
VALUES
	(10, 1, '2019-10-15 06:16:08'),
    (11, 2, '2019-09-03 04:16:06'),
    (12, 3, '2019-08-07 05:22:23'),
    (13, 4, '2019-08-01 04:21:11'),
    (14, 5, '2019-08-14 08:11:29'),
    (15, 6, '2019-10-04 15:22:25'),
    (16, 7, '2019-06-03 16:33:43'),
    (17, 8, '2019-06-04 20:35:35'),
    (18, 9, '2019-10-01 14:29:29'),
    (19, 10, '2019-05-09 12:22:32'),
    (20, 11, '2019-10-03 19:25:00'),
    (21, 12, '2019-08-21 21:41:00'),
    (22, 13, '2019-10-06 05:28:28'),
    (23, 14, '2019-07-09 11:28:39'),
    (24, 15, '2019-09-30 20:55:41');
UNLOCK TABLES;
LOCK TABLES respondTo WRITE;
INSERT INTO respondTo
VALUES
	(1, 1, "ignored"),
    (1, 2, "deleted"),
    (1, 3, "edited"),
    (1, 4, "ignored"),
    (1, 5, "ignored"),
    (13, 6, "deleted"),
    (13, 10, "ignored"),
    (13, 13, "deleted"),
    (1, 7, "edited"),
    (1, 8, "edited"),
    (10, 16, "ignored"),
    (1, 9, "ignored"),
    (10, 17, "ignored"),
    (10, 18, "deleted"),
    (10, 11, "deleted");
UNLOCK TABLES;
