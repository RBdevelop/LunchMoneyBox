class DashboardController < ApplicationController
  before_action :authenticate_parent!

  def overview
  end

  def activity
    #@charges = current_parent.charges

  end

  def credits
  end

  def debits
  end

  def reports
  end
end
