class SightRatingsController < ApplicationController
  # GET /sight_ratings
  # GET /sight_ratings.xml
  def index
    @sight_ratings = SightRating.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sight_ratings }
    end
  end

  # GET /sight_ratings/1
  # GET /sight_ratings/1.xml
  def show
    @sight_rating = SightRating.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sight_rating }
    end
  end

  # GET /sight_ratings/new
  # GET /sight_ratings/new.xml
  def new
    @sight_rating = SightRating.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sight_rating }
    end
  end

  # GET /sight_ratings/1/edit
  def edit
    @sight_rating = SightRating.find(params[:id])
  end

  # POST /sight_ratings
  # POST /sight_ratings.xml
  def create
    @sight_rating = SightRating.new(params[:sight_rating])

    respond_to do |format|
      if @sight_rating.save
        format.html { redirect_to(@sight_rating, :notice => 'Sight rating was successfully created.') }
        format.xml  { render :xml => @sight_rating, :status => :created, :location => @sight_rating }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sight_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sight_ratings/1
  # PUT /sight_ratings/1.xml
  def update
    @sight_rating = SightRating.find(params[:id])

    respond_to do |format|
      if @sight_rating.update_attributes(params[:sight_rating])
        format.html { redirect_to(@sight_rating, :notice => 'Sight rating was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sight_rating.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sight_ratings/1
  # DELETE /sight_ratings/1.xml
  def destroy
    @sight_rating = SightRating.find(params[:id])
    @sight_rating.destroy

    respond_to do |format|
      format.html { redirect_to(sight_ratings_url) }
      format.xml  { head :ok }
    end
  end
end
