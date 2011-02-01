class PhotoTagsController < ApplicationController
  # GET /photo_tags
  # GET /photo_tags.xml
  def index
    @photo_tags = PhotoTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photo_tags }
    end
  end

  # GET /photo_tags/1
  # GET /photo_tags/1.xml
  def show
    @photo_tag = PhotoTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo_tag }
    end
  end

  # GET /photo_tags/new
  # GET /photo_tags/new.xml
  def new
    @photo_tag = PhotoTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo_tag }
    end
  end

  # GET /photo_tags/1/edit
  def edit
    @photo_tag = PhotoTag.find(params[:id])
  end

  # POST /photo_tags
  # POST /photo_tags.xml
  def create
    @photo_tag = PhotoTag.new(params[:photo_tag])

    respond_to do |format|
      if @photo_tag.save
        format.html { redirect_to(@photo_tag, :notice => 'Photo tag was successfully created.') }
        format.xml  { render :xml => @photo_tag, :status => :created, :location => @photo_tag }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photo_tags/1
  # PUT /photo_tags/1.xml
  def update
    @photo_tag = PhotoTag.find(params[:id])

    respond_to do |format|
      if @photo_tag.update_attributes(params[:photo_tag])
        format.html { redirect_to(@photo_tag, :notice => 'Photo tag was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo_tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photo_tags/1
  # DELETE /photo_tags/1.xml
  def destroy
    @photo_tag = PhotoTag.find(params[:id])
    @photo_tag.destroy

    respond_to do |format|
      format.html { redirect_to(photo_tags_url) }
      format.xml  { head :ok }
    end
  end
end
