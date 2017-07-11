require 'spec_helper'
require 'rails_helper'
require 'rspec/its'

describe Movie do
  describe "add director to existing movie" do
    before do
      @movie = Movie.create()
      @movie.director = "Ridley Scott"
      @movie.save
    end
    subject { @movie }

    its(:director) { should eql "Ridley Scott" }
  end

  describe 'find movies with same director' do
    before :each do
      @fake_movie = double('Movie')
      @fake_movie.stub(:director).and_return('fake_director')
      @fake_movie.stub(:id).and_return('1')
      Movie.stub(:find).with(@fake_movie.id).and_return(@fake_movie)
    end
    describe 'find same director' do
      it 'should find the movies with the same director' do
        Movie.find_similars_by_director('1')
      end
    end
  end
end
