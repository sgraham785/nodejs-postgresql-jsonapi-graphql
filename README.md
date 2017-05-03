# (WIP) Nodejs | PostgreSQL | JSONAPI Server

This is a boilerplate API server using Node.js, PostgreSQL, and [json:api](http://jsonapi.org/) spec.  

## Requirements
- Node.js 6.5+
- PostgreSQL 9.5+

[![js-standard-style](https://cdn.rawgit.com/feross/standard/master/badge.svg)](https://github.com/feross/standard)

## Installation

This repo comes with support for Docker using GNU Make targets

#### Clone this repo:

`git remote add origin https://github.com/sgraham785/nodejs-postgresql-jsonapi-graphql.git app`

## Docker Usage

Build the app and database docker images & containers locally then run them in development mode:

`make build-dev`

If you already have the images built and want to create the containers & run them in development mode:

`make up-dev`

To stop and remove the containers (not images):

`make down`

See `make help` for more options 

#### Run tests

```
make test
```

## Configuration

Rename `.env.sample` to `.env` and add your configuration credentials


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
- [x] Generate fake seed data
- [x] Programmatic Migrations
- [ ] Fix programmatic seeding
- [x] Graphql enabled
- [ ] Add yarn support
- [ ] Render email html w/ React.js
- [ ] Add Cloudrail support

## Known Issues
* https://github.com/sgraham785/nodejs-postgresql-jsonapi-graphql/issues
