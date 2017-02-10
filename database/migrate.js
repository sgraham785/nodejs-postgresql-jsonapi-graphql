import dbconf from '.././knexfile'
const knex = require('knex')(dbconf)

console.log('Running migrations...')
knex.migrate.latest(dbconf).then(() => {
  console.log('Running seeders...')
  return knex.seed.run(dbconf)
}).then(() => {
  console.log('Done...')
  process.exit(0)
})
