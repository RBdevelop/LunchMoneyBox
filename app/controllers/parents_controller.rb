class ParentsController < InheritedResources::Base

  private

    def parent_params
      params.require(:parent).permit(:first_name, :last_name)
    end
end

