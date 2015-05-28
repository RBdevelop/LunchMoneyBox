class OrdersController < InheritedResources::Base

  private

    def order_params
      params.require(:order).permit(:description, :price, :date)
    end
end

