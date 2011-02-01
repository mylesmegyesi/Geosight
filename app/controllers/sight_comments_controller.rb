class SightCommentsController < ApplicationController
  # GET /sight_comments
  # GET /sight_comments.xml
  def index
    @sight_comments = SightComment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sight_comments }
    end
  end

  # GET /sight_comments/1
  # GET /sight_comments/1.xml
  def show
    @sight_comment = SightComment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sight_comment }
    end
  end

  # GET /sight_comments/new
  # GET /sight_comments/new.xml
  def new
    @sight_comment = SightComment.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sight_comment }
    end
  end

  # GET /sight_comments/1/edit
  def edit
    @sight_comment = SightComment.find(params[:id])
  end

  # POST /sight_comments
  # POST /sight_comments.xml
  def create
    @sight_comment = SightComment.new(params[:sight_comment])

    respond_to do |format|
      if @sight_comment.save
        format.html { redirect_to(@sight_comment, :notice => 'Sight comment was successfully created.') }
        format.xml  { render :xml => @sight_comment, :status => :created, :location => @sight_comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sight_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sight_comments/1
  # PUT /sight_comments/1.xml
  def update
    @sight_comment = SightComment.find(params[:id])

    respond_to do |format|
      if @sight_comment.update_attributes(params[:sight_comment])
        format.html { redirect_to(@sight_comment, :notice => 'Sight comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sight_comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sight_comments/1
  # DELETE /sight_comments/1.xml
  def destroy
    @sight_comment = SightComment.find(params[:id])
    @sight_comment.destroy

    respond_to do |format|
      format.html { redirect_to(sight_comments_url) }
      format.xml  { head :ok }
    end
  end
end
