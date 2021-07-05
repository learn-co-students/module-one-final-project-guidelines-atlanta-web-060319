class Cli
    def run
        @prompt = TTY::Prompt.new
        @user = nil 
        @age = nil
        @resty_id = nil
        @user_content = nil
        @user_rating = nil
        @pastel = Pastel.new

        `reset`
        puts "\n\n"+@pastel.green.bold("¡Bienvenidos!")+" "+@pastel.red.bold("Welcome to")+" "+ @pastel.green.bold("¡")+@pastel.red.bold("Salsa")+@pastel.green.bold("Rey")+@pastel.red.bold("!")+@pastel.red.bold("\n\nThe place ")+@pastel.green.bold("ATLANTA ")+@pastel.red.bold("goes to optimize their chips and salsa experience in the city they call home.\n\n")+@pastel.red.bold("¡")+@pastel.black.bold("V")+@pastel.yellow.bold("a")+@pastel.red.bold("m")+@pastel.black.bold("o")+@pastel.yellow.bold("s")+" "+@pastel.red.bold("A")+@pastel.black.bold("T")+@pastel.yellow.bold("L")+@pastel.red.bold("!")+"\n\n"
        sleep 2
        while true
            main_menu
        end
    end

    def main_menu    
        choice = @prompt.select("\n\n"+@pastel.red.bold("This app is all about gathering information on where to find the best chips and salsa experience in Atlanta.\n\n")+@pastel.green.bold("The information, rating, and reviews collected here focus specifically on the chips and salsa at a restaurant.\nOther apsects of the restaurant may be covered in the body of a review, but the focus should stay on chips and salsa.\nRatings are assigned according to the chips and salsa experience, and not the restaurant experience as a whole.\n\n")+@pastel.red.bold("How can we enhance your chips and salsa dining experience?\n"), cycle: true, per_page: 7) do |menu|
            menu.choice '* Login/Switch Username', 1
            menu.choice '* Write a review', 2
            menu.choice '* Find a list of restaurants in your area that have reviews', 3
            menu.choice '* Find reviews for restaurants by entering the restaurant name', 4
            menu.choice '* Find reviews for restaurants by entering the neighborhood you want to search', 5
            menu.choice '* Find ratings for restaurants by entering the restaurant name', 6
            menu.choice '* Exit', 7
        end
        
        if choice == 1
            login
        elsif choice == 2
            write_review
        elsif choice == 3
            get_all_restaurants_in_neighborhood
        elsif choice == 4
            find_reviews_by_restaurant_name
        elsif choice == 5
            find_reviews_by_neighborhood 
        elsif choice == 6
            avg_rating_by_restaurant_name
        else choice == 7
            `reset`
            puts @pastel.green.bold("\n\nThanks for stopping by...\n\n ")+@pastel.green.bold("      ¡")+@pastel.red.bold("Salsa")+@pastel.green.bold("Rey")+@pastel.red.bold("!")+@pastel.green.bold("\n\nPlease come again soon!\n\n\n\n")+@pastel.green.bold("¡")+@pastel.red.bold("GRACIAS")+" "+@pastel.green.bold("y")+" "+@pastel.red.bold("ADIOS")+@pastel.green.bold("!")+"\n\n\n"
            exit
        end
    end


    def login
        puts @pastel.red.bold("\nWhat is your name?")
        name = gets.chomp
        puts @pastel.red.bold("\nHow old are you?")
        age = gets.chomp
        if @user = User.find_by(name: name.downcase, age: age)
            puts @pastel.red.bold("\nWelcome back ")+@pastel.green.bold("#{name.split(/ |\_/).map(&:capitalize).join(" ")}")+@pastel.red.bold("!")
        else
            @user = User.create(name: name.downcase, age: age) 
            puts @pastel.red.bold("\nWelcome ")+@pastel.green.bold("#{name.split(/ |\_/).map(&:capitalize).join(" ")}")+@pastel.red.bold("!")
        end
        puts "\n======================================================================================================================="
    end

    def select_restaurant_for_review
        puts @pastel.red.bold("\nPlease provide a chips and salsa review for the restaurant of your choice.\nFirst, you will need to indicate which restaruant you would like to review by name")+":\n"
        rest_name = gets.chomp
        puts @pastel.red.bold("\nPlease provide the neighborhood where this restaurant is located")+":"
        rest_hood = gets.chomp
        resty = Restaurant.find_or_create_by(name: rest_name.downcase, neighborhood: rest_hood.downcase)
        @resty_id = resty.id
    end


    def get_user_review_content
        puts @pastel.red.bold("\nNext, please provide a review highlighting whatever aspects of the chips and salsa were worth mentioning.\nWhile the restaruant experience overall can come into play, it is the purpose of this reveiw to focus on aspects that relate back direclty to the chips and salsa user experience")+":\n"
        @user_content = gets.chomp
    end

    def give_rating
        @user_rating = @prompt.select(@pastel.red.bold("\nLast, please take the time to rate your chips and salsa experience (and not the restaurant as a whole).\nRatings are done on a scale of 1 to 5, with 5 being the best rating you can assign")+":", %w(1 2 3 4 5))
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
            puts @pastel.red.bold("\nPlease login to write a review!")
        end
        puts "\n======================================================================================================================="
    end

    def neighborhoods
        Restaurant.all.select {|rest| rest.neighborhood == self.neighborhood}
    end

    def reviews
        Review.all.select {|r| r.restaurant_id == self.id}
    end 

    
    def find_reviews_by_neighborhood
        puts @pastel.red.bold("\nWhat neighborhood are you trying to search?")
        neighborhood = gets.chomp
        if Restaurant.exists?(neighborhood: neighborhood.downcase)
            x = Restaurant.all.select {|rest| rest.neighborhood == neighborhood.downcase}
            y = x.map do |rest|
                    rest.reviews
                end
            puts "\n"+@pastel.green.bold("Here")+" "+@pastel.red.bold("are")+" "+@pastel.green.bold("your")+" "+@pastel.red.bold("results")+":\n"
            z = y.map do |r|
                a = Restaurant.find(r[0].restaurant_id)
                b = User.find(r[0].user_id)
                puts "\n\n"+@pastel.green.bold("RESTAURANT")+": #{a.name.split(/ |\_/).map(&:capitalize).join(" ")}\n"+@pastel.red.bold("REVIEW")+": #{r[0].content}\n"+@pastel.green.bold("RATING")+": #{r[0].rating}\n"+@pastel.red.bold("REVIEWED BY")+": #{b.name.split(/ |\_/).map(&:capitalize).join(" ")}\n\n"
                end
        else
            puts @pastel.red.bold("\nSorry, but there are no reviews available for restaurants in that area.\nPerhaps you could write one for us?") 
        end
        puts "\n======================================================================================================================="
    end

    def find_reviews_by_restaurant_name
        puts @pastel.red.bold("\nWhat restaurant are you trying to find?")
        name = gets.chomp
        puts @pastel.red.bold("\nWhat neighborhood is this restaurant in, so we can help find the right location?")
        hood = gets.chomp
        x = Restaurant.find_by(name: name.downcase, neighborhood: hood.downcase)
        if x
            y = x.reviews
            if y
                puts "\n"+@pastel.green.bold("Here")+" "+@pastel.red.bold("are")+" "+@pastel.green.bold("your")+" "+@pastel.red.bold("results")+":\n"
                z = y.map do |r|
                    a = Restaurant.find(r.restaurant_id)
                    b = User.find(r.user_id)
                    puts "\n\n"+@pastel.green.bold("RESTAURANT")+": #{a.name.split(/ |\_/).map(&:capitalize).join(" ")}\n"+@pastel.red.bold("REVIEW")+": #{r.content}\n"+@pastel.green.bold("RATING")+": #{r.rating}\n"+@pastel.red.bold("REVIEWED BY")+": #{b.name.split(/ |\_/).map(&:capitalize).join(" ")}\n\n"
                    end
            else
                puts @pastel.red.bold("\nSorry, but there are no reviews available for that restaurant, or restaurant location.\nPerhaps you could write one for us?")
            end
        else
            puts @pastel.red.bold("\nSorry, but there are no reviews available for that restaurant, or restaurant location.\nPerhaps you could write one for us?")
        end
        puts "\n======================================================================================================================="
    end

    def avg_rating_by_restaurant_name
        rating_array = []
        puts @pastel.red.bold("\nWhat restaurant would you like the average chips and salsa rating for?")
        name = gets.chomp
        puts @pastel.red.bold("\nWhat neighborhood is this restaurant in, so we can help find the right location?")
        hood = gets.chomp
        x = Restaurant.find_by(name: name.downcase, neighborhood: hood.downcase)
        if x
            y=x.reviews
            
            if y.empty? == false
                y.each do |r|
                    rating_array << r.rating
                end
                rating_avg = rating_array.inject{ |sum, el| sum + el }.to_f / rating_array.size
                puts "\n"+@pastel.green.bold("Here")+" "+@pastel.red.bold("are")+" "+@pastel.green.bold("your")+" "+@pastel.red.bold("results")+":\n"+@pastel.green.bold("RESTAURANT")+": #{x.name.split(/ |\_/).map(&:capitalize).join(" ")}\n"+@pastel.red.bold("AVG RATING")+": #{rating_avg}\n\n\n"
            else 
                puts @pastel.red.bold("\nSorry, but there are no reviews available for that restaurant, or restaurant location.\nPerhaps you could write one for us?")
            end
        else
            puts @pastel.red.bold("\nSorry, but there are no reviews available for that restaurant, or restaurant location.\nPerhaps you could write one for us?")
        end
        puts "\n======================================================================================================================="
    end

    def get_all_restaurants_in_neighborhood
        puts @pastel.red.bold("\nWhat neighborhood are you trying to search?")
        neighborhood = gets.chomp
        if Restaurant.exists?(neighborhood: neighborhood.downcase)
            x = Restaurant.all.select {|rest| rest.neighborhood == neighborhood.downcase}.uniq
            puts "\n"+@pastel.green.bold("Here")+" "+@pastel.red.bold("are")+" "+@pastel.green.bold("your")+" "+@pastel.red.bold("results")+":\n"
            x.map do |rest|
                puts rest.name.split(/ |\_/).map(&:capitalize).join(" ")
            end
        else
            puts @pastel.red.bold("\nSorry, but we have no chips and salsa reviews for restaurants in that area.\nPerhaps you could write one for us?") 
        end
        puts "\n======================================================================================================================="
    end


end