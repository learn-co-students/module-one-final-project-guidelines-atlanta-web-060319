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
    choices = ["Take Quiz", "Input WaterIntake", "See Goal", "Update Profile", "Delete Account"]
    a = @prompt.multi_select("Select Choice?", choices)

    case choices
      when choices[0]
        take_quiz
      when choices[1]
        input_water_intake
      when choices[2]
        see_goal
      when choices[3]
        update_profile
      when choices[4]
        delete_account
    end
    binding.pry
  end

  def take_quiz
    ##build five questions
    @counter = 0
    puts " 1. How much water do you currently drink?"
    choices = ["One Cup Daily", "Three Cups Daily", "My Insides Are A Desert"]
    @prompt.multi_select("Select Amount?", choices)

    # case
    # when choices[0]
    #   @counter += 1
    # when choices[1]
    #   @counter += 2
    # when choices[2]
    #   @counter += 3
    # end

    # puts " 2. How much water would you like to be drinking a day?"
    # choices_two = ["Three Cups Daily", "Six Cups Daily", "Eight Cups Daily"]
    # @prompt.multi_select("Select Amount?", choices_two)
    #
    # case
    # when choices_two[0]
    #   @counter += 1
    # when choices_two[1]
    #   @counter += 2
    # when choices_two[2]
    #   @counter += 3
    # end
    #
    # puts " 3. What do you wish to gain from Hydrate Your Life?"
    # choices_three = ["Better Health", "More Energy", "Finally Be Water Healthy"]
    # @prompt.multi_select("Select Amount?", choices_three)
    #
    # case
    # when choices_thre[0]
    #   @counter += 1
    # when choices_three[1]
    #   @counter += 2
    # when choices_three[2]
    #   @counter += 3
    # end
    #
    # if @counter == (1..4)
    #   water = WaterIntake.create(:user_id @user.id, :goal_id @first.id, :tracker 0)
    # elsif @counter == (5..6)
    #   water = WaterIntake.create(:user_id @user.id, :goal_id @second.id, :tracker 0)
    # else @counter == (7..10)
    #   water = WaterIntake.create(:user_id @user.id, :goal_id @third.id, :tracker 0)
    # end
  end

  def login
    puts "Tell Us Your Name!"
    name = gets.chomp
    @user = User.find_or_create_by(name: name)
  end

  def goals
    @first = Goal.create(cup: 400)
    @second = Goal.create(cup: 600)
    @third = Goal.create(cup: 800)
  end
end
