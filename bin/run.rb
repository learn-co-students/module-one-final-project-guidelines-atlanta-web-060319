require_relative '../config/environment'
ActiveRecord::Base.logger = nil

#-----------START---------

#---------RUN-CLI---------

CLI.new.run  

#-------------------------

# binding.pry