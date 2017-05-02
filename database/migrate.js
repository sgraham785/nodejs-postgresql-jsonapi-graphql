// MUST BE ES5
require('dotenv').config({ path: '.env.development' })

// console.log(process.env)
module.exports = {
  url: 'jdbc:postgresql://0.0.0.0:5432', // process.env.DB_URL,
  schemas: 'todos',
  table: 'migrations_metadata',
  locations: 'filesystem:migrations',
  user: 'postgres',
  password: 'postgres',
  sqlMigrationSuffix: '.sql'
}
