export default function transaction (fn) {
  return function _transaction (knex, Promise) {
    return knex.transaction(trx => trx
      .raw('SET foreign_key_checks = 0')
      .then(() => fn(trx, Promise))
      .finally(() => trx.raw('SET foreign_key_checks = 1')))
  }
};
