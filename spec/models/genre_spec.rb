require 'spec_helper'

describe Genre do 

  it { should have_many(:videos).through(:video_genres) }

end