# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Project.destroy_all

kim = User.create(first_name: 'Gildong', last_name: 'Kim', email: "kim@gmail.com", password: "123123")
project_1 = Project.create(title: 'Seoul Downtown', user_id: kim.id)
project_2 = Project.create(title: 'Daegu Downtown', user_id: kim.id)
content_1 = Content.create(title: 'Building', project_id: project_1.id, user_id: project_1.user.id)
content_1 = Content.create(title: 'Park', project_id: project_1.id, user_id: project_1.user.id)