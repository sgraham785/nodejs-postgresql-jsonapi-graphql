import jsonApi from 'jsonapi-server'
import storeHandler from '../middleware/handlers/index'

jsonApi.define({
  resource: 'todos',
  handlers: storeHandler,
  searchParams: {},
  attributes: {
    text: jsonApi.Joi.string().required(),
    complete: jsonApi.Joi.string().alphanum(),
    created_at: jsonApi.Joi.date().timestamp()
      .description('Javascript Date.now() that is formatted')
      .example('1485413449348'),
    updated_at: jsonApi.Joi.date().timestamp()
      .description('Javascript Date.now() that is formatted')
      .example('1485413449348'),
    user: jsonApi.Joi.belongsToOne({
      resource: 'users',
      as: 'todos'
    }).description('The person who wrote the todo')
  },
  examples: [
    {
      type: 'todos',
      id: 'aab14844-97e7-401c-98c8-0bd5ec922d93',
      text: 'This is a test todo',
      complete: 'false',
      created_at: '1485413449348',
      updated_at: '1485413449348',
      user: { type: 'users', id: 'ad3aa89e-9c5b-4ac9-a652-6670f9f27587' }
    }
  ]
})
