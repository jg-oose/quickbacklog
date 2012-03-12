class BacklogEntriesController < ApplicationController
  # GET /backlog_entries
  # GET /backlog_entries.json
  def index
    @backlog_entries = BacklogEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backlog_entries }
    end
  end

  # GET /backlog_entries/1
  # GET /backlog_entries/1.json
  def show
    @backlog_entry = BacklogEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @backlog_entry }
    end
  end

  # GET /backlog_entries/new
  # GET /backlog_entries/new.json
  def new
    @backlog_entry = BacklogEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @backlog_entry }
    end
  end

  # GET /backlog_entries/1/edit
  def edit
    @backlog_entry = BacklogEntry.find(params[:id])
  end

  # POST /backlog_entries
  # POST /backlog_entries.json
  def create
    @backlog_entry = BacklogEntry.new(params[:backlog_entry])

    respond_to do |format|
      if @backlog_entry.save
        format.html { redirect_to @backlog_entry, notice: 'Backlog entry was successfully created.' }
        format.json { render json: @backlog_entry, status: :created, location: @backlog_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @backlog_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /backlog_entries/1
  # PUT /backlog_entries/1.json
  def update
    @backlog_entry = BacklogEntry.find(params[:id])

    respond_to do |format|
      if @backlog_entry.update_attributes(params[:backlog_entry])
        format.html { redirect_to @backlog_entry, notice: 'Backlog entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @backlog_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backlog_entries/1
  # DELETE /backlog_entries/1.json
  def destroy
    @backlog_entry = BacklogEntry.find(params[:id])
    @backlog_entry.destroy

    respond_to do |format|
      format.html { redirect_to backlog_entries_url }
      format.json { head :no_content }
    end
  end
end
