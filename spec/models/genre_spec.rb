# TODO
# implement factory girl on next set of assignments and DRY up test code

require 'spec_helper'

describe Genre do 

  it { should have_many(:videos).through(:video_genres) }

  it "returns the 6 most recent videos of a genre" do
    Video.create(name: 'futurama', description: 'testing this')
    Video.create(name: 'derp derp', description: 'another test!')
    Video.create(name: 'futurama part 2', description: 'second futurama result')
    Video.create(name: 'family guy', description: 'family guy test')
    Video.create(name: 'futurama part three!!!', description: 'third futurama result')
    Video.create(name: 'test 6', description: 'test 6')
    
    Genre.create(name: 'Comedy')
    g = Genre.first
    v = Video.all
    
    v.each do |v|
      v.genres << g
    end
   
    g = g.videos.limit(6).reverse
    expect(g.first.name).to eq 'test 6'
  end
  
  it "only returns the 6 most recent videos" do
    Video.create(name: 'futurama', description: 'testing this')
    Video.create(name: 'derp derp', description: 'another test!')
    Video.create(name: 'futurama part 2', description: 'second futurama result')
    Video.create(name: 'family guy', description: 'family guy test')
    Video.create(name: 'futurama part three!!!', description: 'third futurama result')
    Video.create(name: 'test 6', description: 'test 6')
    Video.create(name: 'test 7', description: 'test 7')
 
    Genre.create(name: 'Comedy')
  
    g = Genre.first
    v = Video.all
    
    v.each do |v|
      v.genres << g
    end
   
    g = g.videos.limit(6).reverse
    expect(g.size).to eq 6
  end
end