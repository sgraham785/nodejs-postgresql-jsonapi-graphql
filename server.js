var server = module.exports = { }

require('dotenv').config()
require('./middleware/logger')
var fs = require('fs')
var path = require('path')
var jsonApi = require('jsonapi-server')
var jwt = require('./middleware/jsonwebtoken')

var protocol = process.env.SERVER_PROTOCOL || 'http'
var hostname = process.env.SERVER_HOST || 'localhost'
var port = process.env.SERVER_PORT || '8443'
var env = process.env.NODE_ENV || 'development'
var privateKey = fs.readFileSync('sslcert/server.key', 'utf8')
var certificate = fs.readFileSync('sslcert/server.crt', 'utf8')

jsonApi.setConfig({
  graphiql: true,
  protocol: protocol,
  hostname: hostname,
  port: port,
  base: 'v1',
  meta: function (request) {
    if (env === 'development') return {token: 'test'}
  },
  tls: {
    cert: certificate,
    key: privateKey
  },
  swagger: {
    title: 'Todo API', // Title (required)
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
fs.readdirSync(path.join(__dirname, '/resources')).filter(function (filename) {
  return /^[a-z].*\.js$/.test(filename)
}).map(function (filename) {
  return path.join(__dirname, '/resources/', filename)
}).forEach(require)

// This function will be invoked on every request, as soon as the HTTP
// request has been parsed into a "request" object.
jsonApi.authenticate(function (request, callback) {

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

jsonApi.onUncaughtException(function (request, error) {
  var errorDetails = error.stack.split('\n')
  console.error(JSON.stringify({
    type: 'UncaughtException',
    request: request,
    error: errorDetails.shift(),
    stack: errorDetails
  }))
})

jsonApi.metrics.on('data', function (data) {
  console.info(JSON.stringify({
    type: 'Metrics',
    data: data
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
