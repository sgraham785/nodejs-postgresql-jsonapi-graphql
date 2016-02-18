var BaseModel = require('../../classes/base/model');

var instanceProps = {
  tableName: 'users',
  hasTimestamps: true,
  todos: function () {
      return this.hasMany(require('../todos/model'));
  }
};

var classProps = {
  typeName: 'users',
  filters: {
    id: function (qb, value) {
      return qb.whereIn('id', value);
    },
    name: function (qb, value) {
      return qb.whereIn('first_name', value);
    },
    email: function (qb, value) {
      return qb.whereIn('email', value);
    },
    verified: function (qb, value) {
      return qb.whereIn('verified', value);
    }
  },
  relations: []
};

module.exports = BaseModel.extend(instanceProps, classProps);
