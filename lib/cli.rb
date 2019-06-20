class Cli
    def run
        @prompt = TTY::Prompt.new
        @user = nil 
        @age = nil
        @resty_id = nil
        @user_content = nil
        @user_rating = nil

        `reset`
        puts "\n\n¡Bienvenidos! Welcome to ¡SalsaRey!\n\nThe place Atlanta goes to optimize their chips and salsa experience in the city they call home. \n\n¡Vamos ATL!\n\n"
        sleep 1
        while true
            main_menu
        end
    end

    def main_menu    
        choice = @prompt.select("\n\nHow can we enhance your chips and salsa dining experience?", cycle: true) do |menu|
            menu.choice 'Login/Switch Username', 1
            menu.choice 'Write a review', 2
            menu.choice 'Find chips and salsa reviews for restaurants by neighborhood', 3
            menu.choice 'Find chips and salsa reviews for restaurants by restaurant name', 4
            menu.choice 'Find ratings for restaurants by restaurant name ', 5
            menu.choice 'Exit', 6
        end
        
        if choice == 1
            login
        elsif choice == 2
            write_review
        elsif choice == 3
            find_reviews_by_neighborhood
        elsif choice == 4
            find_reviews_by_restaurant_name
        elsif choice == 5
            avg_rating_by_restaurant_name
        else choice == 6
            # `reset`
            puts "\n\nTHANKS FOR STOPPING BY, AND COME AGAIN SOON!\n\n\n\n¡GRACIAS y ADIOS!\n\n\n"
            exit
        end
    end


    def login
        puts "What is your name?"
        name = gets.chomp
        puts "How old are you?"
        age = gets.chomp
        puts "Welcome #{name.split(/ |\_/).map(&:capitalize).join(" ")}!"
        @user = User.find_or_create_by(name: name.downcase, age: age)
    end

    def select_restaurant_for_review
        puts "Please provide a chips and salsa review for the restaurant of your choice.\nFirst, you will need to indicate which restaruant you would like to review by name:\n"
        rest_name = gets.chomp
        puts "Please provide the neighborhood where this restaruant is located:"
        rest_hood = gets.chomp
        resty = Restaurant.find_or_create_by(name: rest_name.downcase, neighborhood: rest_hood.downcase)
        @resty_id = resty.id
    end


    def get_user_review_content
        puts "\nNext, please provide a review highlighting whatever aspects of the chips and salsa were worth mentioning.\nWhile the restaruant experience overall can come into play, it is the purpose of this reveiw to focus on aspects that relate back direclty to the chips and salsa user experience:\n"
        @user_content = gets.chomp
    end

    def give_rating
        @user_rating = @prompt.select("Last, please take the time to rate your chips and salsa experience on a scale of 1 to 5, with 5 being the best rating you can assign:", %w(1 2 3 4 5))
    end

    def write_review    
        if @user
            puts "\n\n"
            select_restaurant_for_review
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

    def neighborhoods
        Restaurant.all.select {|rest| rest.neighborhood == self.neighborhood}
    end

    def reviews
        Review.all.select {|r| r.restaurant_id == self.id}
    end
    
    def find_reviews_by_neighborhood
        puts "What neighborhood are you trying to search?"
        neighborhood = gets.chomp
        if Restaurant.exists?(neighborhood: neighborhood.downcase)
            x = Restaurant.all.select {|rest| rest.neighborhood == neighborhood.downcase}
            y = x.map do |rest|
                    rest.reviews
                end
            puts "\nHere are your results:\n"
            z = y.map do |r|
                a = Restaurant.find(r[0].restaurant_id)
                puts "\n\nRESTAURANT: #{a.name.split(/ |\_/).map(&:capitalize).join(" ")}\nREVIEW: #{r[0].content}\nRATING: #{r[0].rating}\n\n\n"
                end
        else
            puts "Sorry, but there are no reviews available for restaurants in that area.\nPerhaps you could write one for us?" 
        end
    end

    def find_reviews_by_restaurant_name
        puts "What restaurant are you trying to find?"
        name = gets.chomp
        puts "What neighborhood is this restaurant in, so we can help find the right location?"
        hood = gets.chomp
        x = Restaurant.find_by(name: name.downcase, neighborhood: hood.downcase)
        if x
            y = x.reviews
            if y
                puts "\nHere are your results:\n"
                z = y.map do |r|
                    a = Restaurant.find(r.restaurant_id)
                    puts "\n\nRESTAURANT: #{a.name.split(/ |\_/).map(&:capitalize).join(" ")}\nREVIEW: #{r.content}\nRATING: #{r.rating}\n\n\n"
                    end
            else
                puts "Sorry, but there are no reviews available for that restaurant, or restaurant location.\nPerhaps you could write one for us?"
            end
        else
            puts "Sorry, but there are no reviews available for that restaurant, or restaurant location.\nPerhaps you could write one for us?"
        end
    end

    def avg_rating_by_restaurant_name
        rating_array = []
        puts "What restaurant would you like the average chips and salsa rating for?"
        name = gets.chomp
        puts "What neighborhood is this restaurant in, so we can help find the right location?"
        hood = gets.chomp
        x = Restaurant.find_by(name: name.downcase, neighborhood: hood.downcase)
        if x
            y=x.reviews
            
            if y.empty? == false
                y.each do |r|
                    rating_array << r.rating
                end
                rating_avg = rating_array.inject{ |sum, el| sum + el }.to_f / rating_array.size
                puts "\nHere are your results:\n\n\nRESTAURANT: #{x.name.split(/ |\_/).map(&:capitalize).join(" ")}\nAVG RATING: #{rating_avg}\n\n\n"
            else 
                puts "Sorry, but there are no reviews available for that restaurant, or restaurant location.\nPerhaps you could write one for us?"
            end
        else
            puts "Sorry, but there are no reviews available for that restaurant, or restaurant location.\nPerhaps you could write one for us?"
        end
    end

    


end