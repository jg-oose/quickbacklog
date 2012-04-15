class BacklogEntriesController < ApplicationController
  # GET /backlog_entries
  # GET /backlog_entries.json
  def index
    d = params[:d] || "open"
    done_is = []
    @ui_btn_state = {}

    case d
    when "done"
      done_is << true
      @ui_btn_state[:done] = "disabled"
    when "all"
      done_is << false
      done_is << true
      @ui_btn_state[:all] = "disabled"
    else # "open" or rubbish
      done_is << false
      @ui_btn_state[:open] = "disabled"
    end
    
    @backlog_entries = project_from_session.backlog_entries.where(:done => done_is).order("position")
    @size_scale = project_from_session.size_scale

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @backlog_entries }
      format.pdf do
        pdf = params[:cards] ? BacklogCardsPdf.new : BacklogListingPdf.new
        pdf.build_document @backlog_entries
        send_data pdf.render, filename: "Backlog Entries - #{Date.today}.pdf", disposition: 'inline'
      end
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
    @backlog_entry = project_from_session.new_backlog_entry_from_template
    if params[:cut_from]
      @backlog_entry.cut_from = BacklogEntry.find(params[:cut_from])
    end
     
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
    @backlog_entry = project_from_session.backlog_entries.build(params[:backlog_entry])
    @backlog_entry.position = @backlog_entry.cut_from.try(:position)

    respond_to do |format|
      if @backlog_entry.save
        flash[:highlight] = @backlog_entry.id
        format.html { redirect_to backlog_entries_path, notice: 'Backlog entry was successfully created.' }
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
        flash[:highlight] = @backlog_entry.id
        format.html { redirect_to backlog_entries_url, notice: 'Backlog entry was successfully updated.' }
        format.json { respond_with_bip @backlog_entry }
      else
        format.html { render action: "edit" }
        format.json { respond_with_bip @backlog_entry }
      end
    end
  end

  #TODO This only works properly if all entries are present for sorting / how to support different cases?
  def sort
    params[:backlog_entry].each_with_index do |id, index|
      BacklogEntry.update_all({position: index+1}, {id: id})
    end
    render nothing: true
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