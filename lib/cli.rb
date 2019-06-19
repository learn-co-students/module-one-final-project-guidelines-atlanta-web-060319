class CLI

   def run
    @prompt = TTY::Prompt.new
    # @pastel = Pastel.new
    @user = nil
    @movie = nil

    `reset`

    puts ("Welcome to Movie Review!")

    sleep 3
    
    login

    sleep 3

    search_for_movie

    create_movie_review

    most_reviewed_movie

    # highest_rated_movie

    

    
   end
    
   
   
    
   
   
   def login
        puts "What is your name?"
        name = gets.chomp
        @user = User.find_or_create_by(name: name)
   end

   def search_for_movie
    @movie = Movie.search_display_and_create_new_movie
   end

   def create_movie_review
    puts "What did you think about this movie?"
    content = gets.chomp
    puts "Please leave a star rating of 1-5"
    rating = gets.chomp.to_i
    if rating < 1
        rating = 1
    elsif rating > 5
        rating = 5
    end

    review =  Review.create(content: content, rating: rating, user: @user, movie: @movie)


   puts "***************** Here's your review! *******************\n\n"
   puts "\t\tRating:#{review.rating}\n\n"
   puts "\t\tContent:#{review.content}\n\n"
   end


   def reviewed_movies
    Review.all.collect {|review| review.movie}
   end

   def reviewed_movie_titles
    Review.all.collect {|review| review.movie.title}
   end


   def most_reviewed_movie
   freq = reviewed_movie_titles.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
   puts reviewed_movie_titles.max_by { |v| freq[v] }
   end

#    def highest_rated_movie
    
#    end






end