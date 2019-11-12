const express = require('express');
const mysql = require('mysql');
const app = express();
const session = require('express-session');
const bodyParser = require('body-parser');
const path = require('path');


function getConnection() {
	return mysql.createConnection({
		host	: 'localhost',
		user	: 'root',
		password: 'root',
		database: 'cs157a'
	});
}

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
						'name' : results[i].recipeID,
						'image' : results[i].image_url
					};
					recipe_list.push(recipe);
				}
				console.log(recipe_list[0].name);
				console.log(recipe_list[0].image);
				res.render('first_view', {"user" : username , "recipes" : recipe_list});

			}
		})
		connection.end();
    } else {
		res.redirect('/');
	}

})
app.post('/auth', function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	var connection = getConnection();
	connection.connect();
	if (username && password) {
		connection.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], function(error, results, fields) {
			if (results.length > 0) {
				req.session.loggedin = username;
				// req.session.username = username;
				res.redirect('/');
			} else {
				res.send('Incorrect Username and/or Password!');
			}
			res.end();
		});
	} else {
		res.send('Please enter Username and Password!');
		res.end();
	}
	connection.end();
});

app.get('/register', function (req, res) {
    res.render('register');

});


app.post('/register', function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	var email = req.body.email;
	// console.log(email);
    var connection = getConnection();
    connection.connect();
    if (username === "" || password == "") {
    	res.send('Please fill in all fields');
		res.end();
	}
    if (username.match(/^[a-z0-9_]+$/) === null) {
    	res.send('Invalid username');
    	res.end();
	}
    // password = md5(username + md5(password));
	connection.query('INSERT INTO users VALUES (?,?,?,?)', [username, username, password, email], function(error, results, fields) {
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
})


/* NEED DETAIL PAGE
app.get('/detail', function(req, res) {
	var name = req.query.name;
	console.log(name);
	var connection = getConnection();
	connection.connect();
	connection.query('SELECT * FROM recipes', function(err, rows, fields) {

	});
});

**/

app.get('/demo', function(req, res) {
	var list = [];

	var connection = getConnection();
	connection.connect();

	connection.query('SELECT * FROM recipes', function(err, rows, fields) {
		if (err) { throw err; }
		else {
			for (var i = 0; i < rows.length; i++) {
				var person = {
					'id' : rows[i].recipeID,
					'name' : rows[i].image_url
					// 'pw' : rows[i].password
				};
				list.push(person);
			}
			res.render('demo', {"list" : list});
		}
	});
	connection.end();
});

app.listen(3000);
module.exports = app;