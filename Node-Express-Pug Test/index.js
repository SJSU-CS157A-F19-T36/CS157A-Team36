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
	password: 'Something0clever.',
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

app.get('/home', function(req, res) {
    if (req.session.loggedin) {
		var username = req.session.loggedin;
		var recipe_list = [];
		var connection = getConnection();
		connection.connect();
		connection.query('SELECT * FROM recipes', null, function (err, results, fields) {
			if (err) { throw err; }
			else {
				for (var i = 0; i < results.length; i++) {
					var recipe = {
						'name' : results[i].name,
						'image' : results[i].image_url
					};
					recipe_list.push(recipe);
				}

				res.render('first_view', {"user" : username , "recipes" : recipe_list, "privileges" : req.session.privileges});
			}
		});
    } else {
		res.redirect('/');
	}

});

/*
app.post('/auth', function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	var connection = getConnection();
	connection.connect();
	if (username && password) {
		connection.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], function(error, results, fields) {
			if (results.length > 0) {
				req.session.loggedin = username;

				connection.query('SELECT privileges FROM users U, admin A WHERE U.userID = A.userID AND U.username = ?',
						[username], function(privErr, privResults, privFields) {
					if (privErr) {throw privErr};
					if (privResults.length > 0) {
						let privileges = privResults[0].privileges.split(',');
						for (let i = 0; i < privileges.length; i++) {
							privileges[i] = privileges[i].trim();
						}
						req.session.privileges = privileges;
						console.log("This is inside the query.");
						console.log(privileges);
						res.redirect('/');
					}
				});
			} else {
				res.send('Incorrect Username and/or Password!');
			}
			res.end();
		});
	} else {
		res.send('Please enter Username and Password!');
		res.end();
	}
});
*/

app.post('/auth', function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	if (username && password) {
		let query1 = util.format('SELECT * FROM users WHERE username = "%s" AND password = "%s"', username, password);
		let query2 = util.format('SELECT privileges FROM users U, admin A WHERE U.userID = A.userID AND U.username = "%s"', username);
		database.query(query1)
			.then(results => {
				if (results.length > 0) {
					req.session.loggedin = results[0].username;
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
	req.session.loggedin = false;
	res.redirect('/');
});



app.get('/detail', function(req, res) {
	if (req.session.loggedin) {
		var username = req.session.loggedin;
		var name = req.query.name;
		var connection = getConnection();
		connection.connect();
		connection.query('SELECT * FROM recipes WHERE name = ?', [name], function(err, rows, fields) {

			if (err) { throw err;}
			else {
				console.log(rows[0].name);
				var details = {
					'name' : rows[0].name,
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
		res.redirect('/');
	}

});



// app.get('/demo', function(req, res) {
// 	var list = [];
//
// 	var connection = getConnection();
// 	connection.connect();
//
// 	connection.query('SELECT * FROM recipes', function(err, rows, fields) {
// 		if (err) { throw err; }
// 		else {
// 			for (var i = 0; i < rows.length; i++) {
// 				var person = {
// 					'id' : rows[i].recipeID,
// 					'name' : rows[i].image_url
// 					// 'pw' : rows[i].password
// 				};
// 				list.push(person);
// 			}
// 			res.render('demo', {"list" : list});
// 		}
// 	});
// 	connection.end();
// });

app.listen(3000);
module.exports = app;