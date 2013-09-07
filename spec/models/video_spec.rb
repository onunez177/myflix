require 'spec_helper' #we want to require this in all tests

describe Video do
  
  it { should have_many(:genres).through(:video_genres) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description)}
 
end
