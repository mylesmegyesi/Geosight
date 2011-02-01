class SightsController < ApplicationController
  # GET /sights
  # GET /sights.xml
  def index
    @sights = Sight.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sights }
    end
  end

  # GET /sights/1
  # GET /sights/1.xml
  def show
    @sight = Sight.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sight }
    end
  end

  # GET /sights/new
  # GET /sights/new.xml
  def new
    @sight = Sight.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sight }
    end
  end

  # GET /sights/1/edit
  def edit
    @sight = Sight.find(params[:id])
  end

  # POST /sights
  # POST /sights.xml
  def create
    @sight = Sight.new(params[:sight])

    respond_to do |format|
      if @sight.save
        format.html { redirect_to(@sight, :notice => 'Sight was successfully created.') }
        format.xml  { render :xml => @sight, :status => :created, :location => @sight }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sights/1
  # PUT /sights/1.xml
  def update
    @sight = Sight.find(params[:id])

    respond_to do |format|
      if @sight.update_attributes(params[:sight])
        format.html { redirect_to(@sight, :notice => 'Sight was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sights/1
  # DELETE /sights/1.xml
  def destroy
    @sight = Sight.find(params[:id])
    @sight.destroy

    respond_to do |format|
      format.html { redirect_to(sights_url) }
      format.xml  { head :ok }
    end
  end
end
