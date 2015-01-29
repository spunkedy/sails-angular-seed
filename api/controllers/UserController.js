/**
 * UserController
 *
 * @description :: Server-side logic for managing Users
 * @help        :: See http://links.sailsjs.org/docs/controllers
 */


module.exports = {
	
  session: function(req, res) {
    
    res.json({
      success: true
    });
  },


  //expose a method for angular to be able to see if we are logged in
  isLoggedIn: function(req,res){
    
    //TODO: make sure that only the clients with the right session get the broadcast
    //sails.sockets.broadcast("authNotification" , "authorized",{socketId: req.socket.id, user: req.user} );    
    
    res.json({sessionID: req.session.sessionID, roles: req.session.roles, user: req.user} );
    //res.json(req.isAuthenticated() ? {sessionID: req.sessionID, user: req.user} : 0);
  },
  //expose a method for angular to be able to see if we are logged in
  sayHi: function(req,res){
    sails.sockets.broadcast("authNotification" , "message", {message: "onLogin"} );  
    sails.sockets.broadcast("authNotification" , "message", {message: "hello3"} );    
    res.json({result:"sent"});
  },
  sendHello: function(req,res) {
  	//req.sessionID
  	sails.io.sockets.in('asdf').emit("eventName", {data:true});
  	//sails.sockets.broadcast.to("asdf").emit('loggedOut', {loggedOff: 'true'});
	
  	res.json({
  		sessionid: req.sessionID,
  		message: "sent"
  	})

  },
  register: function(req,res){

    //associate group
    Groups.findOrCreate({
      groupName: 'user'
    }, {
      groupName: 'user',
      description: 'Generic user'
    }).exec(function createFindCB(err, userGroup) {
      //Check password for equality
      var password = req.param('password');
      var confirmation = req.param('confirmation');
      //TODO: enfore better passsword enforcement
      if(!password){
        res.json({err: { message: "You must enter a password" }});
      } else if (password == confirmation){
        var userObj = {
          username: req.param('username'),
          email: req.param('email'),
          groups: [userGroup.id]
        };

        //Create user
        User.create(userObj, function userCreated(err, user) {
          if (err) {
            res.json({
              err: err
            });
          } else {
            //Associate passport ( password )
            //TODO: include other authentication mechanisms
            Passport.create({
              protocol: 'local',
              password: password,
              user: user.id
            }, function (err, passport) {
              if (err){
                User.destroy(user.id, function deleteCB(deleteErr){
                  sails.log(deleteErr);
                });
                res.json({err:err});
                console.log(err);              
              } else {
                User.publishCreate(user);
                res.json({success: true});
              }
            });
            
          }
        });
      } else {
        res.json({err: { message: "Passwords do not match" }});
      }

    });

  }
	
};