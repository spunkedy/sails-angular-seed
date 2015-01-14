#!/usr/bin/env node

// We need this to build our post string
var querystring = require('querystring');
var http = require('http');
var fs = require('fs');


function PostCode(codestring) {
  // Build the post string from an object
  var user = {
      'username' : 'user' + process.argv[2],
      'email': 'u' + process.argv[2] + '@u.com',
      'password': 'asdfasdf',
      'confirmation': 'asdfasdf',
  };
  var userString = JSON.stringify(user);

  var headers = {
	  'Content-Type': 'application/json',
	  'Content-Length': userString.length
	};

  // An object of options to indicate where to post to
  var post_options = {
      host: 'localhost',
      port: '1337',
      path: '/user/register',
      method: 'POST',
      headers: headers
  };

  // Set up the request
  var post_req = http.request(post_options, function(res) {
      res.setEncoding('utf8');
      res.on('data', function (chunk) {
          console.log('Response: ' + chunk);
      });
  });

  // post the data
  post_req.write(userString);
  post_req.end();

}

PostCode();
console.log('hello world ' + process.argv[2]);