require 'spec_helper'

describe QueuedVideo do
  it { should belong_to(:user) }
  it { should belong_to(:video) }
  
  describe "#video_name" do
    it "returns the name of the associated video" do
      video = Fabricate(:video, name: "Test1")
      queued_video = Fabricate(:queued_video, video: video) #associate this item with the video
      expect(queued_video.video_name).to eq("Test1")
    end
  end
end