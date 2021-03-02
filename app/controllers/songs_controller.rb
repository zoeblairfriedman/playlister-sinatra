require 'rack-flash'

class SongsController < ApplicationController


get '/songs' do
    erb :'songs/index'
end

get '/songs/new' do
    @genres = Genre.all
    erb :'songs/new'
end

post '/songs' do
    @song = Song.create(params[:song])
    artist = Artist.find_or_create_by(params[:artist])
    @song.artist = artist
    if !params[:genres].empty?
       @song.genre_ids = params[:genres]
    end
    @song.save
    flash[:notice] = "Successfully created song."
    redirect("/songs/#{@song.slug}")
end

get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
end

get '/songs/:slug/edit' do
    @genres = Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
end

patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    if !params[:artist][:name].empty?
        artist = Artist.find_or_create_by(params[:artist])
        
        @song.artist = artist
    end
    if !params[:genres].empty?
        @song.genre_ids = params[:genres]
     end

    if @song.save 
        flash[:notice] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end
end



end