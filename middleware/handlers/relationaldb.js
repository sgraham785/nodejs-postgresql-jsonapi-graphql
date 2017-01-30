require('dotenv').config()
import RelationalDbStore from 'jsonapi-store-relationaldb'
import {connection} from '../../configurations/database'

// console.log(connection)

export default new RelationalDbStore({
  dialect: 'postgres',
  connection,
  logging: false
})
