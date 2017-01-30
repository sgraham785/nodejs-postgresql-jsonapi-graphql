var jsonApi = require('jsonapi-server')

jsonApi.define({
  resource: 'health',
  handlers: new jsonApi.MemoryHandler(),
  searchParams: {},
  attributes: {
    text: jsonApi.Joi.string()
  },
  examples: [
    {
      type: 'health',
      id: 'OK',
      text: 'Still here!'
    }
  ]
})
