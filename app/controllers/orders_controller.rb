class OrdersController < InheritedResources::Base
before_action :authenticate_parent!

module CreateOrderPos 
   def self.create(order) 
    payload = {total: order.price,
              id:  order.id,
              product: order.description,
              }
    RestClient.get 'GET /v1/companies/9898/customers/#{student.id}/orders.json', payload, {:Authorization => 'Basic VXM1SzVkbjRvbGRabGNvNDp3YzFMWlozVHN4OVlBTklBdm1sUm5KMmRXc0JTU08xRHAxdXpmS01T'}
    end

  end

	def create
    @order = Order.new(Order_params)
    @order.update_attributes(parent_id: current_parent.id)
    respond_to do |format|
      if @order.save
        format.html { redirect_to dashboard_overview_path, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
        CreateStudentPos.create @order
        
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end



  private

    def order_params
      params.require(:order).permit(:description, :price, :date)
    end
end

