# coding: utf-8
            
SystemAdmin.find_or_create_by(id: 1) do |admin|
  admin.email = "system@email.com"
  admin.password = "password"
end

puts "SystemAdmin Created"

School.create!(school_name: "サンプル",
               school_url: "sample1")

School.create!(school_name: "あいうえお小学校",
              school_url: "aiueosho1")

School.create!(school_name: "かきくけこ小学校",
              school_url: "sasisu1")

puts "School Created"

Classroom.create!([{class_name: "1-1", class_grade: 1, school_id: 1},
                  {class_name: "1-2", class_grade: 1, school_id: 1},
                  {class_name: "1-3", class_grade: 1, school_id: 1},
                  {class_name: "1-4", class_grade: 1, school_id: 1},
                  {class_name: "2-1", class_grade: 2, school_id: 1},
                  {class_name: "2-2", class_grade: 2, school_id: 1},
                  {class_name: "2-3", class_grade: 2, school_id: 1},
                  {class_name: "2-4", class_grade: 2, school_id: 1},
                  {class_name: "3-1", class_grade: 3, school_id: 1},
                  {class_name: "3-2", class_grade: 3, school_id: 1},
                  {class_name: "3-3", class_grade: 3, school_id: 1},
                  {class_name: "3-4", class_grade: 3, school_id: 1},
                  {class_name: "4-1", class_grade: 4, school_id: 1},
                  {class_name: "4-2", class_grade: 4, school_id: 1},
                  {class_name: "4-3", class_grade: 4, school_id: 1},
                  {class_name: "4-4", class_grade: 4, school_id: 1},
                  {class_name: "特別学級１", class_grade: 7, school_id: 1},
                  {class_name: "特別学級２", class_grade: 7, school_id: 1},
                  {class_name: "特別学級３", class_grade: 7, school_id: 1},
                  ])

Classroom.create!([{class_name: "1-1", class_grade: 1, school_id: 2},
                  {class_name: "1-2", class_grade: 1, school_id: 2},
                  {class_name: "1-3", class_grade: 1, school_id: 2},
                  {class_name: "1-4", class_grade: 1, school_id: 2},
                  {class_name: "2-1", class_grade: 2, school_id: 2},
                  {class_name: "2-2", class_grade: 2, school_id: 2},
                  {class_name: "2-3", class_grade: 2, school_id: 2},
                  {class_name: "2-4", class_grade: 2, school_id: 2},
                  {class_name: "3-1", class_grade: 3, school_id: 2},
                  {class_name: "3-2", class_grade: 3, school_id: 2},
                  {class_name: "3-3", class_grade: 3, school_id: 2},
                  {class_name: "3-4", class_grade: 3, school_id: 2},
                  {class_name: "4-1", class_grade: 4, school_id: 2},
                  {class_name: "4-2", class_grade: 4, school_id: 2},
                  {class_name: "4-3", class_grade: 4, school_id: 2},
                  {class_name: "4-4", class_grade: 4, school_id: 2},
                  {class_name: "特別学級１", class_grade: 7, school_id: 2},
                  {class_name: "特別学級２", class_grade: 7, school_id: 2},
                  {class_name: "特別学級３", class_grade: 7, school_id: 2},
                  ])

