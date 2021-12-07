# 開発環境用

# システム管理者作成（1人）
SystemAdmin.find_or_create_by(id: 1) do |admin|
  admin.email = "system@email.com"
  admin.password = "password"
end

puts "SystemAdmin Created"

# スクール作成（2校）
2.times do |n|
  School.create!(school_name: "サンプル#{n+1}",
                school_url: "sample#{n+1}")
end

puts "School Created"

# school_id: 1のクラス作成
Classroom.create!([{class_name: "1-1", class_grade: 1, school_id: 1},
                  {class_name: "1-2", class_grade: 1, school_id: 1},
                  {class_name: "1-3", class_grade: 1, school_id: 1},
                  {class_name: "2-1", class_grade: 2, school_id: 1},
                  {class_name: "2-2", class_grade: 2, school_id: 1},
                  {class_name: "2-3", class_grade: 2, school_id: 1},
                  {class_name: "特別学級1", class_grade: 7, school_id: 1},
                  {class_name: "特別学級2", class_grade: 7, school_id: 1},
                  ])

# school_id: 2のクラス作成
Classroom.create!([{class_name: "1-1", class_grade: 1, school_id: 2},
                  {class_name: "1-2", class_grade: 1, school_id: 2},
                  {class_name: "1-3", class_grade: 1, school_id: 2},
                  {class_name: "2-1", class_grade: 2, school_id: 2},
                  {class_name: "2-2", class_grade: 2, school_id: 2},
                  {class_name: "2-3", class_grade: 2, school_id: 2},
                  {class_name: "特別学級1", class_grade: 7, school_id: 2},
                  {class_name: "特別学級2", class_grade: 7, school_id: 2},
                  ])

puts "Classroom Created"

# school_id: 1の先生作成
# school_id: 1の権限者作成
Teacher.create!(teacher_name: "管理者A",
              email: "adminA@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true,
              school_id: 1,
              tcode: "kanri1",
              classroom_id: 1) 

Teacher.create!(teacher_name: "入力担当者A",
            password: "password",
            password_confirmation: "password",
            creator: true,
            school_id: 1,
            tcode: "taiou1",
            classroom_id: 1)

Teacher.create!(teacher_name: "代理申請者A",
            password: "password",
            password_confirmation: "password",
            charger: true,
            school_id: 1,
            tcode: "dairi1",
            classroom_id: 1)

# school_id: 1の一般職員作成
3.times do |n|
  name  = Faker::Name.name
  tcode = Faker::Alphanumeric.alphanumeric(number: 4, min_alpha: 1, min_numeric: 1)
  password = "password"
  Teacher.create!(teacher_name: name,
              password: password,
              password_confirmation: password,
              school_id: 1,
              tcode: tcode,
              classroom_id: n+2)
end

puts "school1 Teacher Created"

# school_id: 1の児童作成
4.times do |n|
  name  = "student1-1-#{n+1}"
  number = 1100 + n + 1
  Student.create!(student_name: name,
                  student_number: number,
                  school_id: 1,
                  classroom_id: 1)
end
puts "school1 1-1Student Created"


# school_id: 2の先生作成
# school_id: 2の権限者作成
Teacher.create!(teacher_name: "管理者B",
              email: "adminB@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true,
              school_id: 2,
              tcode: "kanri2",
              classroom_id: 9) 

Teacher.create!(teacher_name: "入力担当者B",
            password: "password",
            password_confirmation: "password",
            creator: true,
            school_id: 2,
            tcode: "taiou2",
            classroom_id: 9)

Teacher.create!(teacher_name: "代理申請者B",
            password: "password",
            password_confirmation: "password",
            charger: true,
            school_id: 2,
            tcode: "dairi2",
            classroom_id: 9)

# school_id: 2の一般職員作成
3.times do |n|
  name  = Faker::Name.name
  tcode = Faker::Alphanumeric.alphanumeric(number: 4, min_alpha: 1, min_numeric: 1)
  password = "password"
  Teacher.create!(teacher_name: name,
              password: password,
              password_confirmation: password,
              school_id: 2,
              tcode: tcode,
              classroom_id: n+10)
end

puts "school2 Teacher Created"

# school_id: 2の児童作成
4.times do |n|
  name  = "student2-1-#{n+1}"
  number = 2100 + n + 1
  Student.create!(student_name: name,
                  student_number: number,
                  school_id: 2,
                  classroom_id: 9)
end

puts "school1 2-1Student Created"