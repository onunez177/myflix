require 'spec_helper'

describe QueuedVideo do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  
  describe "video_name" do   #this test fails, but the implementation code works
    it "returns the name of the associated video" do
      video = Fabricate(:video)
      queued_video = Fabricate(:queued_video)
      expect(queued_video.video_name).to eq('Test1')
    end
  end
end