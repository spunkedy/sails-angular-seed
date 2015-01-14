//userUtils : utilities for User model
var generatePassword = require('password-generator');

module.exports = {
	createAdminIfNotExists: function () {

		Groups.findOrCreate({
			groupName: 'admin'
		}, {
			groupName: 'admin',
			description: 'Administrators'
		}).exec(function createFindCB(err, adminGroup) {

			User.findOrCreate({
				username: 'admin'
			}, {
				username: 'admin',
				email: 'admin@admin.com',
				groups: [adminGroup.id]
			}).exec(function createFindCB(err, user) {

				Passport.findOne({
					protocol: 'local',
					user: user.id
				}, function (err, passport) {

					if (!passport) {



						var password = generatePassword(12, false);
						Passport.create({
							protocol: 'local',
							password: password,
							user: user.id
						}, function (err, passport) {
							if (err)
								console.log(err);

							var fs = require('fs');
							console.info('-----Creation of adminIdentifiers.md------');
							var wstream = fs.createWriteStream('assets/adminIdentifiers.md');
							wstream.write('#Admin access : ' + '\n\n');
							wstream.write('- login : ' + user.username + '\n');
							wstream.write('- email : ' + user.email + '\n');
							wstream.write('- password : ' + password + '\n\n');
							wstream.write('#info\n');
							wstream.write('File generated during bootstrap.js of sails\n');
							wstream.end();

							console.info('-----Passport Admin Creation------');
							console.info('----- ' + user.username);
							console.info('----- ' + user.email);
							console.info('----- ' + password);
						});


					} else {
						console.info('-----An admin user was found. Check your adminIdentifiers.md------');
					}
				});

			});

		});

	}
}