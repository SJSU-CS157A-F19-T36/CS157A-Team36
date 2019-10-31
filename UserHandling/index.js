const express = require('express');
const mysql = require('mysql');
const app = express();
const bodyParser = require('body-parser');
// TODO: figure out this guy
//const expressValidator = require('express-validator');

function getConnection() {
	return mysql.createConnection({
		host	: 'localhost',
		user	: 'root',
		password: 'Something0clever.',
		database: 'cs157a'
	});
}

app.set('view engine', 'pug');
app.set('views', './views');

// for parsing application/json
app.use(bodyParser.json()); 

// for parsing application/xwww-
app.use(bodyParser.urlencoded({ extended: true })); 
//form-urlencoded

// TODO: figure out this guy
//app.use(expressValidator());

app.get('/', function(req, res){
	res.send("Try going to localhost:3000/launchpad instead.");
});

app.get('/launchpad', function(req, res) {
	res.render('launchpad');
})

app.post('/launchpad', function(req, res) {
	console.log('Submitted.');
	return;
})

app.get('/register', function(req, res) {
	res.render('register');
})

app.post('/register', function(req, res) {
	const email = req.body.email;
	const username = req.body.username;
	const password = req.body.password;
	const password_check = req.body.password_check;

	console.log("Success?");

// TODO: figure out this block. checkBody doesn't exist without express-validator, but it's not working
/*
	req.checkBody('email', 'Email is required.').notEmpty();
	req.checkBody('email', 'Email is not valid.').isEmail();
	req.checkBody('username', 'Username is required.').notEmpty();
	req.checkBody('password', 'Password is required.').notEmpty();
	req.checkBody('password_check', 'Passwords do not match.').equals(req.body.password);

	let errors = req.validationErrors();

	if(errors) {
		res.render('register', {
			errors:errors
		});
	} else {
		console.log("Success!");
	}
	*/
})

app.listen(3000);