class KittensController < ApplicationController

  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def create
    @kitten = Kitten.create(post_params)

    if @kitten.save
      flash[:success] = "Saved!"
      redirect_to @kitten
    else
      flash.now[:danger] = "Save failed."
      render :new
    end
  end

  def new
    @kitten = Kitten.new
  end

  def edit
    @kitten = Kitten.find_by_id(params[:id])
  end

  def show
    @kitten = Kitten.find_by_id(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def update
    @kitten = Kitten.find_by_id(params[:id])
    @kitten.update(post_params)

    if @kitten.save
      flash[:success] = "Updated!"
      redirect_to @kitten
    else
      flash.now[:danger] = "Update failed."
      render :new
    end
  end

  def destroy
    Kitten.find_by_id(params[:id]).destroy
    flash[:success] = "Kitten destroyed."
    redirect_to kittens_path
  end

  private

    def post_params
      params.require(:kitten).permit(:name, :age, :cuteness, :softness)
    end
end
