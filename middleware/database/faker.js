import fs from 'fs'
import faker from 'faker'
const dataPath = 'seeds/data/'

const users = []
const todos = []

/* Create users */
for (let u = 10; u >= 0; u--) {
  const userId = faker.random.number()

  const usersArray = {
    'id': userId,
    'first_name': faker.name.firstName(),
    'last_name': faker.name.lastName(),
    'email': faker.internet.email(),
    'password': faker.internet.password(),
    'code': faker.finance.account(),
    'verified': faker.random.boolean()
  }
  users.push(usersArray)

  /* Create todos for users */
  for (let t = 12; t >= 0; t--) {
    const todosArray = {
      'user_id': userId,
      'text': faker.hacker.phrase(),
      'complete': faker.random.boolean()
    }
    todos.push(todosArray)
  }
}

fs.writeFile(`${dataPath}users.json`, JSON.stringify(users), () => {
  console.log('users generated successfully!')
})

fs.writeFile(`${dataPath}todos.json`, JSON.stringify(todos), () => {
  console.log('todos generated successfully!')
})
