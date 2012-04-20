class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.json
#  def index
#    @projects = Project.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @projects }
#    end
#  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = project_from_session

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = project_from_session
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = project_from_session

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to project_path, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def capacity
    logger.info(params[:capacity])
    @project = project_from_session
    @project.iteration_capacity = params[:capacity]
    @project.save

    render nothing: true
  end

end
