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

Swagger UI [api-docs](http://localhost:3000/api-docs/index.html)

## Testing

To test `endpoints` send request to the server with correct `verb` and `path`:

<img width="1089" alt="image" src="https://user-images.githubusercontent.com/13584120/189496449-60abdf0b-a351-4f58-8dcd-b393313e1273.png">

Server MUST respond with `not_found` error if `verb` is different from Endpoints record:

<img width="1095" alt="image" src="https://user-images.githubusercontent.com/13584120/189496504-51bbacf7-de38-46a0-ac08-96c2819b524a.png">
