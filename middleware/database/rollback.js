import dbConfig from '.././knexfile'
const knex = require('knex')(dbConfig)

console.log('Running rollback...')
knex.migrate.rollback(dbConfig).then(() => {
  console.log('Done...')
  process.exit(0)
})
