User.destroy_all
Project.destroy_all

kim = User.create(first_name: 'Gildong', last_name: 'Go', email: "go@gmail.com", password: "123123")
paul = User.create(first_name: 'David', last_name: 'Kim', email: "kim@gmail.com", password: "123123")
file = File.open(Rails.root.join('img/disney_land.jpeg'))
project_1 = Project.create(title: 'Seoul Downtown', user_id: kim.id, project_type: "external", location: "Seoul", thumbnail: file)
project_2 = Project.create(title: 'Daegu Downtown', user_id: kim.id, project_type: "external", location: "Deagu" ,thumbnail: file)
project_3 = Project.create(title: 'Seoul Cityhall', user_id: paul.id, project_type: "external", location: "Seoul",thumbnail: file)
project_4 = Project.create(title: 'Disney Land', user_id: paul.id, project_type: "external", location: "Seoul",thumbnail: file)

Content.create(title: 'Building', project_id: project_1.id, user_id: project_1.user.id)
Content.create(title: 'Park', project_id: project_1.id, user_id: project_1.user.id)
