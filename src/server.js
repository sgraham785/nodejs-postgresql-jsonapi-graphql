const server = module.exports = { }

require('dotenv').config()
require('./middleware/logger')
import fs from 'fs'
import path from 'path'
import jsonApi from 'jsonapi-server'
import jwt from './middleware/jsonwebtoken'

const protocol = process.env.SERVER_PROTOCOL || 'http'
const hostname = process.env.SERVER_HOST || 'localhost'
const port = process.env.SERVER_PORT || '8003'
const env = process.env.NODE_ENV || 'development'
const privateKey = fs.readFileSync(path.join(__dirname, '../sslcerts/development.server.key'), 'utf8')
const certificate = fs.readFileSync(path.join(__dirname, '../sslcerts/development.server.crt'), 'utf8')

jsonApi.setConfig({
  graphiql: true,
  protocol,
  hostname,
  port,
  base: 'v1',
  meta (request) {
    if (env === 'development') return {token: 'test'}
  },
  tls: {
    cert: certificate,
    key: privateKey
  },
  swagger: {
    title: 'Auth Server', // Title (required)
    version: '1.0.0', // Version (required)
    description: 'This is the API description block that shows up in the swagger.json',
    contact: {
      name: '',
      email: '',
      url: ''
    },
    license: {
      name: 'MIT',
      url: 'http://opensource.org/licenses/MIT'
    }
  }
})

// Load all resources
fs.readdirSync(path.join(__dirname, '/resources')).filter(filename => /^[a-z].*\.js$/.test(filename)).map(filename => path.join(__dirname, '/resources/', filename)).forEach(require)

// This function will be invoked on every request, as soon as the HTTP
// request has been parsed into a "request" object.
jsonApi.authenticate((request, callback) => {
  // Allow health check without validation
  if (request.route.path === 'health') return callback()

// Sign a JWT for development
  if (env === 'development') {
    request.headers.authorization = jwt.sign()
  }

// If you callback with an error, the client will receive a HTTP 401 Unauthorised
  if (!request.headers.authorization) return callback('You shall not pass!')

// Verify authorization header is valid
  if (!jwt.verify(request.headers.authorization)) return callback('BAD REQUEST')
// If you callback with no error, the request will continue onwards
  return callback()
})

jsonApi.onUncaughtException((request, error) => {
  const errorDetails = error.stack.split('\n')
  console.error(JSON.stringify({
    type: 'UncaughtException',
    request,
    error: errorDetails.shift(),
    stack: errorDetails
  }))
})

jsonApi.metrics.on('data', data => {
  console.info(JSON.stringify({
    type: 'Metrics',
    data
  }))
})

// If we're using the example server for the test suite,
// wait for the tests to call .start();
// noinspection JSUnresolvedVariable
if (typeof describe === 'undefined') {
  jsonApi.start()
}
server.start = jsonApi.start
server.close = jsonApi.close
server.getExpressServer = jsonApi.getExpressServer
console.log('Server running on, %s:%d. NODE_ENV = %s', hostname, port, env)
