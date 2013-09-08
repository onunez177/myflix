require 'spec_helper' #we want to require this in all tests

describe Video do
  
  it { should have_many(:genres).through(:video_genres) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description)}

  
  it "returns an empty array when title search fails" do
    Video.create(name: 'testing', description: 'testing again')
    results = Video.search_by_name('LOL') 
    expect(results).to be_empty
  end
  
  it "returns one result when only one result has been found" do
    Video.create(name: 'futurama', description: 'testing this')
    Video.create(name: 'derp derp', description: 'another test!')
    Video.create(name: 'family guy', description: 'family guy test')
    
    results = Video.search_by_name('fut')
    expect(results.size).to eq 1
  end

  it "returns multiple results when more than one result has been found" do
    Video.create(name: 'futurama', description: 'testing this')
    Video.create(name: 'derp derp', description: 'another test!')
    Video.create(name: 'futurama part 2', description: 'second futurama result')
    Video.create(name: 'family guy', description: 'family guy test')
    Video.create(name: 'futurama part three!!!', description: 'third futurama result')
    results = Video.search_by_name('fut')
    expect(results.size).to eq 3 
  end
end
