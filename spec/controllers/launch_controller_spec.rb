require 'spec_helper'

describe LaunchController do

  describe "POST 'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end
  end

end
