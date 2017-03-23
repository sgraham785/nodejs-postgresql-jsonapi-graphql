var Umzug = require('umzug')

const storageOptions = (NODE_ENV = 'development') ? {
    // The path to the json storage.
    // Defaults to process.cwd() + '/umzug.json';
  path: process.cwd() + '/db/sequelize-meta.json'
} : {
    // The configured instance of Sequelize.
    // Optional if `model` is passed.
  sequelize: instance,

    // The to be used Sequelize model.
    // Must have column name matching `columnName` option
    // Optional of `sequelize` is passed.
  model: model,

    // The name of the to be used model.
    // Defaults to 'SequelizeMeta'
  modelName: 'SequelizeMeta',

    // The name of table to create if `model` option is not supplied
    // Defaults to `modelName`
  tableName: 'migrations',

    // The name of table column holding migration name.
    // Defaults to 'name'.
  columnName: 'name',

    // The type of the column holding migration name.
    // Defaults to `Sequelize.STRING`
  columnType: new Sequelize.STRING(100)
}

const umzug = new Umzug({
  // The storage.
  // Possible values: 'json', 'sequelize', an argument for `require()`, including absolute paths
  storage: 'json',

  // The options for the storage.
  // Check the available storages for further details.
  storageOptions: storageOptions,

  // The logging function.
  // A function that gets executed everytime migrations start and have ended.
  logging: false,

  // The name of the positive method in migrations.
  upName: 'up',

  // The name of the negative method in migrations.
  downName: 'down',

  migrations: {
    // The params that gets passed to the migrations.
    // Might be an array or a synchronous function which returns an array.
    params: [],

    // The path to the migrations directory.
    path: './database/migrations',

    // The pattern that determines whether or not a file is a migration.
    pattern: /\.js$/,

    // A function that receives and returns the to be executed function.
    // This can be used to modify the function.
    wrap: function (fun) { return fun }
  }
})

umzug.up().then(function (migrations) {
  console.log(migrations)
})

/**
// TODO: cleanup
console.log('Running migrations...')
knex.migrate.latest(dbconf).then(() => {
  console.log('Running seeders...')
  return knex.seed.run(dbconf)
}).then(() => {
  console.log('Done...')
  process.exit(0)
})
*/
