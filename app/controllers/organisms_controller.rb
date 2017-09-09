class OrganismsController < ApplicationController
  before_action :set_organism, only: [:show, :edit, :update, :destroy]

  def index
    @organisms = policy_scope(Organism).order("lower(name)")
  end

  def show
		authorize @organism
  end

  def new
		authorize Organism
    @organism = Organism.new
  end

  def edit
		authorize @organism
  end

  def create
    @organism = Organism.new(organism_params)
		authorize @organism
		@organism.user = current_user

    respond_to do |format|
      if @organism.save
        format.html { redirect_to @organism, notice: 'Organism was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organism }
      else
        format.html { render action: 'new' }
        format.json { render json: @organism.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
		authorize @organism
    respond_to do |format|
      if @organism.update(organism_params)
        format.html { redirect_to @organism, notice: 'Organism was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organism.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
		authorize @organism
		ddestroy(@organism,organisms_path)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organism
      @organism = Organism.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:alert] = "The organism you were looking for could not be found."
      redirect_to organisms_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organism_params
      params.require(:organism).permit(:name)
    end
end
