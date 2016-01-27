class OrganizationsController < ApplicationController
  before_action :set_organization, only: [:show, :edit, :update, :destroy]

  # GET /organizations
  # GET /organizations.json

  # Make the index action only show the org we're searching for.
  # Search method requires exact match. Otherwise, we'll be spitting out lists
  # of possible matching results, which could confuse clients if they're
  # expecting only a single result.

  def index
    # Guard clause. Interesting idea I saw online, as an alternative to
    # nesting conditionals....
    return false if !params[:search]
    @organization = Organization.search(params[:search])

    if !@organization
      flash.now[:notice] = "No organization found by that name."
    end
    respond_to do |format|
      format.json { render json: @organization, :only => [:name,:orgnumber] }
      format.xml { render xml: @organization, :only => [:name,:orgnumber]}
    end
    # Do we create XML and JSON representations of our object here?
    # The thing is, I don't want flash messages appearing for JSON
    # and XML requests. But I also don't want to repeat code if I can help it.
    # Build and test!
  end

  # GET /organizations/1
  # GET /organizations/1.json
  def show
  end

  # GET /organizations/new
  def new
    @organization = Organization.new
  end

  # GET /organizations/1/edit
  def edit
  end

  # POST /organizations
  # POST /organizations.json
  def create
    @organization = Organization.new(organization_params)

    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @organization }
      else
        format.html { render :new }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to root_path, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organization }
      else
        format.html { render :edit }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizations/1
  # DELETE /organizations/1.json
  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization
      @organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_params
      params[:organization].permit(:name, :orgnumber)
    end
end
