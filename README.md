# This is an API only app created for a Assessment, which fulfills the below requirement.
* Create a new Rails app

* Create a new model with a name and data of your choosing with some basic validations

* Create a controller for this model that contains endpoints for create and update o No authentication is required o Include some basic verification for submitted parameters

* Available third-party API endpoints should be configurable (backend support only, no need for GUI)

* When new data is stored or updated, all configured endpoints should be notified of the changes

* Third parties should be provided with means to verify the authenticity of the webhook request

# Configuration

* Ruby version - `3.2.1`

* Rails version - `7.0.7`

## Send the request using `curl -X POST -H "Content-Type: application/json" -d '{"data_entry":{"name":"Test"}}' http://localhost:3000/api/v1/data_entries`

## Send the request (Using authenticator)`curl -X POST -H "Content-Type: application/json" -H "Authorization: #{your_jwt_token}" -d '{"data_entry":{"name":"New Data"}}' http://localhost:3000/api/v1/data_entries`
