require 'rails_helper'

RSpec.describe "articles/index", type: :view do
  before(:each) do
    assign(:articles, [
      Article.create!(api_id: 88),
      Article.create!(api_id: 77)
    ])
  end

  it "renders a list of articles" do
    render
  end
end