Classroom.create!([{class_name: "1-1", class_grade: 1, school_id: 3},
                  {class_name: "1-2", class_grade: 1, school_id: 3},
                  {class_name: "1-3", class_grade: 1, school_id: 3},
                  {class_name: "1-4", class_grade: 1, school_id: 3},
                  {class_name: "2-1", class_grade: 2, school_id: 3},
                  {class_name: "2-2", class_grade: 2, school_id: 3},
                  {class_name: "2-3", class_grade: 2, school_id: 3},
                  {class_name: "2-4", class_grade: 2, school_id: 3},
                  {class_name: "3-1", class_grade: 3, school_id: 3},
                  {class_name: "3-2", class_grade: 3, school_id: 3},
                  {class_name: "3-3", class_grade: 3, school_id: 3},
                  {class_name: "3-4", class_grade: 3, school_id: 3},
                  {class_name: "4-1", class_grade: 4, school_id: 3},
                  {class_name: "4-2", class_grade: 4, school_id: 3},
                  {class_name: "4-3", class_grade: 4, school_id: 3},
                  {class_name: "4-4", class_grade: 4, school_id: 3},
                  {class_name: "特別学級１", class_grade: 7, school_id: 3},
                  {class_name: "特別学級２", class_grade: 7, school_id: 3},
                  {class_name: "特別学級３", class_grade: 7, school_id: 3},
                  ])

puts "Classroom Created"

# # 1-1のクラス作成
# classroom_id = 1
# Classroom.create!(class_name: "1-1",
#                 school_id: 1)

# school_id: 1
Teacher.create!(teacher_name: "管理職",
              email: "admin@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true,
              school_id: 1,
              tcode: "kanri1",
              classroom_id: 1) 

Teacher.create!(teacher_name: "入力担当者",
            email: "creator@email.com",
            password: "password",
            password_confirmation: "password",
            creator: true,
            school_id: 1,
            tcode: "taiou1",
            classroom_id: 1) 

Teacher.create!(teacher_name: "一般",
            email: "teacher@email.com",
            password: "password",
            password_confirmation: "password",
            school_id: 1,
            tcode: "11aa",
            classroom_id: 1) 

puts "school1 KanriTeacher Created"

# 児童データ作成
4.times do |n|
  name  = "student1-1-#{n+1}"
  number = 1100 + n + 1
  Student.create!(student_name: name,
                  student_number: number,
                  school_id: 1,
                  classroom_id: 1)
end
puts "school1 1-1Student Created"

# 1-1の一般職員作成
3.times do |n|
  name  = Faker::Name.name
  tcode = Faker::Alphanumeric.alphanumeric(number: 4, min_alpha: 1, min_numeric: 1)
  password = "password"
  Teacher.create!(teacher_name: name,
              password: password,
              password_confirmation: password,
              school_id: 1,
              tcode: tcode,
              classroom_id: 1)
end
puts "school1 1-1IppanTeacher Created"


# # 2-1のクラス作成
# classroom_id = 2
# Classroom.create!(class_name: "2-1",
#                 school_id: 1)

# 2-1の一般職員作成
3.times do |n|
  name  = Faker::Name.name
  tcode = Faker::Alphanumeric.alphanumeric(number: 4, min_alpha: 1, min_numeric: 1)
  password = "password"
  Teacher.create!(teacher_name: name,
              password: password,
              password_confirmation: password,
              school_id: 1,
              tcode: tcode,
              classroom_id: 5)
end
puts "school1 2-1IppanTeacher Created"

4.times do |n|
  name  = "student2-1-#{n+1}"
  number = 2100 + n + 1
  Student.create!(student_name: name,
                  student_number: number,
                  school_id: 1,
                  classroom_id: 5)
end

puts "school1 2-1Student Created"


# school_id: 2
Teacher.create!(teacher_name: "あいうえお管理者１",
            email: "aiueo1@email.com",
            password: "password",
            password_confirmation: "password",
            admin: true,
            school_id: 2,
            tcode: "aiueo1",
            classroom_id: 20)
puts "school2 KanriTeacher Created"

# 1-1の一般職員作成
3.times do |n|
  name  = Faker::Name.name
  tcode = Faker::Alphanumeric.alphanumeric(number: 4, min_alpha: 1, min_numeric: 1)
  password = "password"
  Teacher.create!(teacher_name: name,
              password: password,
              password_confirmation: password,
              school_id: 2,
              tcode: tcode,
              classroom_id: 20)
end
puts "school2 1-1IppanTeacher Created"