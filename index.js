var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var neo4j = require('neo4j');
var db = new neo4j.GraphDatabase('http://neo4j:1@localhost:7474');


app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket){

  socket.on('chat message', function(msg){
    io.emit('chat message', msg);
  });

  socket.on('getUsers', function() {
    db.cypher({ query: 'MATCH (user:User) RETURN user' }, callback);
  })

});

http.listen(3000, function(){
  console.log('listening on *:3000');
});



function callback(err, results) {
  if (err) throw err;
  var result = results[1];
  if (!result) {
    console.log('No user found.');
    io.emit('users', 'No user found.');
  } else {
    var user = result['user'];
    console.log(user);
    io.emit('users', user);
  }
};