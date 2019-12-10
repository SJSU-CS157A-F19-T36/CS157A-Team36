const express = require('express');
const mysql = require('mysql');
const app = express();
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');
const util = require('util');

const databaseConfig = {
	host	: 'localhost',
	user	: 'root',
	password: 'root',
	database: 'cs157a'
};
function getConnection() {
	return mysql.createConnection(databaseConfig);
}

class Database {
	constructor( config ) {
		this.connection = mysql.createConnection( config );
	}
	query( sql, args ) {
		return new Promise( ( resolve, reject ) => {
			this.connection.query( sql, args, ( err, rows ) => {
				if ( err )
					return reject( err );
				resolve( rows );
			} );
		} );
	}
	close() {
		return new Promise( ( resolve, reject ) => {
			this.connection.end( err => {
				if ( err )
					return reject( err );
				resolve();
			} );
		} );
	}
}
let database = new Database(databaseConfig);


app.set('view engine', 'pug');
app.set('views', './views');
app.use(express.static(path.join(__dirname, 'public')));
app.use(session({
	secret: 'secret',
	resave: true,
	saveUninitialized: true,
    // cookie: {
    //     maxAge: 60 * 1000 * 30
    // },
	username: '',
    loggedin: false
}));
app.use(bodyParser.urlencoded({extended : true}));
app.use(bodyParser.json());


app.get('/', function(req, res){
	if (req.session.userID) {
		res.redirect('/home');
	} else {
		res.render('login');
	}
});

function listRecipes(recipes, req, res) {
	var userName = req.session.username;
	var userID = req.session.userID;
	var privileges = req.session.privileges;
	var favorites = [];
	var recipe_list = [];
	if(recipes.length === 0)
		res.render('list_recipes', {"user" : userName , "recipes" : recipe_list, "privileges" : privileges});
	database.query(`SELECT * FROM recipes WHERE recipeID IN (SELECT recipeID FROM favorite WHERE userID=${userID})`).then(results => {
		favorites = results.map(recipe => recipe.recipeID)
		return database.query(`SELECT * FROM recipes NATURAL JOIN searchcategories WHERE recipeID in (${recipes.join(', ')}) ORDER BY recipeID`)
	}).then(results => {
		for (var i = 0; i < results.length; i++) {
			var recipe = {
				'id' : results[i].recipeID,
				'name' : results[i].name,
				'image' : results[i].image_url,
				'favorite' : (favorites.includes(results[i].recipeID)) ? true : false
			};
			recipe_list.push(recipe);
		}
		res.render('list_recipes', {"user" : userName , "recipes" : recipe_list, "privileges" : privileges});
	})
}




app.get('/home', function(req, res) {
	if (req.session.userID) {
		var recipe_list = [];
		database.query('SELECT * FROM recipes').then(results => {
			for (var i = 0; i < results.length; i++)
				recipe_list.push(results[i].recipeID)
			listRecipes(recipe_list, req, res)
			})
	} else {
		res.redirect('/');
	}

});

app.post('/auth', function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	if (username && password) {
		let query1 = util.format('SELECT * FROM users WHERE username = "%s" AND password = "%s"', username, password);
		let query2 = util.format('SELECT privileges FROM users U, admin A WHERE U.userID = A.userID AND U.username = "%s"', username);
		database.query(query1)
			.then(results => {
				if (results.length > 0) {
					req.session.username = results[0].username;
					req.session.userID = results[0].userID;
				}
				else {
					res.send("Incorrect username or password!");
					return Promise.reject("Incorrect username or password!");
				}
				return database.query(query2);
			})
			.then( privResults => {
				if (privResults.length > 0) {
					let privileges = privResults[0].privileges.split(',');
					for (let i = 0; i < privileges.length; i++) {
						privileges[i] = privileges[i].trim();
					}
					req.session.privileges = privileges;
				}
			})
			.then( () => {
				res.redirect('/');
			});
	}
	else {
		res.send("Please input both username and password.");
	}
});

app.get('/register', function (req, res) {
    res.render('register');

});


app.post('/register', function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	var email = req.body.email;
    var connection = getConnection();
    connection.connect();
    if (username === "" || password === "" || email === "") {
    	res.render('register', {"status": "Please fill in all fields"});
		return;
	}
    if (username.match(/^\w+/) === null) {
    	res.render('register', {"status":"Invalid username"});
    	return;
	}
    // password = md5(username + md5(password));
    connection.query('SELECT * FROM users WHERE username = ?', username, function(error, results, fields) {
    	var status;
    	if (results.length > 0) {
    		status = "User already exists.";
    		res.render('register', {"status" : status});
    	} 
    	else {
    		connection.query('INSERT INTO users (username, password, email) VALUES (?,?,?)', [username, password, email], function(error2, results2, fields2) {
    			if (error2) {
    				status = "User exists.";
    				console.log(error2);
    			}
    			else {
    				status = "Successfully registered!";
    			}
    			res.render('register', {"status" : status});
    		});
    	}
    });
});

