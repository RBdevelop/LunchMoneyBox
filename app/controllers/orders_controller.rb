class OrdersController < InheritedResources::Base
before_action :authenticate_parent!

def index
    @orders = Order.all
  end

  def show
    
  end
  
  
  def new
    @order = Order.new
  end


  def edit
  end

module GetCustomerID
  def self.get(student)
      reference_id = "student_#{student.id}"
        json_string = RestClient.get "https://api.kounta.com/v1/companies/9898/customers.json?reference_id=#{reference_id}", {:Authorization => 'Basic VXM1SzVkbjRvbGRabGNvNDp3YzFMWlozVHN4OVlBTklBdm1sUm5KMmRXc0JTU08xRHAxdXpmS01T'}
        customers = ActiveSupport::JSON.decode(json_string)
        customer = customers.detect { |customer| customer['reference_id'] == reference_id }
          return customer['id']
  end
end

module GetOrdersStudent 
   def self.get(student) 
        id= GetCustomerID.get(student)
        json_string = RestClient.get "https://api.kounta.com/v1/companies/9898/customers/#{id}/orders.json", {:Authorization => 'Basic VXM1SzVkbjRvbGRabGNvNDp3YzFMWlozVHN4OVlBTklBdm1sUm5KMmRXc0JTU08xRHAxdXpmS01T'}
        orders = ActiveSupport::JSON.decode(json_string)
            return orders
    end
end

module GetOrderDetail
  
  def self.get_orders(orders)
  orders.map { |order| get(order) }
  end 
  
  def self.get(order) 
        id= order['id']
        json_string = RestClient.get "https://api.kounta.com/v1/companies/9898/orders/#{id}.json", {:Authorization => 'Basic VXM1SzVkbjRvbGRabGNvNDp3YzFMWlozVHN4OVlBTklBdm1sUm5KMmRXc0JTU08xRHAxdXpmS01T'}
        order = ActiveSupport::JSON.decode(json_string)
            return  order
    end


   # def self.get(order)
   #      price =  order['unit_price']
   #      json_string = RestClient.get "https://api.kounta.com/v1/companies/9898/orders/#{id}.json", {:Authorization => 'Basic VXM1SzVkbjRvbGRabGNvNDp3YzFMWlozVHN4OVlBTklBdm1sUm5KMmRXc0JTU08xRHAxdXpmS01T'}
   #      order = ActiveSupport::JSON.decode(json_string)
   #          return  order
   #  end
end





	def create
    @order = Order.new(order_params)
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

 # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @student.update(order_params)
        format.html { redirect_to dashboard_overview_path,  notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to dashboard_overview_path, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def order_params
      params.require(:order).permit(:description, :price, :date)
    end
end

