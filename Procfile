web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -q default -q elasticsearch -q expire -q mailer -c 2
