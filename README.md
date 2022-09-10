## About

The application allows creating new routes dynamically to which developers can assign:
- verb
- path
- response

## Running locally

```
bundle install
rake db:setup db:migrate
rails server
``` 

## Documentation

In order to expose this API to the proper consumers it is relevant to expose clear documentation of the available endpoints while maintaining that documentation always current in time.

The best way to document a REST API is to expose a Swagger file and define on that file all their requirements that each endpoint needs for its proper operation.

Swagger UI [api-docs](localhost:3000/api-docs)