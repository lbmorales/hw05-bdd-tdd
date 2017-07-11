require 'spec_helper'
require 'rails_helper'
require 'rspec/its'

describe MoviesController do
  describe 'Add director' do
    before :each do
      @movie = double(Movie, title: 'Star Wars', director: 'director', id: '1')
      Movie.stub(:find).with('1').and_return(@movie)
    end
    subject { @movie }
    its(:director) { expect eq 'director' }
    it 'should call method update_attributes and redirect to the same page' do
      pending(@movie.stub(:update_attributes!).and_return(true))
      pending(put :update, { id: '1', movie: @movie })
      pending(response.should redirect_to(movie_path(@movie)))
    end
  end
  describe 'when every thing it is ok' do
    before :each do
      @movie = double(Movie, title: 'Star Wars', director: 'director', id: '1')
      Movie.stub(:find).with('1').and_return(@movie)
    end
    it 'should generate the route find movie path for similars by director' do
      #   { post: movie_find_path(1) }.should route_to(controller: 'movies', action: 'find', movie_id: '1')
    end
    it 'sholud call the model method that finds similar movies' do
      @fake_results = [double('movie1'), double('movie2')]
      expect(Movie).to receive(:find_similars_by_director).with("director").and_return(@fake_results)
      get :find, {:movie_id => 1}
    end
    it 'should render the results of find by similar dorector in the find template' do
      Movie.stub(:find_similars_by_director).with('director').and_return(@movie)
      get :find, {:movie_id => 1}
      response.should render_template('find')
      assigns(:similar_movies).should eq(@movie)
    end
  end
  describe 'sad path' do
    before :each do
      @movie = double(Movie, title: 'Star Wars', director: nil, id: '1')
      Movie.stub(:find).with('1').and_return(@movie)
    end
    it 'should generate the route find movie path for similars by director' do
      # { post: movie_find_path('1') }.should route_to(controller: 'movies', action: 'find', movie_id: '1')
    end
    it 'should select the index template and show a flash message' do
      get :find, {movie_id: 1}
      response.should redirect_to(movies_path)
      flash[:notice].should_not be_blank
    end
  end
end
