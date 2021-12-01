# coding: utf-8
            
SystemAdmin.find_or_create_by(id: 1) do |admin|
  admin.email = "system@email.com"
  admin.password = "password"
end

puts "SystemAdmin Created"

2.times do |n|
  School.create!(school_name: "サンプル#{n+1}",
                school_url: "sample#{n+1}")
end

puts "School Created"

User.create!(name: "Sample User",
  email: "sample@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true)
  
User.create!(name: "管理職",
  email: "kanri@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true)
  
User.create!(name: "代表",
  email: "dai@n.n",
  password: "are",
  password_confirmation: "are",
  superior: true,
  admin: true)
  
User.create!(name: "担当",
  email: "tan@n.n",
  password: "are",
  password_confirmation: "are",
  superior: true)

puts "User Created"

# クラス作成
classroom_id = 1
2.times do |n|
  Classroom.create!(class_name: "#{n+1}-1",
                  school_id: 1)
end
2.times do |n|
  Classroom.create!(class_name: "#{n+1}-a",
                  school_id: 2)
  end
puts "Classroom Created"           

Teacher.create!(teacher_name: "管理職",
              email: "adminA@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true,
              school_id: 1,
              tcode: "kanri1",
              classroom_id: classroom_id) 

Teacher.create!(teacher_name: "入力担当者",
            email: "creator@email.com",
            password: "password",
            password_confirmation: "password",
            creator: true,
            school_id: 1,
            tcode: "taiou1",
            classroom_id: classroom_id) 

Teacher.create!(teacher_name: "一般",
            email: "teacher@email.com",
            password: "password",
            password_confirmation: "password",
            school_id: 1,
            tcode: "11aa",
            classroom_id: classroom_id) 

puts "1-1Teacher Created"

# 児童データ作成
4.times do |n|
  name  = "student1-1-#{n+1}"
  number = 1100 + n + 1
  Student.create!(student_name: name,
                  student_number: number,
                  school_id: 1,
                  classroom_id: classroom_id)
end

puts "1-1Student Created"

classroom_id = 3
Teacher.create!(teacher_name: "管理職",
  email: "adminB@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  school_id: 2,
  tcode: "kanri2",
  classroom_id: classroom_id) 

2.times do |n|
  name  = Faker::Name.name
  email = "teacher#{n+1}@email.com"
  tcode = Faker::Alphanumeric.alphanumeric(number: 4, min_alpha: 1, min_numeric: 1)
  password = "password"
  Teacher.create!(teacher_name: name,
              email: email,
              password: password,
              password_confirmation: password,
              school_id: 2,
              tcode: tcode,
              classroom_id: classroom_id)
end
puts "2-1Teacher Created"

4.times do |n|
  name  = "student2-1-#{n+1}"
  number = 2100 + n + 1
  Student.create!(student_name: name,
                  student_number: number,
                  school_id: 2,
                  classroom_id: classroom_id)
end

puts "2-1Student Created"


