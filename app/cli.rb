require "pry"
class CLI
    `reset`
  def run
    @user = nil
    @prompt = TTY::Prompt.new
    @pastel = Pastel.new
    @font = TTY::Font.new(:doom)
    puts "Welcome to.."
    puts @pastel.blue(@font.write("iHydrate"))
    # puts @font.write("Hydrate Yourself")
    # puts "\n\nWelcome to Hydrate Yourself\n\n"
    response = @prompt.select("What would you like to do?", %w(Login CreateAccount Exit))
    case response
      when "Login"
        login
      when "CreateAccount"
        create_account
      when "Exit"
        puts "\n\nSee Ya!\n\n"
        exit
      else
        exit
      end

    main_menu
  end
  `reset`
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
      else
        exit
    end

  end


  def take_quiz
    ##build five questions
    @first = Goal.find_by(cup: 400)
    @second = Goal.find_by(cup: 600)
    @third = Goal.find_by(cup: 800)
    @counter = 0

    `reset`

    puts "\n\n1. How much water do you currently drink?\n\n"
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
      else
        puts "ERROR FIX ME..IM IN TAKE QUIZ"
    end

    puts "\n\n 2. How much water would you like to be drinking a day?\n\n"
    choices_two = ["Three Cups Daily", "Six Cups Daily", "Eight Cups Daily"]
    b = @prompt.select("Select Amount?", choices_two)

    case b
      when choices_two[0]
        @counter += 1
      when choices_two[1]
        @counter += 2
      when choices_two[2]
        @counter += 3
      else
        puts "ERROR FIX ME..IM IN TAKE QUIZ"
    end

    puts "\n\n 3. What do you wish to gain from Hydrate Your Life?\n\n"
    choices_three = ["Better Health", "More Energy", "Aqua Lungs"]
    c = @prompt.select("Select Amount?", choices_three)

    case c
      when choices_three[0]
        @counter += 1
      when choices_three[1]
        @counter += 2
      when choices_three[2]
        @counter += 3
      else
        puts "ERROR FIX ME..IM IN TAKE QUIZ"
    end

    if @counter <= 4
      puts "\n\nYour Goal is to reach 400cups\n\n"
      water = WaterIntake.create(user_id: @user.id, goal_id: @first.id, tracker: 0)
    elsif @counter <= 6
      puts "\n\nYour Goal is to reach 600cups\n\n"
      water = WaterIntake.create(user_id: @user.id, goal_id: @second.id, tracker: 0)
    else @counter <= 10
      puts "\n\nYour goal is to reach 800cups\n\n"
      water = WaterIntake.create(user_id: @user.id, goal_id: @third.id, tracker: 0)
    end

    main_menu
  end
  `reset`

  def login
    `reset`
    puts "Please enter your username!"
    input = gets.chomp
   if User.find_by(name: input)
     @user = User.find_by(name: input)
     puts "\n\nWelcome back #{input}\n\n"
   else
     did_not_find_you
    end
  end
  sleep 3

  def did_not_find_you
    puts "We havent met you yet. Please Create an Account"
    run
  end


  def create_account
      puts "\nMake your profile...\n"

      sleep 1
      puts "Enter your name!\n\n"
      name = gets.chomp
      @user = User.create(name: name.downcase)
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

    puts "\n\nHow many cups of water have you had today?\n\n"

    choices = ["One Cup", "Two Cups", "Three Cups", "Four Cups", "Five Cups", "Six Cups", "Seven Cups", "Eight Cups"]
    cups = @prompt.select("Select Your Amount?", choices)
    case cups
    when choices[0]
        water = WaterIntake.find_by(user_id: @user.id)
        track = water.tracker += 1
        water.save
        puts " Awee You Only Increased Your Water Intake By #{track}!"
        puts "\nDid You Know:
                \nThere are a lot of anecdotal reports about how water can
                \nhelp hydrate the skin and reduce acne.\n\n"
      when choices[1]
        water =  WaterIntake.find_by(id: @user.id)
        track = water.tracker += 2
        water.save
        puts " You have Increased Your Water Intake By #{track}"
        puts "\nDid You Know:
                \nThe brain and heart are composed of 73% water,
                \nand the lungs are about 83% water.\n\n"
      when choices[2]
        water =  WaterIntake.find_by(id: @user.id)
        track = water.tracker += 3
        water.save
        puts "You have increased Your Water Intake By #{track}"
        puts "\nDid You Know:
                \nAdult male needs about 12cups of water per day,
                 \nwhile an adult female needs about 9cups water per day.\n\n"
      when choices[3]
        water =  WaterIntake.find_by(id: @user.id)
        track = water.tracker += 4
        water.save
        puts " You have increased Your Water Intake By #{track}"
        puts "\nDid You Know:
              \nWater is a vital nutrient to the life of every cell, it acts
              \nas a first building material for the body.\n\n"
      when choices[4]
        water =  WaterIntake.find_by(id: @user.id)
        track = water.tracker += 5
        water.save
        puts " You have increased Your Water Intake By #{track}"
        puts "\nDid You Know:
              \nWater regulates our internal body temperature by
              \nsweating and respiration.\n\n"
      when choices[5]
        water =  WaterIntake.find_by(id: @user.id)
        track = water.tracker += 6
        water.save
        puts " You have increased Your Water Intake By #{track}"
        puts "\nDid You Know:
              \nThe carbohydrates and proteins that our bodies use as
              \nfood are metabolized and transported by water in the bloodstream.\n\n"
      when choices[6]
        water =  WaterIntake.find_by(id: @user.id)
        track = water.tracker += 7
        water.save
        puts " You have increased Your Water Intake By #{track}"
        puts "\nDid You Know:
              \nWater acts as a shock absorber for
              \nthe brain, spinal cord, and fetus.\n\n"
      when choices[7]
        water =  WaterIntake.find_by(id: @user.id)
        track = water.tracker += 8
        water.save
        puts " You have increased Your Water Intake By #{track}"
        puts "\nDid You Know:
              \nWater lubricates joints. &
              \nIncreasing water intake can help with constipation,
              \na very common problem.\n\n "
      else
        puts "ERROR FIX ME..IM IN WATER INTAKE"
    end
    main_menu
  end

  def see_progress
  #See progress method should store water  intake amount from input goal
  @water = WaterIntake.find_by(user_id: @user.id)
  

  @c_track = Goal.find_by(id: @water.goal_id)
  puts "\n\nYour Goal is #{@c_track.cup}!!!\n\n"



  puts "\n\nYou've had a total #{@water.tracker} cups so far!\n\n"
  main_menu
  end

  def update_profile
    #user should be able to change name and add spirit spirit_animal
     puts "\n\nWhat Would you Like to Update\n\n"
    options = ["Change Name", "Change Spirit Animal", "Change Age"]
    c = @prompt.select("Choose One!", options)
       `reset`
    case c
      when  options[0]
        puts "\n\nWhat is your new name?\n\n"
        name =  gets.chomp
        @user.name = name
        @user.save
        puts "Ok, got it! Hi #{name.capitalize}!!!"
      when  options[1]
        puts "\n\nWhat is your new Spirit Animal\n\n"
        animal = gets.chomp
        @user.spirit_animal = animal
        @user.save
        puts "\n\n You will now be Known as #{animal.capitalize}..\n\n"
      when  options[2]
        puts "\n\nWas it Your Birthday? What is Your New Age?\n\n"
        age = gets.chomp
        @user.age = age
        @user.save
        puts "\n\nHappy Belated Birthday, You are now #{age} the brave!\n\n"
      else
        puts "\n\nERROR FIX ME..UPDATE PROFILE\n\n"
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
    else
      puts "ERROR FIX ME..IM IN DELETE ACCOUNT"
    end
  end
end
