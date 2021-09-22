# coding: utf-8
School.create!(school_name: "松江市立乃木小学校")


User.create!(name: "Sample User",
             email: "sample@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
            #  school_id: 1)
             
User.create!(name: "管理職",
             email: "kanri@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)
            #  school_id: 1)
             
User.create!(name: "代表",
             email: "dai@n.n",
             password: "are",
             password_confirmation: "are",
             superior: true,
             admin: true)
            #  school_id: 1)
             
User.create!(name: "担当",
             email: "tan@n.n",
             password: "are",
             password_confirmation: "are",
             superior: true)              
             


