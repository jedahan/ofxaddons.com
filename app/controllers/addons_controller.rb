class AddonsController < ApplicationController

  # before_action :set_addon, only: [:show, :edit, :update, :destroy]

  # GET /addons
  def index
    @repos = Addon.joins(:categories)
      .includes(:categories)

    case params[:sort]
    when "freshest"
      @repos = @repos.order("repos.pushed_at DESC")
    when "popular"
      @repos = @repos.order("repos.stargazers_count DESC")
    end

    @repos = @repos.order("lower(repos.name) ASC")

    if stale?(last_modified: @repos.maximum(:updated_at))
      expires_in 1.hours, public: true
      render 'repos/index'
    end
  end

  # # GET /addons/1
  # def show
  # end

  # # GET /addons/1/edit
  # def edit
  # end

  # # POST /addons
  # def create
  #   @addon = Addon.new(addon_params)

  #   if @addon.save
  #     redirect_to @addon, notice: 'Addon was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # # PATCH/PUT /addons/1
  # def update
  #   if @addon.update(addon_params)
  #     redirect_to @addon, notice: 'Addon was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # # DELETE /addons/1
  # def destroy
  #   @addon.destroy
  #   redirect_to addons_url, notice: 'Addon was successfully destroyed.'
  # end

  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_addon
  #     @addon = Addon.includes(:categories, :estimated_release => :release).find(params[:id])
  #   end

  #   # Only allow a trusted parameter "white list" through.
  #   def addon_params
  #     params[:addon]
  #   end
end
