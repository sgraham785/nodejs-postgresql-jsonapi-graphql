import Chance from 'chance'
const chance = new Chance()

exports['todos'] = {
  iterations: 48,
  values: 'chance.todos()'
}

chance.mixin({
  'todos': function () {
    return {
      id: chance.guid(),
      user_id: chance.guid(),
      text: chance.sentence(),
      complete: chance.bool()
    }
  }
})
