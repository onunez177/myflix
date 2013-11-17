require 'spec_helper'

describe Invite do

 it { should belong_to(:user) }
 
 it { should validate_presence_of(:new_user_email) }
 
end