class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_parent!

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
    
  end
  
  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  module CreateStudentPos 
   def self.create(student) 
    payload = {first_name: student.first_name,
              last_name:  student.last_name,
              phone: '555-555-5555',
              #tags: [student.grade],
              reference_id: "student_#{student.id}"

            }
    RestClient.post 'https://api.kounta.com/v1/companies/9898/customers.json', payload, {:Authorization => 'Basic VXM1SzVkbjRvbGRabGNvNDp3YzFMWlozVHN4OVlBTklBdm1sUm5KMmRXc0JTU08xRHAxdXpmS01T'}
    end

  end




  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    @student.update_attributes(parent_id: current_parent.id)
    respond_to do |format|
      if @student.save
        format.html { redirect_to dashboard_overview_path, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
        CreateStudentPos.create @student
        
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to dashboard_overview_path,  notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:first_name, :last_name, :grade, :parent_id)
    end
  
end
