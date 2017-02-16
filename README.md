# (WIP) Nodejs | PostgreSQL | JSONAPI Server

This is a boilerplate API server using Node.js, PostgreSQL, and [json:api](http://jsonapi.org/) spec.  

## Requirements
- Node.js 6.5+
- PostgreSQL 9.5+

[![js-standard-style](https://cdn.rawgit.com/feross/standard/master/badge.svg)](https://github.com/feross/standard)

## Installation

This repo comes with support for Docker using GNU Make targets

#### Clone this repo:

`git clone https://github.com/sgraham785/node-postgres-api-server.git`

#### Build Docker image:

`make`

#### Starting the server

```
make up
``` 

#### Starting the server in development mode (bindmounted src/ and hot reload)

```
make up-dev
``` 

#### Run tests

```
make test
```

## Configuration

Rename `.env.sample` to `.env` and add your configuration credentials

## Usage

Run database migrations & seeds:  (Broken)

`node source/middleware/database/migrate.js `

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/f8493f5b75ab1b296b22)

## Maintainers

[sgraham785](https://github.com/sgraham785)

## Contributing

1. Create your feature branch: `git checkout -b my-new-feature`
2. Commit your changes: `git commit -am 'Add some feature'`
3. Push to the branch: `git push origin my-new-feature`
4. Submit a pull/merge request to a maintainer :D

## Roadmap
in no particular order

- [x] Declarative routes
- [x] Public vs. Private(JWT) routes
- [x] Add security best practices
- [x] Use JSON API specification
- [x] Use JWT for private route auth
- [x] Create Postman collection
- [x] Add mailer
- [x] Use faker for seeding
- [x] Utilize swagger documentation
- [x] Dockerize
- [x] Add SSL
- [x] Add health check endpoint
- [ ] Add tests
- [x] ES6
- [ ] Support routes singular and/or plural
- [ ] Programmatic Migrations & Seeds
- [x] Graphql enabled
- [ ] Add yarn support
- [ ] Render email html w/ React.js
- [ ] Add Cloudrail support

## Known Issues
* https://github.com/sgraham785/node-postgres-api-server/issues
