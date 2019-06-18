
class CLI

  def run
    @prompt = TTY::Prompt.new
    puts "Welcome to Hydrate Yourself"
    response = @prompt.select("What would you like to do?", %w(Login CreateAccount Exit))

    # case response
    # when re
  end

  def login

  end

  def main_menu
    ##after the user has logged in
    puts "1. Take Quiz
          2. Input WaterIntake
          3. See Goal
          4. Update Profile
          5. Delete Account
    "
  end
end
