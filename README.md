# README

This is a Rails app allowing people to schedule an anoymous SMS to be sent to any Australian phone number, and to check the replies too. It uses the [Telstra SMS API](https://dev.telstra.com/sms-quick-start).

Checkout the website at [meetingsaviour.herokuapp.com](https://meetingsaviour.herokuapp.com)

## Deployment on Heroku
* database migration: `heroku run db:migrate`
* set environment vars: `figaro heroku:set -e production`
* add the Redis addon to Heroku: `heroku addons:add redistogo`
* set Heroku to use Redis: `heroku config:set REDIS_PROVIDER=REDISTOGO_URL`
* start sidekiq: `heroku run sidekiq`