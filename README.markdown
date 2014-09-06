#Heavenly
![Heavenly](https://github.com/limitingfactor/heavenly/blob/master/heavenly.jpg)

## Summary
* The idea was to build an api for an iphone application to consume. The api has Facebook authentication on the client and then token authentication between the client and the server once the facebook authentication is verified on the server. 
* The api also has products that can be searched for within a 10 miles radius using elasticsearch and an ordering system.
* This application was a proof of concept of geolocation search and facebook authentication with a Rails API and is not under further development.
* This application was also proof of a buyer/seller marketplace with an ordering system to create a receipt paper trail of transactions.

###Technology Stack
* ruby 2.1.2
* Rails 4.1
* Postgres 9.3
* Elasticsearch
* Stripe

###Tasks
* Run 'foreman start' to start the server and go to http://localhost:5000
* Run 'foreman run rails c' to start the rails console
* Run 'foreman run rspec' to run your test suite

###Setup
* Clone this repository
* Get the .env file that is not in git from a team member
* Run bundle
* Run 'rake db:create db:migrate db:seed' and 'RAILS_ENV=test rake db:create db:migrate db:seed'
* Run 'foreman run rspec' and all tests should pass
