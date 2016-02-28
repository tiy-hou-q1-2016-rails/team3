class MoviesController < ApplicationController
  def list
    @movies = fetch_movies
    @movies = Kaminari.paginate_array(@movies).page(params[:page]).per(15)
  end

  def view
  end

  def chart
      @movies = fetch_movies
  s5=[]
  s4=[]
  s3=[]
  s2=[]
  s1=[]
  s0=[]
  @movies.each do |abc|
    if abc.stars == 5
      s5 << abc
    elsif abc.stars == 4
      s4 << abc
    elsif abc.stars == 3
      s3 << abc
    elsif abc.stars == 2
      s2 << abc
    elsif abc.stars == 1
      s1 << abc
    else
      s0 << abc
    end


  end
  @aa=s5.count
  @bb=s4.count
  @cc=s3.count
  @dd=s2.count
  @ee=s1.count
  end

  def fetch_movies
    sql_query = "SELECT * FROM fandango"
    @movies = ActiveRecord::Base.connection.execute(sql_query)

    @movies = @movies.map do |hash|
      movie = Movie.new
      movie.id = hash["id"].to_i
      movie.name = hash["films"].to_s
      movie.stars = hash["stars"].to_f
      movie.rating = hash["rating"].to_f
      movie.votes = hash["votes"].to_i
      movie
    end
    @movies
  end
end
