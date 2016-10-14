node[:deploy].each do |application, deploy|
  Chef::Log.info("Running deploy/before_symlink.rb...")
  Chef::Log.info("Release path: #{release_path}")

  if deploy[:application_type] != 'rails'
    Chef::Log.debug("Skipping application #{application} as it is not an Rails app")
    next
  end

  file "#{release_path}/.env1" do
    content "This is my file "
  end

  open("#{release_path}/.env", 'w') do |f| 
     require 'yaml'
     node[:deploy][application][:environment_variables].each do |key,value|
       f.puts "#{key}=#{value}"
     end
  end
end
