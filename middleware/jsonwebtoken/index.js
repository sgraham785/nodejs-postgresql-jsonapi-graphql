var jwt = module.exports = { }

var fs = require('fs')
var path = require('path')
var jsonwebtoken = require('jsonwebtoken')
var privateKey = fs.readFileSync(path.join(__dirname, './pem/jwt.key'), 'utf8')
var certificate = fs.readFileSync(path.join(__dirname, './pem/jwt.crt'), 'utf8')

jwt.verify = function (token) {
  return jsonwebtoken.verify(token, certificate)
}
jwt.sign = function (data) {
  if (!data) data = {id: 'test'}
  return jsonwebtoken.sign({ data: data }, privateKey, { algorithm: 'RS256', expiresIn: '1h' })
}
