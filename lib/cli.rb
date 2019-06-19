class Cli
    def run
        @prompt = TTY::Prompt.new
        @user = nil 
        @age = nil
        @resty_id = nil
        @user_content = nil
        @user_rating = nil

        # `reset`
        puts "\n\n¡Bienvenidos! Welcome to ¡SalsaRey!\n\nThe place Atlanta goes to optimize their chips and salsa experience in the city they call home. \n\n¡Vamos ATL!\n\n"
        sleep 1
        while true
            main_menu
        end
    end

    # def main_menu    
    #     # choices = %w(
    #     #     'Login/Switch Username' => 1, 
    #     #     'Write a review' => 2, 
    #     #     'Find chips and salsa reviews for restaurants by neighborhood' => 3, 
    #     #     'Find chips and salsa reviews for restaurants by restaurant name' => 4, 
    #     #     'Find ratings for restaurants by restaurant name' => 5,
    #     #     'Exit' => 6
    #     # )
    #     choice = @prompt.select("\n\nHow can we enhance your chips and salsa dining experience?")
    #         menu.choice 'Login/Switch Username', 1
    #         menu.choice 'Write a review', 2
    #         menu.choice 'Find chips and salsa reviews for restaurants by neighborhood', 3
    #         menu.choice 'Find chips and salsa reviews for restaurants by restaurant name', 4
    #         menu.choice 'Find ratings for restaurants by restaurant name ', 5
    #         menu.choice 'Exit', 6
    #     end
        
        # if choice == 1
        #     login
        # elsif choice == 2
        #     write_review
        # elsif choice == 3
        #     find_reviews_by_neighborhood
        # elsif choice == 4
        #     find_reveiws_by_restaurant_name
        # elsif choice == 5
        #     find_ratings_for_restaurants
        # else choice == 6
        #     # `reset`
        #     puts "\n\nThanks for stopping by,and come again soon!\n\n\n\n¡Gracias y Adios!\n\n\n"
        #     exit
        # end

    #     case choice
    #     when 1
    #         login
    #     when 2
    #         write_review
    #     when 3
    #         puts "Please enter the neighborhood you would like to search:"
    #         hood = gets.chomp
    #         find_reviews_by_neighborhood(neighborhood)
    #     when 4
    #         find_reveiws_by_restaurant_name(name)
    #     when 5
    #         find_ratings_for_restaurants_by_name
    #     else 6
    #         puts "\n\nThanks for stopping by,and come again soon!\n\n\n\n¡Gracias y Adios!\n\n\n"
    #         exit
    #     end
    # end

    def main_menu
        # `reset`
        choices = [
            "Login/Switch Username",
            "Write a review", 
            "Find chips and salsa reviews for restaurants by neighborhood", 
            "Find chips and salsa reviews for restaurants by restaurant name", 
            "Find ratings for restaurants based on reviews",
            "Exit"
        ]
        choice = @prompt.enum_select("\n\nHow can we enhance your chips and salsa dining experience?", choices)
    
        if choice == choices[0]
          login
        elsif choice == choices[1]
          write_review
        elsif choice == choices[2]
          find_reviews_by_neighborhood
        elsif choice == choices[3]
            find_reveiws_by_restaurant_name
        elsif choice == choices[4]
            find_ratings_for_restaurants
        elsif choice == choices[5]
            puts "\n\nThanks for stopping by,and come again soon!\n\n\n\n¡Gracias y Adios!\n\n\n"
            exit
        end
    end

    def login
        puts "What is your name?"
        name = gets.chomp
        puts "How old are you?"
        age = gets.chomp
        puts "Welcome #{name}!"
        @user = User.find_or_create_by(name: name, age: age)
    end

    def select_restaurant_for_review
        puts "Please provide a chips and salsa review for the restaurant of your choice.\n
        First, you will need to indicate which restaruant you would like to review by name:\n"
        rest_name = gets.chomp
        puts "Please provide the neighborhood where this restaruant is located:"
        rest_hood = gets.chomp
        resty = Restaurant.find_or_create_by(name: rest_name, neighborhood: rest_hood)
        @resty_id = resty.id
    end


    def get_user_review_content
        puts "\nNext, please provide a review highlighting whatever aspects of the chips and salsa were worth mentioning. 
        \nWhile the restaruant experience overall can come into play, it is the purpose of this reveiw to focus on aspects that relate back direclty to the chips and salsa user experience:\n"
        @user_content = gets.chomp
    end

    def give_rating
        @user_rating = @prompt.select(
            "Last, please take the time to rate your chips and salsa experience on a scale of 1 to 5, with 5 being the best rating you can assign:", 
            %w(1 2 3 4 5)
            )
    end

    def write_review    
        if @user
            puts "\n\n"
            select_restaurant_for_review
            puts "\n\n"
            get_restaurant_neighborhood
            puts "\n\n"
            get_user_review_content
            puts "\n\n"
            give_rating
            Review.create(user_id: @user.id, restaurant_id: @resty_id, content: @user_content, rating: @user_rating)
        else
            puts "Please login to write a review!"
            # sleep 3
        end
       
    end

    def reviews
        Review.all.select {|r| r.restaurant_id == self.id}
    end
    
    def find_reviews_by_neighborhood
        puts "What neighborhood are you trying to search:"
        neighborhood = gets.chomp
        x = Restaurant.all.select {|rest| rest.neighborhood == neighborhood}
        y = x.map do |rest|
            rest.reviews
            end
        z = y.map do |r|
            binding.pry
            r[]
            end
        return z
    end

    def find_ratings_for_restaurants_by_name
        puts "Under Construction" 
    end



end