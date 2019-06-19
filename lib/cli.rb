class Cli
    def run
        @prompt = TTY::Prompt.new
        @user = nil 

        `reset`
        puts "\n\n¡Bienvenidos! Welcome to ¡SalsaRey!\n\nThe place Atlanta goes to optimize their chips and salsa experience in the city they call home. \n\n¡Vamos ATL!\n\n"
        sleep 5
        while true
            main_menu
        end
    end

    def main_menu
        `reset`
        choice = @prompt.select("\n\nHow can we enhance your chips and salsa dining experience?") do |menu|
            menu.choice 'Login/Switch Username', 1
            menu.choice 'Write a review', 2
            menu.choice 'Find chips and salsa reviews for restaurants by neighborhood', 3
            menu.choice 'Find chips and salsa reviews for restaurants by restaurant name', 4
            menu.choice 'Find ratings for restaurants based on reviews', 5
            menu.choice 'Exit', 6
        end

        case choice
        when 1
            login
        when 2
            write_review
        when 3
            find_reviews_by_neighborhood
        when 4
            find_reveiws_by_restaurant_name
        when 5
            find_ratings_for_restaurants
        when 6
            `reset`
            puts "\n\nThanks for stopping by,and come again soon!\n\n\n\n¡Gracias y Adios!\n\n\n"
            exit
    end

    def login
        puts "What is your name?"
        name = gets.chomp
        @user = User.find_or_create_by(name: name)
    end

    def select_restaruant_for_review
        puts 
        "Please provide a chips and salsa review for the restaurant of your choice.\n
        First, you will need to indicate which restaruant you would like to review by name:\n"
        restaruant_name = gets.chomp
    end

    def get_user_review_content
        puts
        "\nNext, please provide a review highlighting whatever aspects of the chips and salsa were worth mentioning. 
        \nWhile the restaruant experience overall can come into play, it is the purpose of this reveiw to focus on aspects that relate back direclty to the chips and salsa user experience:\n"
        user_content = gets.chomp
    end

    def give_rating
        prompt.select(
            "Last, please take the time to rate your chips and salsa experience on a scale of 1 to 5, with 5 being the best rating you can assign:", 
            %w(1 2 3 4 5)
            )
        end
    end

    def write_review
        puts "Under Construction"
        # if @user
        #     select_restaruant_for_review
        #     get_user_review_content
        #     give_rating
        # else
        #     puts 
        #     "Please login to write a review!"
        #     sleep 3
        # end
    end

    
    def find_reviews_by_neighborhood(neighborhood)
        x = Restaurant.all.select {|rest| rest.neighborhood == neighborhood}
        x.map do |rest|
            binding.pry
            rest.reviews
        end

    end

    



end