app.get('/logout', function(req, res) {
	req.session.userID = false;
	res.redirect('/');
});



//TODO: ADD CHECK ON WHO CAN EDIT A RECIPE. ALSO CHECKOUT WTF GOING ON WITH INSTRUCTION/INGREDIENTS. SAME AT EDITRECIPE

app.get('/detail', function(req, res) {
	if (req.session.userID) {
		var userID = req.session.userID;
		var id = req.query.id;
		var s = req.query.status;
		var delStatus, editStatus;
		if(s === '1') { delStatus = 'You have no permission to delete this recipe' }
		if(s === '2') { editStatus = 'You have no permission to edit this recipe' }
		var userID = req.session.userID
		var connection = getConnection();
		connection.connect();
		connection.query('SELECT * FROM recipes WHERE recipeID = ?', [id],
            function(err, rows, fields) {

			if (err) { throw err;}
			else {
				// console.log(rows[0].ingredient);
				var details = {
					'name' : rows[0].recipeName,
					'ingredient' : rows[0].ingredient,
					'author' : rows[0].author,
					'instruction' : rows[0].instruction,
					'prepTime' : rows[0].prepTime,
					'cookTime' : rows[0].cookTime,
					'course' : rows[0].course,
					'servingSize' : rows[0].servingSize,
					'image' : rows[0].image_url
				};
				res.render('detail', {"details" : details, "userID" : userID,
					'recipeID': id, "delStatus": delStatus, "editStatus": editStatus});
			}

		});
		connection.end();
	} else {
		res.redirect('/');
	}
});

app.get('/favorite', function(req, res){
    if (req.session.userID) {
        var userID = req.session.userID;
        var id = req.query.id;
        var favorite = req.query.favorite
        // console.log(userID, id, favorite);
        var connection = getConnection();
        connection.connect();
        if(favorite) {
			connection.query('DELETE FROM favorite WHERE userID=? AND recipeID=?', [userID, id],
				function(err, rows, fields) {
					if (err){throw err;}
					else{
						console.log("check deleter", userID, id);
						res.redirect('/home');
					}
				});

        } else {
			connection.query('INSERT INTO favorite (userID, recipeID) VALUES (?,?)', [userID, id],
				function(err, rows, fields) {
					if (err){throw err;}
					else{
						console.log("check insert", userID, id);
						res.redirect('/home');
					}
				});
        }
        connection.end();
    } else {
    	res.redirect('/')
	}
})

app.get('/listFav', function(req, res){
	if (req.session.userID) {
		var userID = req.session.userID;
		var recipe_list = [];
		database.query(`SELECT * FROM recipes WHERE recipeID IN (SELECT recipeID FROM favorite WHERE userID=${userID})`).then(results => {
			for (var i = 0; i < results.length; i++)
				recipe_list.push(results[i].recipeID) 
			listRecipes(recipe_list, req, res)
			})
	} else {
		res.redirect('/');
	}
});
app.get('/add', function(req, res) {
	res.render('addRecipe');
});

app.post('/addRecipe', function (req, res) {
	if (!req.session.userID) {
		res.redirect('/');
		return
	}
	var userID = req.session.userID
	var ingredients = req.body.ingredients;
	var name = req.body.name;
	var instructions = req.body.instructions;
	var prepTime = req.body.prepTime;
	var cookTime = req.body.cookTime;
	var imageURL = req.body.imageURL;
	var servingSize = req.body.servingSize;
	var course = req.body.course;
	var vegetarian = (req.body.vegetarian) ? 1 : 0;
	var vegan = (req.body.vegan) ? 1 : 0;
	var recipeID
	if(name == "")
	{
		res.render('addRecipe', {"status": "Please fill required fields"});
		return
	}
	database.query('INSERT INTO recipes (author, ingredient, instruction, prepTime, cookTime, course, servingSize, image_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', [userID, ingredients, instructions, prepTime, cookTime, course, servingSize, imageURL])
			.then(results => {
				recipeID = results.insertId;
				return database.query('INSERT INTO own (userID, recipeID) VALUES (?, ?)', [userID, recipeID])
			})
			.then( () => {
				return database.query('INSERT INTO searchCategories (recipeID, name, vegan, vegetarian) VALUES (?, ?, ?, ?)', [recipeID, name, vegan, vegetarian])
			})
			.then( () => {
				res.render('addRecipe', {"status" : "Successfully add recipe"});
			})
});

