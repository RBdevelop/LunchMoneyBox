require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :description => "MyText",
      :price => 1
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "textarea#order_description[name=?]", "order[description]"

      assert_select "input#order_price[name=?]", "order[price]"
    end
  end
end
