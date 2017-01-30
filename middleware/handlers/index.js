var jsonApi = require('jsonapi-server')

module.exports = process.env.NODE_ENV === 'development' ? new jsonApi.MemoryHandler() : require('./relationaldb')
