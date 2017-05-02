// MUST BE ES5
require('dotenv').config()

module.exports = {
  url: process.env.DB_URL,
  schemas: process.env.DB_SCHEMAS, // Comma-separated case-sensitive
  table: 'migrations_metadata',
  locations: 'filesystem:database/seeds',
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  sqlMigrationSuffix: '.sql'
}
