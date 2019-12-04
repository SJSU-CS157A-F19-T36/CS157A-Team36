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
	if (req.session.loggedin) {
		res.redirect('/home');
	} else {
		res.render('login');
	}
});

//
// app.get('/home', function(req, res) {
//     if (req.session.loggedin) {
// 		var username = req.session.loggedin;
// 		var recipe_list = [];
// 		var fav = false;
// 		let query1= util.format('SELECT * FROM recipes WHERE recipeID=(SELECT recipeID FROM favorite WHERE username="%s")',
// 			username);
// 		let query2 = util.format('SELECT * FROM recipes WHERE recipeID<>(SELECT recipeID FROM favorite WHERE username="%s")',
// 			username);
// 		database.query(query1)
// 			.then((fav_results)=>{
// 				for (var i = 0; i < fav_results.length; i++) {
// 					var recipe = {
// 						'id' : fav_results[i].recipeID,
// 						'name' : fav_results[i].recipeName,
// 						'image' : fav_results[i].image_url,
// 						'favorite' : true,
// 					};
// 					recipe_list.push(recipe);
// 				}
// 				return database.query(query2);
// 		})
// 			.then((results)=>{
// 				for (var i = 0; i < results.length; i++) {
// 					var recipe = {
// 						'id' : results[i].recipeID,
// 						'name' : results[i].recipeName,
// 						'image' : results[i].image_url,
// 						'favorite' : false,
// 					};
// 					recipe_list.push(recipe);
// 				}
// 				console.log("list2:",recipe_list);
// 				res.render('first_view', {"user" : username , "recipes" : recipe_list});
// 			});
//
//     } else {
// 		res.redirect('/');
// 	}
// });
app.get('/home', function(req, res) {
	if (req.session.loggedin) {
		var username = req.session.loggedin;
		var recipe_list = [];
		var fav = false;
		var connection = getConnection();
		connection.connect();
		connection.query('SELECT * FROM recipes WHERE recipeID IN (SELECT recipeID FROM favorite WHERE username=?)',
			[username], function (err, results, fields) {
				if (err) { throw err; }
				else {
					for (var i = 0; i < results.length; i++) {
						var recipe = {
							'id' : results[i].recipeID,
							'name' : results[i].recipeName,
							'image' : results[i].image_url,
							'favorite' : true,
						};
						recipe_list.push(recipe);
					}

				}

			});
		connection.query('SELECT * FROM recipes WHERE recipeID NOT IN (SELECT recipeID FROM favorite WHERE username=?)',
			[username], function (err, results, fields) {
				if (err) { throw err; }
				else {
					for (var i = 0; i < results.length; i++) {
						var recipe = {
							'id' : results[i].recipeID,
							'name' : results[i].recipeName,
							'image' : results[i].image_url,
							'favorite' : false,
						};
						recipe_list.push(recipe);
					}

				}
				console.log("list2:",recipe_list);
				res.render('first_view', {"user" : username , "recipes" : recipe_list});
			});

		connection.end();
	} else {
		res.redirect('/');
	}

});

app.post('/auth', function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	if (username && password) {
		let query1 = util.format('SELECT * FROM users WHERE username = "%s" AND password = "%s"', username, password);
		database.query(query1)
			.then(results => {
				if (results.length > 0) {
					req.session.loggedin = results[0].username;
				} else {
					res.send("Incorrect username or password!");
					return Promise.reject("Incorrect username or password!");
				}
				res.redirect('/');
			});
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
    if (username.match(/^[a-zA-Z0-9_]+$/) === null) {
    	res.render('register', {"status":"Invalid username"});
    	return;
	}
    // password = md5(username + md5(password));
	connection.query('INSERT INTO users VALUES (?,?,?)', [username, password, email],
        function(error, results, fields) {
        var status;
		if (error) {status = "user exists"}
        else {
        	status = "successfully register";
		}
		res.render('register', {"status" : status});
        // res.end();
	});
    connection.end();

});

app.get('/logout', function(req, res) {
	req.session.loggedin = false;
	res.redirect('/');
});



app.get('/detail', function(req, res) {
	if (req.session.loggedin) {
		var username = req.session.loggedin;
		var id = req.query.id;
		var connection = getConnection();
		connection.connect();
		connection.query('SELECT * FROM recipes WHERE recipeID = ?', [id],
            function(err, rows, fields) {

			if (err) { throw err;}
			else {
				console.log(rows[0].recipeID);
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
				res.render('detail', {"details" : details});
			}

		});
		connection.end();
	} else {
		res.redirect('/', {status:"OK"});
	}

});

app.get('/favorite', function(req, res){
    if (req.session.loggedin) {
        var username = req.session.loggedin;
        var id = req.query.id;
        var favorite = req.query.favorite
        console.log(username, id, favorite);
        var connection = getConnection();
        connection.connect();
        if(favorite) {
			connection.query('DELETE FROM favorite WHERE username=? AND recipeID=?', [username , id],
				function(err, rows, fields) {
					if (err){throw err;}
					else{
						console.log("check deleter", username, id);
						res.redirect('/home');
					}
				});

        } else {
			connection.query('INSERT INTO favorite (username, recipeID) VALUES (?,?)', [username , id],
				function(err, rows, fields) {
					if (err){throw err;}
					else{
						console.log("check insert", username, id);
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
	if (req.session.loggedin) {
		var username = req.session.loggedin;
		var favs=[];
		var connection = getConnection();
		connection.connect();
		connection.query('SELECT * FROM recipes WHERE recipeID IN (SELECT recipeID FROM favorite WHERE username=?)',
			[username], function(err, rows, fields) {
			if (err) {throw err;}
			else {
				for (var i = 0; i < rows.length; i++) {
					var fav = {
						'id': rows[i].recipeID,
						'name': rows[i].recipeName,
						'image': rows[i].image_url,
						'favorite': true,
					};
					favs.push(fav);
				}
				res.render('list_favs', {"user" : username , "favs" : favs});
			}

		})

	} else {
		res.redirect('/')
	}
});
app.get('/add', function(req, res) {
	res.render('addRecipe');
});

app.post('/addRecipe', function (req, res) {
	if (req.session.loggedin) {
		var username = req.session.loggedin;
		var name = req.body.name;
		var ingredient = req.body.ingredient;
		var img = req.body.img;
		var instruction = req.body.instruction;
		var course = req.body.course;
		var ptime = req.body.ptime;
		var ctime = req.body.ctime;
		var size = req.body.size;
		var sql = "recipeName, ingredient, author, instruction, prepTime, cookTime, servingSize, image_url, course";
		var connection = getConnection();
		connection.connect();
		connection.query('INSERT INTO recipes (recipeName) VALUES (?)',
			[name],
			function(error, results, fields) {
				if (error) {throw error;}
				else {
					res.render('addRecipe', {"status" : "Successfully add recipe"});
				}

			});
		connection.end();
	} else {
		res.redirect('/');
	}


});



app.listen(3000);
module.exports = app;