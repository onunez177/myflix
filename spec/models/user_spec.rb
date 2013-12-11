require 'spec_helper'

describe User do
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  
  it { should have_many(:reviews) }
  it { should have_many(:queued_videos) }
  it { should have_many(:videos).through(:queued_videos) }
  it { should have_many(:relationships) }
  it { should have_many(:followers) }
  it { should have_many(:following).through(:relationships) }

  it "generates a token when creating a new user" do
    user = Fabricate(:user)
    expect(user.token).not_to eq(nil)
  end
  
  it "normalizes the queue positions for the user" do 
    simon = Fabricate(:user)
    video1 = Fabricate(:video)
    video2 = Fabricate(:video)
    video3 = Fabricate(:video)
    
    QueuedVideo.create(video: video1, user: simon, queue_position: 15)
    QueuedVideo.create(video: video2, user: simon, queue_position: 25)
    QueuedVideo.create(video: video3, user: simon, queue_position: 35) 
    
    simon.normalize_queue
    
    expect(simon.queued_videos.first.queue_position).to eq(1)
  end
  
  it "deactivates a user account" do
    simon = Fabricate(:user)
    simon.deactivate!
    expect(simon).not_to be_active
  end
end