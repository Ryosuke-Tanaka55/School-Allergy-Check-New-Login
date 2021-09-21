# coding: utf-8
            
SystemAdmin.find_or_create_by(id: 1) do |admin|
  admin.email = "system@email.com"
  admin.password = "password"
end

puts "SystemAdmin Created"

School.create!(school_name: "サンプル")

puts "School Created"

User.create!(name: "Sample User",
  email: "sample@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  school_id: 1)
  
User.create!(name: "管理職",
  email: "kanri@email.com",
  password: "password",
  password_confirmation: "password",
  admin: true,
  school_id: 1)
  
User.create!(name: "代表",
  email: "dai@n.n",
  password: "are",
  password_confirmation: "are",
  superior: true,
  admin: true,
  school_id: 1)
  
User.create!(name: "担当",
  email: "tan@n.n",
  password: "are",
  password_confirmation: "are",
  superior: true)

Teacher.create!(teacher_name: "管理職",
              email: "admin@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true,
              school_id: 1) 

Teacher.create!(teacher_name: "入力担当者",
            email: "creator@email.com",
            password: "password",
            password_confirmation: "password",
            creator: true,
            school_id: 1)

Teacher.create!(teacher_name: "一般",
            email: "ippan@email.com",
            password: "password",
            password_confirmation: "password",
            school_id: 1)

puts "Teacher Created"