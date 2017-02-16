import jsonApi from 'jsonapi-server'
export default process.env.NODE_ENV === 'development' ? new jsonApi.MemoryHandler() : require('./relationaldb')
