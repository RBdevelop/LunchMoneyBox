class AddParentToStudents < ActiveRecord::Migration
  def change
    add_reference :students, :parent, index: true
    add_foreign_key :students, :parents
  end
end
