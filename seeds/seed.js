import fakerDatabase from './data'

export default function (knex, Promise) {
  const tables = [
    'users',
    'todos'
  ]
  return Promise.each(tables, table =>
    Promise.each(fakerDatabase[ table ], record =>
      knex(table).insert(record)))
}
