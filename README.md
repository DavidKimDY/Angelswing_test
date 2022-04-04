# Angelswing API test

## version
- ruby 3.1.1
- rails 7.0.2.3
- psql (PostgreSQL) 14.1 

## setup
1. git clone https://github.com/DavidKimDY/Angelswing_test.git
2. cd Angelswing_test
3. bundle install
4. rails db:create
5. rails db:migrate
6. put application.yml into config
7. rails db:seed

## TEST Setup
1. rails db:migrate RAILS_ENV=test
2. rails db:seed RAILS_ENV=test
3. rspec spec

## application.yml
- this file has private enviromental variables like AWS S3 account, JWT secret. I will send this file to aayush@angelswing.io, yogi@angelswing.io

## Incompleted part
- Unit test for medels
