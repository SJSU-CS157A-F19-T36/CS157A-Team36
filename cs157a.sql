DROP DATABASE IF EXISTS cs157a;
CREATE DATABASE cs157a;
USE cs157a;

CREATE TABLE users (
	userID INT(10) AUTO_INCREMENT,
    email VARCHAR(255),
    username VARCHAR(255),
    password VARCHAR(255),
    PRIMARY KEY (userID)
);
CREATE TABLE admin (
	userID INT(10),
    privileges VARCHAR(255),
    PRIMARY KEY (userID)
);
CREATE TABLE recipes (
	recipeID INT(10) AUTO_INCREMENT,
    ingredient LONGTEXT,
    author VARCHAR(255),
    instruction LONGTEXT,
    prepTime VARCHAR(255),
    cookTime VARCHAR(255),
    course VARCHAR(255),
    servingSize INT(11),
    image_url VARCHAR(255),
    PRIMARY KEY (recipeID)
);
CREATE TABLE reportedRecipes (
	recipeID INT(10),
    context VARCHAR(255),
    PRIMARY KEY (recipeID)
);
CREATE TABLE searchCategories (
	recipeID INT(10),
    name VARCHAR(255),
    vegan TINYINT(1),
    vegetarian TINYINT(1),
    PRIMARY KEY (recipeID, name)
);
CREATE TABLE own (
	userID INT(10),
    recipeID INT(10),
    PRIMARY KEY (userID, recipeID)
);
CREATE TABLE rate (
	userID INT(10),
    recipeID INT(10),
    rating TINYINT(1),
    PRIMARY KEY (userID, recipeID)
);
CREATE TABLE favorite (
	userID INT(10),
    recipeID INT(10),
    PRIMARY KEY (userID, recipeID)
);
CREATE TABLE report (
	userID INT(10),
    recipeID INT(10),
    timeReported TIMESTAMP,
    PRIMARY KEY (userID, recipeID)
);
CREATE TABLE respondTo (
	userID INT(10),
    reportID INT(10),
    actionTaken VARCHAR(255),
    PRIMARY KEY (userID, reportID)
);
    
