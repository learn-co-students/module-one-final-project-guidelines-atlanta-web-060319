class Movie < ActiveRecord::Base
    has_many :reviews
    has_many :users, through: :reviews


    def self.search_display_and_create_new_movie
        
        url = 'https://api.themoviedb.org/3/search/movie'
        
        puts "Please type a movie you would like to review."
        sleep 2
        title = gets.chomp.downcase
        sleep 2
                                                                #  search for movie
        response_string = RestClient.get(url, {params: {
            :api_key => '80ba03923e2399197a633c6451cc04a1',
            :query => title
        }})

        response_array = JSON.parse(response_string)['results'].first
    
         title = response_array["title"]
         overview = response_array["overview"]
         release_date = response_array["release_date"]

         puts title
         puts overview
         puts release_date

    
       new_movie =  self.new(title: title, overview: overview, release_date: release_date)

       new_movie.save
        


    end


end