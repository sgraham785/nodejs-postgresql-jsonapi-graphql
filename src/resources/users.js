import jsonApi from 'jsonapi-server'
import storeHandler from '../middleware/handlers/index'

jsonApi.define({
  resource: 'users',
  handlers: storeHandler,
  searchParams: {},
  attributes: {
    first_name: jsonApi.Joi.string().alphanum()
      .description('The persons first name')
      .example('John'),
    last_name: jsonApi.Joi.string().alphanum()
      .description('The persons last name')
      .example('Smith'),
    email: jsonApi.Joi.string().email().required()
      .description('The persons preferred contact email address')
      .example('john.smith@gmail.com'),
    code: jsonApi.Joi.string().alphanum()
      .description('Verification code sent to the users email')
      .example('87hjh9'),
    verified: jsonApi.Joi.boolean()
      .description('Is the user verified')
      .example('true'),
    created_at: jsonApi.Joi.date().timestamp()
      .description('Javascript Date.now() that is formatted')
      .example('1485413449348'),
    updated_at: jsonApi.Joi.date().timestamp()
      .description('Javascript Date.now() that is formatted')
      .example('1485413449348'),
    todos: jsonApi.Joi.belongsToMany({
      resource: 'todos',
      as: 'user'
    })
  },
  examples: [
    {
      type: 'users',
      id: 'ad3aa89e-9c5b-4ac9-a652-6670f9f27587',
      first_name: 'Sean',
      last_name: 'Graham',
      email: 'sgraham785@gmail.com',
      code: '7852hiso',
      verified: 'true',
      created_at: '1485413449348',
      updated_at: '1485413449348',
      todos: { type: 'todos', id: 'aab14844-97e7-401c-98c8-0bd5ec922d93' }
    }
  ]
})
