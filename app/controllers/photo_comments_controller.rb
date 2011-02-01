class PhotoCommentsController < ApplicationController
  # GET /photo_comments
  # GET /photo_comments.xml
  def index
    @photo_comments = PhotoComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photo_comments }
    end
  end

  # GET /photo_comments/1
  # GET /photo_comments/1.xml
  def show
    @photo_comment = PhotoComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo_comment }
    end
  end

  # GET /photo_comments/new
  # GET /photo_comments/new.xml
  def new
    @photo_comment = PhotoComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo_comment }
    end
  end

  # GET /photo_comments/1/edit
  def edit
    @photo_comment = PhotoComment.find(params[:id])
  end

  # POST /photo_comments
  # POST /photo_comments.xml
  def create
    @photo_comment = PhotoComment.new(params[:photo_comment])

    respond_to do |format|
      if @photo_comment.save
        format.html { redirect_to(@photo_comment, :notice => 'Photo comment was successfully created.') }
        format.xml  { render :xml => @photo_comment, :status => :created, :location => @photo_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photo_comments/1
  # PUT /photo_comments/1.xml
  def update
    @photo_comment = PhotoComment.find(params[:id])

    respond_to do |format|
      if @photo_comment.update_attributes(params[:photo_comment])
        format.html { redirect_to(@photo_comment, :notice => 'Photo comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photo_comments/1
  # DELETE /photo_comments/1.xml
  def destroy
    @photo_comment = PhotoComment.find(params[:id])
    @photo_comment.destroy

    respond_to do |format|
      format.html { redirect_to(photo_comments_url) }
      format.xml  { head :ok }
    end
  end
end
