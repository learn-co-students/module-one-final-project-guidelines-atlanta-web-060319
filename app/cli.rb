
class CLI
  
  def run
    @prompt = TTY::Prompt.new
    
    puts "Welcome to Hydrate Yourself"
    puts "\n
    MAIN MENU
    \n"
    puts "
    1.Login
    2.Take Quiz
    3.Input Water Intake
    \n"
  end

end
