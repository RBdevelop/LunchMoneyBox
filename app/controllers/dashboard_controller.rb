class DashboardController < ApplicationController
  before_action :authenticate_parent!

  def overview
  end

  def activity
      @orders = current_parent.students.flat_map do |student|
      orders = OrdersController::GetOrdersStudent.get(student)
      OrdersController::GetOrderDetail.get_orders(orders)
    end
  end

  def credits
  end

  def debits
  end

  def reports
  end
end
