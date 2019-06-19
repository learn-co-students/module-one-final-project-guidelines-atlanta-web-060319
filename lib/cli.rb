class Cli
    def run
        `reset`
        puts "Welcome to ¡SalsaRey!\n\nThe place Atlanta goes to optimize their chips and salsa experience in the city they call home. ¡Vamos ATL!\n\n"
        sleep 3
        main_menu
    end

    def main_menu
        prompt = TTY::Prompt.new
        prompt.select("How can we enhance your chips and salsa dining experience?") do |menu|
            menu.choice 'Find chips and salsa reviews for restaurants by neighborhood', 1
            menu.choice 'Find chips and salsa reviews for restaurants by restaurant name', 2
            menu.choice 'Find ratings for restaurants based on reviews', 3
            menu.choice 'Write a review'
            menu.choice 'Exit'
        end

    end



end