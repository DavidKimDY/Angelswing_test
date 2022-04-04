User.destroy_all
Project.destroy_all
Content.destroy_all

lee = User.create(first_name: 'Gildong', last_name: 'lee', email: "lee@gmail.com", password: "123123")
kim = User.create(first_name: 'David', last_name: 'Kim', email: "kim@gmail.com", password: "123123")

file = File.open(Rails.root.join('img/disney_land.jpeg'))
project_1 = Project.create(title: 'Seoul Downtown', user_id: kim.id, project_type: "external", location: "Seoul", thumbnail: file)
project_2 = Project.create(title: 'Daegu Downtown', user_id: lee.id, project_type: "external", location: "Deagu" ,thumbnail: file)

Content.create(title: 'Building',body: 'building',  project_id: project_1.id, user_id: project_1.user.id)
Content.create(title: 'Park', body: 'park',  project_id: project_2.id, user_id: project_2.user.id)
