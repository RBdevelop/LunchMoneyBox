require 'rails_helper'

RSpec.describe "parents/new", type: :view do
  before(:each) do
    assign(:parent, Parent.new(
      :first_name => "MyString",
      :last_name => "MyString"
    ))
  end

  it "renders new parent form" do
    render

    assert_select "form[action=?][method=?]", parents_path, "post" do

      assert_select "input#parent_first_name[name=?]", "parent[first_name]"

      assert_select "input#parent_last_name[name=?]", "parent[last_name]"
    end
  end
end
