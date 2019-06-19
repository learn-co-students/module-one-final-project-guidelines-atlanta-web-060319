require "pry"
class CLI

  def run
    @user = nil
    @prompt = TTY::Prompt.new
    puts "Welcome to Hydrate Yourself"
    response = @prompt.select("What would you like to do?", %w(Login CreateAccount Exit))
    case response
      when "Login"
        login
      when "CreateAccount"
        create_account
      when "Exit"
        exit
      end

    main_menu
  end

  def main_menu
    choices = ["Take Quiz", "Input WaterIntake", "See Progress", "Update Profile", "Delete Account"]
    a = @prompt.select("Select Choice?", choices)

    case a
      when choices[0]
         take_quiz
      when choices[1]
        input_water_intake
      when choices[2]
        see_progress
      when choices[3]
        update_profile
      when choices[4]
        delete_account
    end

  end

  def take_quiz
    ##build five questions
    @first = Goal.find_by(cup: 400)
    @second = Goal.find_by(cup: 600)
    @third = Goal.find_by(cup: 800)
    @counter = 0

    puts "1. How much water do you currently drink?"
    choices = ["One Cup Daily", "Three Cups Daily", "I'm Basically a Mermaid/Man!!"]
    a = @prompt.select("Select Amount?", choices)
    # binding.pry
    case a
    when choices[0]
      puts "\n\nDude Seriously!!\n\n"
      @counter += 1
    when choices[1]
      puts "\n\nThat's Ok, but Maybe You Could Do Better\n\n"
      @counter += 2
    when choices[2]
      puts "\n\nYou Rock!!!\n\n"
      @counter += 3
    end

    puts " 2. How much water would you like to be drinking a day?"
    choices_two = ["Three Cups Daily", "Six Cups Daily", "Eight Cups Daily"]
    b = @prompt.select("Select Amount?", choices_two)

    case b
    when choices_two[0]
      @counter += 1
    when choices_two[1]
      @counter += 2
    when choices_two[2]
      @counter += 3
    end

    puts " 3. What do you wish to gain from Hydrate Your Life?"
    choices_three = ["Better Health", "More Energy", "Finally Be Water Healthy"]
    c = @prompt.select("Select Amount?", choices_three)

    case c
    when choices_three[0]
      @counter += 1
    when choices_three[1]
      @counter += 2
    when choices_three[2]
      @counter += 3
      # puts "Your Goal is set too #{water.cup} in a month"
      # water = WaterIntake.create(user_id: @user.id, goal_id: @first.id, tracker: 0)
    end

    if @counter <= 4
      puts "Your Goal is to reach 400cups"
      water = WaterIntake.create(user_id: @user.id, goal_id: @first.id, tracker: 0)
    elsif @counter <= 6
      puts "Your Goal is to reach 600cups"
      water = WaterIntake.create(user_id: @user.id, goal_id: @second.id, tracker: 0)
  else @counter <= 10
      puts "Your goal is to reach 800cups"
      water = WaterIntake.create(user_id: @user.id, goal_id: @third.id, tracker: 0)
    end
  end

  def login
    puts "Please enter your username!"
    input = gets.chomp
   if User.find_by(name: input)
     puts "Welcome back #{input}"
   else
     did_not_find_you
      end
  end

  def did_not_find_you
    puts "We havent met you yet. Please Create an Account"
    run
  end


  def create_account
    puts "\nMake your profile...\n"

      sleep 1
      puts "Enter your name!\n\n"
      name = gets.chomp
      @user = User.create(name: name)
      `reset`
      sleep 1

      puts "What is your Spirit Animal?\n\n"
      animal = gets.chomp
      @user.spirit_animal = animal
      @user.save
      `reset`

      sleep 1
      puts "How Old Are You?\n\n"
      age = gets.chomp
      @user.age = age
      @user.save
      `reset`

      sleep 1
      puts "Hi #{@user.name}!, Your spirit animal is #{@user.spirit_animal}.\n\n"

      main_menu
  end

  def input_water_intake

    puts "How many cups of water have you had today?"

    choices = ["One Cup", "Two Cups", "Three Cups", "Four Cups", "Five Cups", "Six Cups",
    "Seven Cups", "Eight Cups"]
    cups = @prompt.select("Select Amount?", choices)

    case cups
    when choices[0]
      water =  WaterIntake.find_by(user_id: @user.id)
      track = water.tracker += 1
      water.save
      puts " Awee You Only Increased Your Water Intake By #{track}"
    when choices[1]
      water =  WaterIntake.find_by(user_id: @user.id)
      track = water.tracker += 2
      water.save
      puts " You have increased Your Water Intake By #{track}"
    when choices[2]
      water =  WaterIntake.find_by(user_id: @user.id)
      track = water.tracker += 3
      water.save
      puts " You have increased Your Water Intake By #{track}"
    when choices[3]
      water =  WaterIntake.find_by(user_id: @user.id)
      track = water.tracker += 4
      water.save
      puts " You have increased Your Water Intake By #{track}"
    when choices[4]
      water =  WaterIntake.find_by(user_id: @user.id)
      track = water.tracker += 5
      water.save
      puts " You have increased Your Water Intake By #{track}"
    when choices[5]
      water =  WaterIntake.find_by(user_id: @user.id)
      track = water.tracker += 6
      water.save
      puts " You have increased Your Water Intake By #{track}"
    when choices[6]
      water =  WaterIntake.find_by(user_id: @user.id)
      track = water.tracker += 7
      water.save
      puts " You have increased Your Water Intake By #{track}"
    when choices[7]
      water =  WaterIntake.find_by(user_id: @user.id)
      track = water.tracker += 8
      water.save
      puts " You have increased Your Water Intake By #{track}"
    end
    main_menu
  end

  def see_progress
  #See progress method should store water  intake amount from input goal
  @water = WaterIntake.find_by(user_id: @user.id)
  # binding.pry

  @c_track = Goal.find_by(id: @water.goal_id)
  puts "Your Goal is #{@c_track.cup}!!!"

  puts "You've had a total #{@water.tracker} cups so far!"
  main_menu
  end

  def update_profile
    #user should be able to change name and add spirit spirit_animal
     puts "What Would you Like to Update"
    options = ["Change Name", "Change Spirit Animal", "Change Age"]
    c = @prompt.select("Select Amount?", options)

    case c
    when  options[0]
      puts "What is your new name?"
      name =  gets.chomp
      @user.name = name
      @user.save
      puts "Ok, got it! Hi #{name.capitalize}!!!"
    when  options[1]
      puts "What is your new Spirit Animal"
      animal = gets.chomp
      @user.spirit_animal = animal
      @user.save
      puts " You will now be Known as #{animal.capitalize}"
    when  options[2]
      puts "Was it Your Birthday? What is Your New Age?"
      age = gets.chomp
      @user.age = age
      @user.save
      puts "Happy Belated Birthday, You are now #{age} the brave!"
    end
    main_menu
  end

  def delete_account
    question = @prompt.ask('Are you sure you want to delete your account?')
    case question
    when "yes"
      @user.destroy
      puts "BYE BYE! :,("
    when "no"
      puts "Thank you for staying with us, Keep Drinking Water!!!"
    end
  end
end
