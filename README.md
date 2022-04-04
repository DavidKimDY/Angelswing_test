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
6. put `application.yml` into config
7. rails db:seed  


## application.yml
- this file has private enviromental variables like AWS S3 account, JWT secret. I will send this file to aayush@angelswing.io, yogi@angelswing.io


## Run server
- rails s

## Seed data
### Users
- all seed user's password is `123123`
```
 id | first_name | last_name |     email      | country
----+------------+-----------+----------------+---------
  1 | Gildong    | lee       | lee@gmail.com  |
  2 | David      | Kim       | kim@gmail.com  |
```
### Projects
- seed thumbnail is in `/img/disney_land.jpeg`
```
 id | user_id |     title      |  description  | project_type | location |     thumbnail      
----+---------+----------------+---------------+--------------+----------+--------------------
  1 |       2 | Seoul Downtown | best donwtown |            0 | Seoul    | disney_land.jpeg   
  2 |       1 | Daegu Downtown | best donwtown |            0 | Deagu    | disney_land.jpeg   
```

### Contents
```
 id | user_id | project_id |  title   |   body   
----+---------+------------+----------+----------
  1 |       2 |          1 | Building | building 
  2 |       1 |          2 | Park     | park     
  ```

## TEST Setup
1. rails db:migrate RAILS_ENV=test
2. rails db:seed RAILS_ENV=test

## Test
- rspec spec
-  if the result of `rspec spec` looks like `FFFFFFFF.FFFFFFFFFFFFFFFFFFF......` Try to do this command again `rails db:seed RAILS_ENV=test`

## Incompleted part
- Unit test for medels
