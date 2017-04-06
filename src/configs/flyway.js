require('dotenv').config()

export default {
  url: `jdbc:postgresql://${process.env.DB_HOST}:${process.env.DB_PORT}/${process.env.DB_NAME}`,
  schemas: 'public',
  table: 'migrations_metadata',
  locations: 'filesystem:database/migrations',
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  sqlMigrationSuffix: '.sql'
}
