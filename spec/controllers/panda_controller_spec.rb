require 'spec_helper'

describe PandaController do

  describe "GET 'notifications'" do
    it "returns http success" do
      get 'notifications'
      response.should be_success
    end
  end

end
