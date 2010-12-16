class FeedbacksController < ApplicationController
  
  before_filter :require_user
  before_filter :authorize_only_admins
  

  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @feedback_pages, @feedbacks = paginate :feedbacks, :per_page => 10, :order=>"msg_timestamp desc"
  end

  def show
    @feedback = Feedback.find(params[:id])
  end

  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.save
      flash[:notice] = 'Feedback was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @feedback = Feedback.find(params[:id])
  end

  def update
    @feedback = Feedback.find(params[:id])
    if @feedback.update_attributes(params[:feedback])
      flash[:notice] = 'Feedback was successfully updated.'
      redirect_to :action => 'show', :id => @feedback
    else
      render :action => 'edit'
    end
  end

  def destroy
    Feedback.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
