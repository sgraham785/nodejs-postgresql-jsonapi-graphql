import Chance from 'chance'
const chance = new Chance()

exports['todo_items'] = {
  iterations: 48,
  values: 'chance.todos()'
}

chance.mixin({
  'todos': function () {
    return {
      // id: chance.guid(),
      user_id: chance.integer(),
      text: chance.sentence(),
      complete: chance.bool()
    }
  }
})
