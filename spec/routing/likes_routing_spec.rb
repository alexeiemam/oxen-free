require "rails_helper"

RSpec.describe LikesController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(post: "articles/1/like").to route_to({"controller"=>"likes", "action"=>"create", "api_id"=>"1"})
    end

  end
end
