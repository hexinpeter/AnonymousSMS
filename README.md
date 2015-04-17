# README

## Deployment on Heroku
* database migration: `heroku run db:migrate`
* set environment vars: `figaro heroku:set -e production`
* add the Redis addon to Heroku: `heroku addons:add redistogo`
* set Heroku to use Redis: `heroku config:set REDIS_PROVIDER=REDISTOGO_URL`
* start sidekiq: `heroku run sidekiq`