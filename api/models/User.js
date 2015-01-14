var User = {
  // Enforce model schema in the case of schemaless databases
  schema: true,

  attributes: {
    groups: {
		collection: 'groups',
		via: 'members',
    required: true
	},
	username  : { type: 'string', unique: true, required: true },
  email     : { type: 'email',  unique: true, required: true },

  passports : { collection: 'Passport', via: 'user' }
	// Groups
	
  }
};

module.exports = User;
