import dbconf from '.././knexfile'

const Knex = require('knex')(dbconf)
const Bookshelf = require('bookshelf')(Knex)

// Reusable database connection header
export {Bookshelf}
