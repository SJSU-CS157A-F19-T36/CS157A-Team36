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
    cookie: {
        maxAge: 60 * 1000 * 30
    },
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
        res.render('first_view');
        return;
    }
    res.render('/');
})
app.post('/auth', function(req, res){
	var username = req.body.username;
	var password = req.body.password;
	var connection = getConnection();
	connection.connect();
	if (username && password) {
		connection.query('SELECT * FROM users WHERE username = ? AND password = ?', [username, password], function(error, results, fields) {
			if (results.length > 0) {
				req.session.loggedin = true;
				req.session.username = username;
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


app.get('/demo', function(req, res) {
	var list = [];

	var connection = getConnection();
	connection.connect();

	connection.query('select * from users', function(err, rows, fields) {
		if (err) { throw err; }
		else {
			for (var i = 0; i < rows.length; i++) {
				var person = {
					'id' : rows[i].userID,
					'name' : rows[i].username,
					'pw' : rows[i].password
				}
				list.push(person);
			}
			res.render('demo', {"list" : list});
		}
	})
	connection.end();
})

app.listen(3000);
module.exports = app;