class CLI
    def run
		@prompt = TTY::Prompt.new #tty-prompt used for various menus in this program
		@font = TTY::Font.new(:starwars)
        @pastel = Pastel.new
        @adminhash = {
            User.all.find_by(user_name: "Robert Chen").user_name => User.all.find_by(user_name: "Robert Chen").email,
            User.all.find_by(user_name: "Reina Ewing").user_name => User.all.find_by(user_name: "Reina Ewing").email
        }

        intro

    	while true 
            top_menu
    	end
	end
		#-------------------------
		#Intro Section
        def intro
            chewsound = fork{ exec 'afplay', "music/Chewbaccasound-1.mp3"}
            puts @pastel.blue(@font.write("CHEWBECCA"))
            puts @pastel.decorate('Sandwich Names', :yellow, :bold).center(110)
            sleep 3 
            `reset`
            puts "Skip Intro?"
            sleep 2
            yesorno = option_selector("choice", ["Yes", "No"])
            `reset`
            title_crawl if yesorno == "No"
        end
        #-------------------------
        def title_crawl
            theme = fork{ exec 'afplay', "music/starWars-mainTitle.mp3"} 
            puts "Episode 20 Chewbecca's Sandwiches"
            puts "\n\n"
            sleep 2
            puts "It's a great time in the Universe......."
            sleep 2 
            puts "It's a dark time for Pepperoni!!!"
            sleep 2 
            puts "Darth Kaeland's hunger for Pepperoni has"
            sleep 2 
            puts "caused a disturbance in the Force."
            sleep 2 
            puts "Will Gee continues to smuggle vital roast beef."
            sleep 2 
            puts "Only Ham Sandwiches can restore the balance."
            sleep 2
            puts "Help us, Master Brit, you are our only hope."
            sleep 2 
        end 
			
		#-------------------------
		#Top Menu Section
		def top_menu
			`reset`
    		top_menu_options = ["Login", "Top 3 Most Popular Chewbecca's Sandwiches", "Exit", "Official Business Only"]
    		top_menu_selection = @prompt.enum_select("Please select one.", top_menu_options)
    		#tty-prompt provides a nice menu with given options as strings

    		case top_menu_selection
    		when "Login"
    			`reset`
                r2you = fork{ exec 'afplay', "music/R2D2-hey-you.wav"}
    			login
    		when "Top 3 Most Popular Chewbecca's Sandwiches"
    			`reset`
                r2yeah = fork{ exec 'afplay', "music/R2D2-yeah.mp3"}
    			Order.top3
    			sleep 7
    		when "Exit"
                `reset`
                leiainsult = fork{ exec 'afplay', "music/nerfherder.mp3"}
                puts "***"
                sleep 1
                puts "******"
                sleep 1
                puts "*********"
                sleep 1
                puts "************"
                sleep 1
                puts "***************"
                sleep 1
                puts "******************"
    			exit
            else
                `reset`
                puts "What is your user name?"
                adminname = gets.chomp
                puts "What is your email?"
                adminemail = gets.chomp
                if @adminhash[adminname] == adminemail 
                    puts "Welcome, Admin #{adminname}!"
                    puts "Entering into a Ruby Session now."
                    binding.pry
                else
                    puts "Incorrect input, returning to main menu."
                    sleep 2
                end
    		end
    	end

		#-------------------------

		#-------------------------
		#Login Section
		def login
			puts "What is your user name?"
    		name = gets.chomp
    		if User.find_by(user_name: name)
    			puts "Welcome, back #{name}!"
                @user = User.find_or_create_by(user_name: name)
                email
                sleep 4
                menu_after_login
    		else
    			puts "Welcome, #{name}!"
                @user = User.find_or_create_by(user_name: name)
                email
                sleep 4
                menu_after_login_new_user
    		end
			#things to do after login: build sandwich, edit username or email and delete user
		end
		#-------------------------

        #-------------------------
        #Email Section
        def email
            puts "Do you want to add or update your email? (yes or no)"
            yesorno = gets.chomp.downcase
            if yesorno == "yes"
                puts "Enter your email"
                @user.update_attribute(:email, gets.chomp)
            end
        end
        #-------------------------
		
        #-------------------------
        #After-Login Menu Section
        def menu_after_login_new_user
            `reset`
            al_options = ["Build a Sandwich", "Exit"]
            al_selection = @prompt.enum_select("Please select one.", al_options)

            case al_selection
            when "Build a Sandwich"
                build_sandwich

                `reset`
                Order.create(user_id: @user.id, sandwich_id: Sandwich.find_by(meat: @meat, cheese: @cheese).id, bread: @bread, green: @green, condiment: @condiment, recipe: @recipe.join(", "))
                puts "Chewbecca is assembling your sandwich... Please wait just one moment."
                sleep 3
                puts "Your #{Sandwich.find_by(meat: @meat, cheese: @cheese).name} sandwich is ready!"
                forcealways = fork{ exec 'afplay', "music/force.mp3"}
                puts "The Force is Strong with You!"
                sleep 6
            else
                `reset`
                leiainsult = fork{ exec 'afplay', "music/nerfherder.mp3"}
                puts "***"
                sleep 1
                puts "******"
                sleep 1
                puts "*********"
                sleep 1
                puts "************"
                sleep 1
                puts "***************"
                sleep 1
                puts "******************"
                exit
            end
        end
        #-------------------------

		#-------------------------
		#After-Login Menu Section
		def menu_after_login
			`reset`
    		al_options = ["Build a Sandwich", "Edit Order", "Delete Order", "Exit"]
    		al_selection = @prompt.enum_select("Please select one.", al_options)

    		case al_selection
    		when "Build a Sandwich"
    			build_sandwich

                `reset`
                Order.create(user_id: @user.id, sandwich_id: Sandwich.find_by(meat: @meat, cheese: @cheese).id, bread: @bread, green: @green, condiment: @condiment, recipe: @recipe.join(", "))
                puts "Chewbecca is assembling your sandwich... Please wait just one moment."
                sleep 3
                puts "Your #{Sandwich.find_by(meat: @meat, cheese: @cheese).name} sandwich is ready!"
                forcealways = fork{ exec 'afplay', "music/force.mp3"}
                puts "The Force is Strong with You!"
                sleep 6
    		when "Edit Order"
    			delete_order
                build_sandwich
                `reset`
                Order.create(user_id: @user.id, sandwich_id: Sandwich.find_by(meat: @meat, cheese: @cheese).id, bread: @bread, green: @green, condiment: @condiment, recipe: @recipe.join(", "))
                puts "Chewbecca is remaking your sandwich... Please wait just one moment."
                sleep 3
                puts "Your #{Sandwich.find_by(meat: @meat, cheese: @cheese).name} sandwich is ready!"
                vaderbreath = fork{ exec 'afplay', "music/Darth-vader-breathing.wav"}
                puts "Stay Away from the Dark Side!"
                sleep 6
    		when "Delete Order"
    			delete_order
                `reset`
                chewsound = fork{ exec 'afplay', "music/Chewbaccasound-1.mp3"}
                puts "Chewbecca tossed your order out!"
                sleep 6
            else
                `reset`
                leiainsult = fork{ exec 'afplay', "music/nerfherder.mp3"} 
                puts "***"
                sleep 1
                puts "******"
                sleep 1
                puts "*********"
                sleep 1
                puts "************"
                sleep 1
                puts "***************"
                sleep 1
                puts "******************"
                exit
    		end
		end
		#-------------------------

        #-------------------------
        #Option Selector
        def option_selector(item, itemarr)
            `reset`
            puts "Pick a #{item}."
            selection = @prompt.enum_select("Please select one.", itemarr)
        end
        #-------------------------

		#-------------------------
		#Build a Sandwich Section
		def build_sandwich
			@recipe = []
			type = "bread"
    		bread_options = ["Sourdough", "Multigrain", "Rye"]
    		@bread = option_selector(type, bread_options)
    		@recipe.push(@bread)

			type = "cheese"
    		cheese_options = ["American", "Cheddar", "Provolone"]
    		@cheese = option_selector(type, cheese_options)
    		@recipe.push(@cheese)

			type = "meat"
    		meat_options = ["Turkey", "Ham", "Tuna Salad"]
    		@meat = option_selector(type, meat_options)
    		@recipe.push(@meat)

			type = "greens"
    		green_options = ["Spinach", "Romaine lettuce", "Kale"]
    		@green = option_selector(type, green_options)
    		@recipe.push(@green)

			type = "condiments"
    		condiment_options = ["Ketchup", "Mustard", "Mayonnaise"]
    		@condiment = option_selector(type, condiment_options)
    		@recipe.push(@condiment)
		end
		#-------------------------

		#-------------------------
		#Delete order Section
		def delete_order
            recipe_collection = @user.orders.map do |order|
                 "The #{Sandwich.find_by(id: order.sandwich_id).name} Sandwich, Recipe: #{order.recipe}"
            end

            @recipe_to_remove = option_selector("Number", recipe_collection)
            @index_to_remove = recipe_collection.find_index(@recipe_to_remove)
            @user.orders[@index_to_remove].destroy
		end
		#-------------------------
end