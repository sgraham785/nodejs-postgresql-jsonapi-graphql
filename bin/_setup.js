require('babel-register')
const path = require('path')
const forever = require('forever-monitor')
// TODO: fix logger to file
const logger = require('../src/middleware/logger')

// use forever to start a script
function start (file) {
  let options = {}
  if (process.env.NODE_ENV === 'development') {
    options = {
      'command': 'babel-node',
      'watch': true,
      'watchDirectory': path.normalize(path.join(__dirname, '/..'))
    }
  }

  let child = new (forever.Monitor)(path.join(__dirname, '/', file), options)

  child.on('restart', function () {
    process.env.NODE_ENV === 'development'
      ? console.warn('Forever restarting script file change')
      : console.error('Forever restarting script for ' + child.times + ' time')
  })

  child.start()
}

module.exports = {
  start: start
}
