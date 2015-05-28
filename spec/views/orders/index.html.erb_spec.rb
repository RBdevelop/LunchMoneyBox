require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :description => "MyText",
        :price => 1
      ),
      Order.create!(
        :description => "MyText",
        :price => 1
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
