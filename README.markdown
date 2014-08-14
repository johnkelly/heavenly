#Heavenly
![Heavenly](https://github.com/limitingfactor/heavenly/blob/master/heavenly.jpg)

###Technology Stack
* ruby 2.1.2
* Rails 4.1
* Postgres 9.3

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
