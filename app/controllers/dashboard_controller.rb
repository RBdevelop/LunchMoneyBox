class DashboardController < ApplicationController
  before_action :authenticate_parent!

  def overview
    @orders = current_parent.students.flat_map do |student|
      orders = OrdersController::GetOrdersStudent.get(student)
      OrdersController::GetOrderDetail.get_orders(orders)
    end
    @totals = (@orders.map {|order| order['total']}).inject(:+)
    puts 'these are totals'
    puts @totals
  end

  def activity
    @orders = current_parent.students.flat_map do |student|
      orders = OrdersController::GetOrdersStudent.get(student)
      OrdersController::GetOrderDetail.get_orders(orders)
    end
    @totals = (@orders.map {|order| order['total']}).inject(:+)
    puts 'these are totals'
    puts @totals
  end

  def credits
  end

  def debits
  end

  def reports
  end
end