app.get('/showMyRecipe', function (req, res) {
	if(req.session.userID) {
		var username = req.session.username;
		var userID = req.session.userID;
		var myRecipes=[];
		var connection = getConnection();
		connection.connect();
		connection.query('SELECT * FROM recipes NATURAL JOIN searchcategories WHERE recipeID IN (SELECT recipeID FROM own WHERE userID=?)',
			[userID], function(err, rows, fields) {
				if (err) {throw err;}
				else {
					for (var i = 0; i < rows.length; i++) {
						var recipe = {
							'id': rows[i].recipeID,
							'name': rows[i].name,
							'image': rows[i].image_url,
						};

						myRecipes.push(recipe);
					}
					res.render('showMyRecipe', {"user" : username , "myRecipes" : myRecipes});
				}

			})
	} else {
		res.redirect('/');
	}

});

app.post('/search', function(req, res){
	var searchParam = req.body.name
	var vegetarian = (req.body.vegetarian) ? 'AND vegetarian = 1' : '';
	var vegan = (req.body.vegan) ? 'AND vegan = 1' : '';
	var searchedRecipes = [];
	database.query(`SELECT * FROM searchcategories WHERE name LIKE '%${searchParam}%'${vegetarian}${vegan}`).then(results => {
		for (var i = 0; i < results.length; i++)
			searchedRecipes.push(results[i].recipeID) 
		listRecipes(searchedRecipes, req, res)
	});
});

app.get('/editRecipe', function(req, res){
    if (!req.session.userID) {
        res.render('/')
	}
	var id = req.query.id;
	database.query(`SELECT userID FROM own WHERE recipeID=${id}`)
		.then(results => {
			if (results.length === 0) {
				res.redirect(`/detail?id=${id}&status=2`);
			}
		});

	var status = (req.query.status) ? 'Sucessfully Edited' : undefined;
	database.query(`SELECT * FROM recipes NATURAL JOIN searchcategories WHERE recipeID = ${id}`).then(results => {
		res.render('editRecipe', {'recipeName': results[0].name, 'ingredient': results[0].ingredient, 'instruction': results[0].instruction,
			'course': results[0].course, 'prepTime': results[0].prepTime, 'cookTime': results[0].cookTime, 'servingSize': results[0].servingSize, 
			'imageURL': results[0].image_url, 'vegetarian': (results[0].vegetarian) ? 'checked': '', 'vegan': (results[0].vegan) ? 'checked': '', 'recipeID': id, 'status': status})
	});
});

app.post('/editRecipe', function (req, res) {
	if (!req.session.userID) {
		res.redirect('/');
		return
	}
	var id = req.body.recipeID
	var ingredients = (req.body.ingredients) ? `, ingredient='${req.body.ingredients}'`: ''
	var name = (req.body.name) ? `, name='${req.body.name}'`: ''
	var instructions = (req.body.instructions) ? `instruction='${req.body.instructions}'`: ''
	var instructions = (req.body.instructions) ? `, instruction='${req.body.instructions}'`: ''
	var prepTime = (req.body.prepTime) ? `, prepTime='${req.body.prepTime}'`: ''
	var cookTime = (req.body.cookTime) ? `, cookTime='${req.body.cookTime}'`: ''
	var imageURL = (req.body.imageURL) ? `, image_url='${req.body.imageURL}'`: ''
	var servingSize = (req.body.servingSize) ? `, servingSize='${req.body.servingSize}'`: ''
	var course = (req.body.course) ? `, course='${req.body.course}'`: ''
	var vegetarian = (req.body.vegetarian) ? 1 : 0;
	console.log(imageURL + "   buh  " + req.body.imageURL)
	var vegan = (req.body.vegan) ? 1 : 0;
	if(name == "")
	{
		res.render('addRecipe', {"status": "Please fill required fields"});
		return
	}
	database.query(`UPDATE recipes NATURAL JOIN searchcategories SET vegetarian=${vegetarian}, vegan=${vegan}${ingredients}${name}
		${instructions}${prepTime}${cookTime}${imageURL}${servingSize}${course} WHERE recipeID=${id}`)
			.then(results => {
				res.redirect(`/editRecipe?id=${id}&status=2`)
			});
});


function deleteRecipes(recipeID, table){
	var connection = getConnection();
	connection.connect();
	connection.query(`DELETE FROM ${table} WHERE recipeID=?`, [recipeID], function(error, results, fields) {
		if (error) {throw error;}
		else {console.log('deleted from', table); }
	});

}

app.get('/deleteRecipe', function (req, res) {
	if (req.session.userID) {
		console.log("test Delete");
		// var username = req.session.username;
		var userID = req.session.userID;
		var id = req.query.id;
		var connection = getConnection();
		connection.connect();
		connection.query('SELECT userID FROM own WHERE recipeID=?', [id], function(error, results, fields) {
			if (error) {throw error;}
			if (results.length > 0){
				if (results[0].userID === userID) {
					deleteRecipes(id, 'own');
					deleteRecipes(id, 'recipes');
					deleteRecipes(id, 'searchCategories');
					res.redirect('/');
				}
			} else {
				res.redirect(`/detail?id=${id}&status=1`);
			}
		});

	} else {
		res.redirect('/');
	}
});

app.listen(3000);
module.exports = app;