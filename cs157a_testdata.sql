USE cs157a;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs157a`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `userID` int(10) NOT NULL,
  `canDelete` int(11) NOT NULL,
  `canEdit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`userID`, `canDelete`, `canEdit`) VALUES
(1, 1, 1),
(2, 1, 1),
(3, 1, 1),
(4, 1, 1),
(5, 1, 0),
(6, 1, 0),
(7, 0, 0),
(8, 0, 1),
(9, 0, 1),
(10, 1, 1),
(11, 1, 0),
(12, 0, 0),
(13, 0, 1),
(14, 1, 1),
(15, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `favorite`
--

CREATE TABLE `favorite` (
  `userID` int(10) NOT NULL,
  `recipeID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `favorite`
--

INSERT INTO `favorite` (`userID`, `recipeID`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 6),
(31, 3),
(31, 4),
(31, 5),
(31, 16),
(32, 1),
(32, 2),
(32, 4),
(32, 7),
(32, 9),
(32, 13);

-- --------------------------------------------------------

--
-- Table structure for table `own`
--

CREATE TABLE `own` (
  `userID` int(10) NOT NULL,
  `recipeID` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `own`
--

INSERT INTO `own` (`userID`, `recipeID`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(31, 13),
(31, 16),
(31, 17),
(31, 18),
(31, 19),
(32, 14),
(32, 15);

-- --------------------------------------------------------

--
-- Table structure for table `rate`
--

CREATE TABLE `rate` (
  `userID` int(10) NOT NULL,
  `recipeID` int(10) NOT NULL,
  `rating` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `rate`
--

INSERT INTO `rate` (`userID`, `recipeID`, `rating`) VALUES
(10, 1, 2),
(11, 1, 3),
(11, 13, 2),
(11, 14, 4),
(14, 3, 4),
(14, 5, 2),
(17, 5, 4),
(17, 8, 2),
(17, 9, 5),
(19, 1, 4),
(19, 9, 2),
(19, 14, 5),
(20, 1, 3),
(20, 2, 1),
(32, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `recipeID` int(10) NOT NULL,
  `ingredient` longtext,
  `author` varchar(255) DEFAULT NULL,
  `instruction` longtext,
  `prepTime` varchar(255) DEFAULT NULL,
  `cookTime` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `servingSize` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`recipeID`, `ingredient`, `author`, `instruction`, `prepTime`, `cookTime`, `course`, `servingSize`, `image_url`) VALUES
(1, '3/4 cup all-purpose flour\r\n2 tablespoons white sugar, divided\r\n1/2 teaspoon baking powder\r\n1/4 teaspoon baking soda\r\n1/8 teaspoon salt\r\n5 tablespoons milk\r\n1/4 cup butter, melted, divided\r\n1 teaspoon apple cider vinegar\r\n3 tablespoons light brown sugar\r\n1 teaspoon ground cinnamon', '1', '1.Preheat oven to 375 degrees F (190 degrees C). Spray 4 muffin cups with cooking spray.\r\n2.Mix flour, 1 tablespoon white sugar, baking powder, baking soda, and salt together in a bowl.\r\n3.Whisk milk, 2 tablespoons butter, and apple cider vinegar together in a small bowl. Pour over the flour mixture; mix until a soft dough forms.\r\n4.Dust a flat work surface with flour. Roll dough out to a 6x7-inch rectangle. Spread remaining 2 tablespoons butter on top.\r\n5.Mix remaining 1 tablespoon white sugar, brown sugar, and cinnamon in a small bowl. Sprinkle evenly over the buttered dough.\r\n6.Roll dough lengthwise into a log. Cut into 4 pieces using a sharp serrated knife. Place 1 piece in each muffin cup.\r\n7.Bake in the preheated oven until golden brown on all sides, 13 to 15 minutes.', '25m', '13m', NULL, 4, 'https://images.media-allrecipes.com/userphotos/560x315/4546484.jpg'),
(2, '1 (16 ounce) container BelGioioso Ricotta Con Latte(R)\r\n1/4 cup white sugar\r\n2 tablespoons semisweet chocolate chips\r\n12 lemon-flavored shortbread cookies\r\n6 mint sprigs', '2', '1. Combine BelGioioso Ricotta con Latte cheese with sugar until well blended. More sugar may be added if a sweeter filling is preferred. Stir in the chocolate chips; cover and refrigerate mixture for at least 30 minutes before serving.\r\n2. To serve, scoop a serving of the cannoli cream onto a dessert plate and garnish with cookies and a mint sprig.', '5m', '35m', NULL, 6, 'https://images.media-allrecipes.com/userphotos/560x315/7138803.jpg'),
(3, '2 teaspoons olive oil\r\n1 pound guanciale (cured pork cheek), diced\r\n1 (16 ounce) package spaghetti\r\n3 eggs\r\n10 tablespoons grated pecorino Romano cheese, divided\r\nsalt to taste\r\nground black pepper to taste', '3', '1. Heat olive oil in a large skillet over medium heat; add guanciale (see Cook\'s Note). Cook, turning occasionally, until evenly browned and crispy, 5 to 10 minutes. Remove from heat and drain on paper towels.\r\n2. Bring a large pot of salted water to a boil. Cook spaghetti in the boiling water, stirring occasionally until tender yet firm to the bite, about 9 minutes. Drain and return to the pot. Let cool, stirring occasionally, about 5 minutes.\r\n3. Whisk eggs, 5 tablespoons pecorino Romano cheese, and some black pepper in a bowl until smooth and creamy. Pour egg mixture over pasta, stirring quickly, until creamy and slightly cooled. Stir in guanciale. Top with remaining 5 tablespoons pecorino Romano cheese and more ground black pepper.', '10m', '14m', NULL, 4, 'https://images.media-allrecipes.com/userphotos/720x405/3280534.jpg'),
(4, '8 ounces Italian sausage links\r\n2 1/4 cups water, divided\r\n1 pound shell-on medium shrimp\r\n3 1/2 tablespoons vegetable oil, divided\r\n1 cup chopped onions\r\n1/3 cup chopped red bell pepper\r\n2 teaspoons Cajun seasoning\r\n1 cup long-grain white rice\r\n1/4 cup Chateau Ste. Michelle Syrah Rosé\r\n1/3 cup frozen peas\r\nSalt and pepper\r\n1/4 cup chopped green onions', '4', '1.Boil sausage in 1/4 cup water for 5 minutes. While the sausage is boiling, remove the shells from the shrimp. Put shells and tails in 2 cups of water. 1. Bring shrimp water to a boil and simmer for 20 minutes.\r\n2. Grill the sausage links for about 5 minutes or until they are completely cooked through. Brush the shrimp with 1/2 tablespoon oil and grill about 2 minutes per side. Pull off and set aside.\r\n3. Heat a medium pot on medium high heat and add vegetable oil, onions, and red pepper. Saute for 3 to 4 minutes or until the onions are translucent. Add Cajun seasoning and rice; cook and stir for 1 minute. Add the Syrah Rose, stir for a few seconds, and strain the shrimp stock into the pot. Once it comes to a boil, turn the heat down to a simmer, cover, and cook for 20 minutes.\r\n4. Meanwhile, chop the shrimp and sausage into bite-sized pieces.\r\n5. Once rice is done, add peas, shrimp, and sausage and cook for another 2 minutes to heat through. Add salt and pepper to your taste. Garnish with chopped green onions.', '15m', '1h5m', NULL, 4, 'https://images.media-allrecipes.com/userphotos/560x315/7183198.jpg'),
(5, '1 tablespoon pork rub seasoning, or to taste\r\n1/4 teaspoon Chinese five-spice powder\r\n1 (3 pound) pork loin roast\r\n2 medium sweet potatoes, peeled and cut into bite-size pieces\r\n1/2 cup brown sugar\r\n3 tablespoons butter\r\nsalt and ground black pepper to taste', '5', '1. Mix pork rub seasoning and Chinese five-spice powder together in a small bowl. Rub all over pork roast.\r\n2. Place sweet potatoes into the bottom of a slow cooker; add brown sugar and butter. Place roast on top and season with salt and pepper.\r\n3. Cook on Low until roast is fork-tender, 6 to 7 hours. An instant-read thermometer inserted into the center should read at least 145 degrees F (63 degrees C).', '10m', '6h', NULL, 6, 'https://images.media-allrecipes.com/userphotos/560x315/7092749.jpg'),
(6, '2 (14.5 ounce) cans green beans, drained\r\n1 (10.75 ounce) can condensed cream of mushroom soup\r\n1 (6 ounce) can French fried onions\r\n1 cup shredded Cheddar cheese', '6', '1. Preheat oven to 350 degrees F (175 degrees C).\r\n2. Place green beans and soup in a large microwave-safe bowl. Mix well and heat in the microwave on HIGH until warm (3 to 5 minutes). Stir in 1/2 cup of cheese and heat mixture for another 2 to 3 minutes. Transfer green bean mixture to a casserole dish and sprinkle with French fried onions and remaining cheese.\r\n3. Bake in a preheated 350 degrees F (175 degrees C) oven until the cheese melts and the onions just begin to brown.', '10m', '15m', NULL, 6, 'https://images.media-allrecipes.com/userphotos/720x405/1656932.jpg'),
(7, '1 tablespoon olive oil\r\n6 ounces pancetta or salt pork, diced\r\n2 1/2 pounds beef chuck\r\n2 teaspoons kosher salt\r\n1/2 cup diced celery\r\n1/2 cup diced carrot\r\n1 teaspoon kosher salt\r\n1 teaspoon freshly ground black pepper\r\n1 tablespoon tomato paste\r\n1 bay leaf\r\n2/3 cup white wine\r\n4 pounds yellow onions, sliced\r\n2 pounds red onions, sliced\r\nsalt to taste\r\n2 (16 ounce) boxes uncooked rigatoni\r\n1 tablespoon chopped fresh marjoram leaves\r\n1 pinch cayenne pepper\r\n2 tablespoons freshly grated Parmigiano-Reggiano cheese', '7', '1. Heat oil in a large pot over medium heat. Cook pancetta until most of fat is rendered out, about 6 minutes. Remove cooked pancetta with a slotted spoon and save.\r\n2. Raise heat to high and transfer meat to the pot. Season with salt. Cook and stir until liquid releases from beef and begins to evaporate, and meat browns, 10 to 15 minutes.\r\n3. Reduce heat to medium-high. Add celery, carrots, reserved cooked pancetta, salt and pepper. Cook and stir about 5 minutes. Add a heaping tablespoon of tomato paste, bay leaf, and white wine. Cook and stir, scraping up the brownings from the bottom of the pan, 2 to 3 minutes. Add sliced onions. Reduce heat to medium. Cover pot and cook 30 minutes without stirring. After 30 minutes, stir onions and meat until well mixed. Cover again, and cook another 30 minutes. Stir.\r\n4. Reduce heat to low and cook uncovered 8 to 10 hours, stirring occasionally. Skim off fat as mixture cooks. If sauce seems to reduce too much, add water or broth as needed to maintain a sauce-like consistency. Cook until beef and onions seem to melt into each other.\r\n5. Bring a large pot of lightly salted water to a boil. Cook rigatoni in the boiling water, stirring occasionally until just barely al dente, 10 to 12 minutes. Drain.\r\n6. Add rigatoni to the sauce and cook until heated through. Serve topped with a pinch of marjoram and freshly grated Parmigiano-Reggiano cheese.', '30m', '9h30h', NULL, 8, 'https://images.media-allrecipes.com/userphotos/720x405/3489951.jpg'),
(8, '1 tablespoon salt\r\n4 large green bell peppers - tops, seeds, and membranes removed\r\n1 tablespoon olive oil\r\n1/2 cup chopped onion\r\n2 cups cooked rice\r\n1 (15 ounce) can black beans, drained and rinsed\r\n1 (14.5 ounce) can chili-style diced tomatoes\r\n1 teaspoon chili powder\r\n1 teaspoon garlic salt\r\n1/2 teaspoon ground cumin\r\n1/2 teaspoon salt\r\n1 (8 ounce) package shredded Mexican cheese blend (such as Sargento(R) Authentic Mexican)', '8', '1. Preheat oven to 350 degrees F (175 degrees C).\r\nBring a large pot of water and 1 tablespoon salt to a boil; cook green bell peppers in the boiling water until slightly softened, 3 to 4 minutes. Drain.\r\n2. Heat olive oil in a skillet over medium heat; cook and stir onion in the hot oil until softened and transparent, 5 to 10 minutes.\r\n3. Mix rice, black beans, tomatoes, and cooked onion in a large bowl. Add chili powder, garlic salt, cumin, 1/2 teaspoon salt; stir until evenly mixed. 4. Fold 1 1/2 cups Mexican cheese blend into rice mixture. Spoon rice mixture into each bell pepper; arrange peppers in 9x9-inch baking dish. Sprinkle peppers with remaining Mexican cheese blend.\r\n5. Bake in the preheated oven until cheese is melted and bubbling, about 30 minutes.', '15m', '40m', NULL, 4, 'https://images.media-allrecipes.com/userphotos/720x405/972823.jpg'),
(13, '1 1/2 cups all-purpose flour\r\n1 cup white sugar\r\n1/4 cup cocoa powder\r\n1 teaspoon baking soda\r\n1/2 teaspoon salt\r\n1/3 cup vegetable oil\r\n1 teaspoon vanilla extract\r\n1 teaspoon distilled white vinegar\r\n1 cup water', '31', '1. Preheat oven to 350 degrees F (175 degrees C). Lightly grease one 9x5 inch loaf pan.\r\n2. Sift together the flour, sugar, cocoa, baking soda and salt. Add the oil, vanilla, vinegar and water. Mix together until smooth.\r\n3. Pour into prepared pan and bake at 350 degrees F (175 degrees C) for 45 minutes. Remove from oven and allow to cool.', '15m', '45m', '', 8, 'https://images.media-allrecipes.com/userphotos/720x405/4525746.jpg'),
(14, '2/3 cup soy sauce\r\n1/2 cup honey\r\n1/2 cup Chinese rice wine (or sake or dry sherry)\r\n1/3 cup hoisin sauce\r\n1/3 cup ketchup\r\n1/3 cup brown sugar\r\n4 cloves garlic, crushed\r\n1 teaspoon Chinese five-spice powder\r\n1/2 teaspoon freshly ground black pepper\r\n1/4 teaspoon cayenne pepper\r\n1/8 teaspoon pink curing salt (optional)\r\n1 (3 pound) boneless pork butt (shoulder)\r\n1 teaspoon kosher salt, or to taste', '32', '1. Place soy sauce, honey, rice wine, hoisin sauce, ketchup, brown sugar, garlic, five-spice powder, black pepper, cayenne pepper, and curing salt in a saucepan. Bring to a boil on high heat; reduce heat to medium-high. Cook for 1 minute. Remove from heat. Cool to room temperature.\r\n2. Cut pork roast in half lengthwise. Cut each half again lengthwise forming 4 long, thick pieces of pork.\r\n3. Transfer cooled sauce to a large mixing bowl. Stir in red food coloring. Place pork sections into sauce and coat each piece. Cover with plastic wrap and refrigerate 4 to 12 hours.\r\n4. Preheat grill for medium heat, 275 to 300 degrees F (135 to 150 degrees C) and lightly oil the grate. Line a baking sheet with parchment paper.\r\n5. Remove sections of pork from marinade and let excess drip off. Place on prepared baking sheet. Sprinkle with kosher salt to taste.\r\n6. Transfer pork sections to grate over indirect heat on prepared grill. Cover and cook about 45 minutes. Brush with marinade; turn. Continue cooking until an instant-read thermometer inserted into the center reads 185 and 190 degrees F, about 1 hour and 15 minutes more. Do not use any more marinade on cooked meat until after you boil it.\r\n7. Place leftover marinade in saucepan; bring to a boil; let simmer 1 minutes. Remove from heat. Now you can use it to brush over the cooked pork', '10m', '2h', '', 6, 'https://images.media-allrecipes.com/userphotos/720x405/4525770.jpg'),
(15, '1 pound Hatch chile peppers, halved and seeded\r\n1 (3 pound) boneless pork roast, cubed\r\n2 cups all-purpose flour\r\n3 tablespoons salt, divided\r\n3 tablespoons coarsely ground black pepper, divided\r\n1/4 cup vegetable oil\r\n2 cups chicken stock\r\n1 (15 ounce) can diced tomatoes with green chile peppers\r\n1 large sweet onion, chopped\r\n2 tablespoons ground cumin\r\n3 cloves garlic', '32', '1. Set oven rack about 6 inches from the heat source and preheat the oven\'s broiler. Line a baking sheet with aluminum foil. Place peppers with cut sides down onto the prepared baking sheet.\r\n2. Cook under the preheated broiler until the skin of the peppers has blackened and blistered, 5 to 8 minutes. Place blackened peppers into a bowl and cover tightly with plastic wrap. Allow peppers to steam as they cool, about 20 minutes. Remove and discard skins; chop peppers into smaller pieces.\r\n3. Place cubed pork in a resealable plastic bag; coat with flour, 2 tablespoons salt, and 2 tablespoons pepper. Heat oil in a skillet over medium heat. Cook pork in the hot oil until browned, 5 to 7 minutes. Transfer to a slow cooker set to High.\r\n4. Add the Hatch chiles, remaining salt and pepper, chicken stock, diced tomatoes with peppers, onion, cumin, and garlic to the slow cooker. Mix and cover. Cook on High until pork is tender and flavors blend, about 4 hours', '20m', '4h10m', '', 8, 'https://images.media-allrecipes.com/userphotos/720x405/5679204.jpg'),
(16, '12 ounces cranberries\r\n1 cup white sugar\r\n1 cup orange juice', '31', 'In a medium sized saucepan over medium heat, dissolve the sugar in the orange juice. Stir in the cranberries and cook until the cranberries start to pop (about 10 minutes). Remove from heat and place sauce in a bowl. Cranberry sauce will thicken as it cools.', '', '', '', 11, 'https://images.media-allrecipes.com/userphotos/720x405/743657.jpg'),
(17, '1 1/2 tablespoons vegetable oil\r\n1 small onion, diced\r\n1 teaspoon minced fresh ginger root\r\n4 cloves garlic, minced\r\n2 potatoes, cubed\r\n4 carrots, cubed\r\n1 fresh jalapeno pepper, seeded and sliced\r\n3 tablespoons ground unsalted cashews\r\n1 (4 ounce) can tomato sauce\r\n2 teaspoons salt\r\n1 1/2 tablespoons curry powder\r\n1 cup frozen green peas\r\n1/2 green bell pepper, chopped\r\n1/2 red bell pepper, chopped\r\n1 cup heavy cream\r\n1 bunch fresh cilantro for garnish', '31', '1. Heat the oil in a skillet over medium heat. Stir in the onion, and cook until tender. Mix in ginger and garlic, and continue cooking 1 minute. Mix potatoes, carrots, jalapeno, cashews, and tomato sauce. Season with salt and curry powder. Cook and stir 10 minutes, or until potatoes are tender.\r\n2. Stir peas, green bell pepper, red bell pepper, and cream into the skillet. Reduce heat to low, cover, and simmer 10 minutes. Garnish with cilantro to serve', '25m', '30m', '', 4, 'https://images.media-allrecipes.com/userphotos/720x405/3787267.jpg'),
(18, '2 cups red lentils\r\n1 large onion, diced\r\n1 tablespoon vegetable oil\r\n2 tablespoons curry paste\r\n1 tablespoon curry powder\r\n1 teaspoon ground turmeric\r\n1 teaspoon ground cumin\r\n1 teaspoon chili powder\r\n1 teaspoon salt\r\n1 teaspoon white sugar\r\n1 teaspoon minced garlic\r\n1 teaspoon minced fresh ginger\r\n1 (14.25 ounce) can tomato puree', '31', '1. Wash the lentils in cold water until the water runs clear. Put lentils in a pot with enough water to cover; bring to a boil, place a cover on the pot, reduce heat to medium-low, and simmer, adding water during cooking as needed to keep covered, until tender, 15 to 20 minutes. Drain.\r\n2. Heat vegetable oil in a large skillet over medium heat; cook and stir onions in hot oil until caramelized, about 20 minutes.\r\n3. Mix curry paste, curry powder, turmeric, cumin, chili powder, salt, sugar, garlic, and ginger together in a large bowl; stir into the onions. Increase heat to high and cook, stirring constantly, until fragrant, 1 to 2 minutes.\r\n4. Stir in the tomato puree, remove from heat and stir into the lentils.', '10m', '30m', '', 8, 'https://images.media-allrecipes.com/userphotos/720x405/490284.jpg'),
(19, 'afd', '31', 'aesef', '12', '32', 'a', 4, 'https://images.media-allrecipes.com/userphotos/250x250/4546484.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `userID` int(10) NOT NULL,
  `recipeID` int(10) NOT NULL,
  `timeReported` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`userID`, `recipeID`, `timeReported`) VALUES
(1, 18, '2019-12-10 20:29:42'),
(2, 16, '2019-12-10 20:29:42'),
(3, 13, '2019-12-10 20:29:42'),
(4, 14, '2019-12-11 21:32:19'),
(5, 15, '2019-12-10 20:29:42'),
(10, 1, '2019-10-15 13:16:08'),
(11, 2, '2019-09-03 11:16:06'),
(12, 3, '2019-08-07 12:22:23'),
(13, 4, '2019-08-01 11:21:11'),
(14, 5, '2019-08-14 15:11:29'),
(15, 6, '2019-10-04 22:22:25'),
(16, 7, '2019-06-03 23:33:43'),
(17, 8, '2019-06-05 03:35:35'),
(18, 19, '2019-12-11 21:32:19'),
(20, 17, '2019-12-10 20:29:42');

-- --------------------------------------------------------

--
-- Table structure for table `reportedRecipes`
--

CREATE TABLE `reportedRecipes` (
  `recipeID` int(10) NOT NULL,
  `context` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `reportedRecipes`
--

INSERT INTO `reportedRecipes` (`recipeID`, `context`) VALUES
(1, 'context1'),
(2, 'context2'),
(3, 'context3'),
(4, 'context4'),
(5, 'context5'),
(6, 'context6'),
(7, 'context7'),
(8, 'context8'),
(13, 'context13'),
(14, 'context14'),
(15, 'context15'),
(16, 'context12'),
(17, 'context11'),
(18, 'context10'),
(19, 'context9');

-- --------------------------------------------------------

--
-- Table structure for table `respondTo`
--

CREATE TABLE `respondTo` (
  `userID` int(10) NOT NULL,
  `actionTaken` varchar(255) DEFAULT NULL,
  `recipeID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `respondTo`
--

INSERT INTO `respondTo` (`userID`, `actionTaken`, `recipeID`) VALUES
(1, 'ignored', '1'),
(1, 'deleted', '2'),
(1, 'edited', '3'),
(1, 'ignored', '4'),
(1, 'ignored', '5'),
(1, 'edited', '6'),
(1, 'edited', '7'),
(1, 'ignored', '8'),
(10, 'ignored', '1'),
(10, 'deleted', '13'),
(10, 'ignored', '18'),
(10, 'deleted', '2'),
(13, 'ignored', '15'),
(13, 'deleted', '16'),
(13, 'deleted', '4');

-- --------------------------------------------------------

--
-- Table structure for table `searchCategories`
--

CREATE TABLE `searchCategories` (
  `recipeID` int(10) NOT NULL,
  `name` varchar(255) NOT NULL,
  `vegan` tinyint(1) DEFAULT NULL,
  `vegetarian` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `searchCategories`
--

INSERT INTO `searchCategories` (`recipeID`, `name`, `vegan`, `vegetarian`) VALUES
(1, 'Yeast-Free Cinnamon Rolls', 0, 0),
(2, 'Cannoli Cream with Cookies', 0, 0),
(3, 'Spaghetti alla Carbonara: the Traditional Italian Recipe', 0, 0),
(4, 'Cajun-Style Rice Pilaf', 0, 0),
(5, 'Slow Cooker Pork Loin Roast with Brown Sugar and Sweet Potatoes', 0, 0),
(6, 'Best Green Bean Casserole', 1, 0),
(7, 'Rigatoni alla Genovese', 0, 0),
(8, 'Vegetarian Mexican Inspired Stuffed Peppers', 0, 1),
(13, 'Vegan Chocolate Cake', 1, 0),
(14, 'Chinese Barbeque Pork', 0, 0),
(15, 'Arizona Hatch Chili', 0, 0),
(16, 'Cranberry Sauce', 0, 0),
(17, 'Vegetarian Korma', 0, 1),
(18, 'Red Lentil Curry', 0, 0),
(19, 'TEST', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` int(10) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `email`, `username`, `password`) VALUES
(1, 'user1@gmail.com', 'user1', 'randomPass1'),
(2, 'user2@gmail.com', 'user2', 'randomPass1'),
(3, 'user3@gmail.com', 'user3', 'randomPass1'),
(4, 'user4@gmail.com', 'user4', 'randomPass1'),
(5, 'user5@gmail.com', 'user5', 'randomPass1'),
(6, 'user6@gmail.com', 'user6', 'randomPass1'),
(7, 'user7@gmail.com', 'user7', 'randomPass1'),
(8, 'user8@gmail.com', 'user8', 'randomPass1'),
(9, 'user9@gmail.com', 'user9', 'randomPass1'),
(10, 'user10@gmail.com', 'user10', 'randomPass1'),
(11, 'user11@gmail.com', 'user11', 'randomPass1'),
(12, 'user12@gmail.com', 'user12', 'randomPass1'),
(13, 'user13@gmail.com', 'user13', 'randomPass1'),
(14, 'user14@gmail.com', 'user14', 'randomPass1'),
(15, 'user15@gmail.com', 'user15', 'randomPass1'),
(16, 'user16@gmail.com', 'user16', 'randomPass1'),
(17, 'user17@gmail.com', 'user17', 'randomPass1'),
(18, 'user18@gmail.com', 'user18', 'randomPass1'),
(19, 'user19@gmail.com', 'user19', 'randomPass1'),
(20, 'user20@gmail.com', 'user20', 'randomPass1'),
(31, '123@gmail.com', 'olivia', '123'),
(32, '1234', 'test', '1234'),
(33, '123@gmail.com', 'test123', '123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`userID`);

--
-- Indexes for table `favorite`
--
ALTER TABLE `favorite`
  ADD PRIMARY KEY (`userID`,`recipeID`);

--
-- Indexes for table `own`
--
ALTER TABLE `own`
  ADD PRIMARY KEY (`userID`,`recipeID`);

--
-- Indexes for table `rate`
--
ALTER TABLE `rate`
  ADD PRIMARY KEY (`userID`,`recipeID`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`recipeID`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`userID`,`recipeID`);

--
-- Indexes for table `reportedRecipes`
--
ALTER TABLE `reportedRecipes`
  ADD PRIMARY KEY (`recipeID`);

--
-- Indexes for table `respondTo`
--
ALTER TABLE `respondTo`
  ADD PRIMARY KEY (`userID`,`recipeID`);

--
-- Indexes for table `searchCategories`
--
ALTER TABLE `searchCategories`
  ADD PRIMARY KEY (`recipeID`,`name`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `recipeID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
