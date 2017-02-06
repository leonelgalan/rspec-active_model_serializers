class ProfilesController < ApplicationController
  before_action :set_profile

  def index
    render json: @profile
  end

  def show
    index
  end

  def name_as_a_integer
    @profile.attributes[:name] = 1
    index
  end

  def render_using_json_api
    render json: @profile, adapter: :json_api
  end

  def invalid_json_body
    render json: ''
  end

  private

  def set_profile
    @profile = Profile.new(name: 'Name 1', description: 'Description 1')
  end
end
