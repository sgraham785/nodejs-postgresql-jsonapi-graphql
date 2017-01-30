require('dotenv').config()
var RelationalDbStore = require('jsonapi-store-relationaldb')
var connection = require('../../configurations/database').connection

// console.log(connection)

module.exports = new RelationalDbStore({
  dialect: 'postgres',
  connection,
  logging: false
})
