const express = require('express');
const mysql = require('mysql');
const app = express();
var path = require('path');

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

app.get('/', function(req, res){
	res.render('first_view');
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