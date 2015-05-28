require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :description => "MyText",
      :price => 1
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "textarea#order_description[name=?]", "order[description]"

      assert_select "input#order_price[name=?]", "order[price]"
    end
  end
end
