require 'rails_helper'

RSpec.describe "articles/index", type: :view do
  before(:each) do
    assign(:articles, [
      Article.create!(api_id: 2),
      Article.create!(api_id: 3)
    ])
  end

  it "renders a list of articles" do
    render
  end
end
