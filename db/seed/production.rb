# 本番環境用
SystemAdmin.find_or_create_by(id: 1) do |admin|
  admin.email = ENV['SYSTEM_ADMIN_EMAIL']
  admin.password = ENV['SYSTEM_ADMIN_PASS']
end

puts "SystemAdmin Created"