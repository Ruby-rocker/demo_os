default: &default
  adapter: mysql
  host: mysql.citrusme.com
  username: mysql
  password: "*MYsQL4ra1L$!!"
  encoding: utf8
  port: 8803
  database: one_story_road
  
development:
  <<: *default

test:
  <<: *default
  database: one_story_test

production:
  <<: *default
