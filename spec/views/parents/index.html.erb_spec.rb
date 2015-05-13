require 'rails_helper'

RSpec.describe "parents/index", type: :view do
  before(:each) do
    assign(:parents, [
      Parent.create!(
        :first_name => "First Name",
        :last_name => "Last Name"
      ),
      Parent.create!(
        :first_name => "First Name",
        :last_name => "Last Name"
      )
    ])
  end

  it "renders a list of parents" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
  end
end
