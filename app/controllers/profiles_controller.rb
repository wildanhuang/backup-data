class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:edit, :update, :destroy]

  def index
    @profiles = Profile.all

    redirect_to new_profile_path if @profiles.size == 0
  end

  def new
    @profile = Profile.new
  end

  def create
    profile = Profile.new(profile_params)

    if profile.save
      redirect_to profiles_path, :flash => { :notice => "Succeed to create profile" }
    else
      redirect_to new_profile_path, :flash => { :error => profile.errors.full_messages.join(', ') }
    end
  end

  def edit
  end

  def update
    if @profile.save
      redirect_to profiles_path, :flash => { :notice => "Succeed to update profile" }
    else
      redirect_to edit_profile_path(@profile), :flash => { :error => @profile.errors.full_messages.join(', ') }
    end
  end

  def destroy
  end

  private
    def profile_params
      params.require(:profile).permit(:name, :folders, :exclusion)
    end

    def set_profile      
      @profile = Profile.find_by(id: params[:id])
    end
end
