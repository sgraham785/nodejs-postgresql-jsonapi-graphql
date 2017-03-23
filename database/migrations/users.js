const TABLE = 'users'

module.exports = {

  up: function (migration, DataTypes) {
    return migration.createTable(TABLE, {

      id: {
        type: DataTypes.BIGINT,
        primaryKey: true,
        autoIncrement: true
      },

      first_name: {
        type: DataTypes.STRING,
        allowNull: false
      },

      last_name: {
        type: DataTypes.STRING,
        allowNull: false
      },

      email: {
        type: DataTypes.STRING,
        allowNull: false
      },

      password: {
        type: DataTypes.STRING,
        allowNull: false
      },

      code: {
        type: DataTypes.STRING,
        allowNull: false
      },

      verified: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false
      },

      updatedAt: {
        type: DataTypes.DATE
      },

      createdAt: {
        type: DataTypes.DATE
      }

    }).then(function () {
      return migration.addIndex(TABLE, ['id'], ['email'], {indexName: 'users_email_uk', indicesType: 'UNIQUE'})
    })
  },

  down: function (migration, DataTypes) {
    return migration.dropTable(TABLE)
  }

}
