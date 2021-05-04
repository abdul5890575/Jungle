class Admin::CategoriesController < ApplicationController
  http_basic_authenticate_with :name => "Jungle", :password => "book"
  
    def index
        @categories =  Category.all
    end

    def new
      @categories = Category.new
    end

    def create
      @categories = Category.new(categories_params)
       
        if @categories.save
          redirect_to [:admin , :categories]
        else
          render 'new'
        end
      end

    private
        def categories_params
        params.require(:category).permit(:name)
        end
   
end
