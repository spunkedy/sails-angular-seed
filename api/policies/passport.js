/**
 * Passport Middleware
 *
 * Policy for Sails that initializes Passport.js and as well as its built-in
 * session support.
 *
 * In a typical web application, the credentials used to authenticate a user
 * will only be transmitted during the login request. If authentication
 * succeeds, a session will be established and maintained via a cookie set in
 * the user's browser.
 *
 * Each subsequent request will not contain credentials, but rather the unique
 * cookie that identifies the session. In order to support login sessions,
 * Passport will serialize and deserialize user instances to and from the
 * session.
 *
 * For more information on the Passport.js middleware, check out:
 * http://passportjs.org/guide/configure/
 *
 * @param {Object}   req
 * @param {Object}   res
 * @param {Function} next
 */
module.exports = function (req, res, next) {

    
	if(req.isSocket) {
        //Associate the session ID to the socket session for session specific messages ( login / logout )
        if(req.session){
            var handshake = req.socket.manager.handshaken[req.socket.id];
            if (handshake) {
                req.session.sessionID = handshake.sessionID;
            }
        }
        if(req.session &&
            req.session.passport &&
            req.session.passport.user) {
            // Initialize Passport
            passport.initialize()(req, res, function () {
                // Use the built-in sessions
                passport.session()(req, res, function () {
                    // Make the user available throughout the frontend
                    res.locals.user = req.user;

                    var user = req.user;
                    var userId = req.session.userId;

                    
                    if (user) {
                        req.session.roles = [];
                        req.session.isAdmin = false;
                        User.findOne({
                            id: user.id
                        }).populate('groups').exec(function (err, user) {
                            var isInAdminGroup = false;
                            req.session.roles = user.groups;
                            for (var i = 0; i < user.groups.length; i++) {
                                if (user.groups[i].groupName == "admin") {
                                    isInAdminGroup = true;
                                    req.session.isAdmin = true;

                                }
                            }
                            if (isInAdminGroup)
                                res.locals.isAdmin = true;
                            else
                                res.locals.isAdmin = false;
                            req.session.userId = user.id;
                            next();
                        });
                    } else {
                        if (!user)
                            req.session.isAdmin = false;
                        next();
                    }
                    //if (req.user && req.user.username == 'admin') req.session.isAdmin == true;
                });
            });

            sails.log("session object");
            sails.log(passport.session);
            //Or this if you dont care about deserializing the user:
            //req.user = req.session.passport.user;
            //return next();

        }
        else{
            res.json(401);
        }


    }
    else if (req.isAuthenticated()) {
        return next();
    }
    else{
        // User is not allowed
        // (default res.forbidden() behavior can be overridden in `config/403.js`)
        return res.redirect('/login');
    }
};
