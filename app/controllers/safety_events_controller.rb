class SafetyEventsController < ApplicationController
  before_action :current_user_must_be_safety_event_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_safety_event_user
    safety_event = SafetyEvent.find(params[:id])

    unless current_user == safety_event.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @q = SafetyEvent.ransack(params[:q])
    @safety_events = @q.result(:distinct => true).includes(:user, :classification).page(params[:page]).per(10)

    render("safety_events/index.html.erb")
  end

  def show
    @safety_event = SafetyEvent.find(params[:id])

    render("safety_events/show.html.erb")
  end

  def new
    @safety_event = SafetyEvent.new

    render("safety_events/new.html.erb")
  end

  def create
    @safety_event = SafetyEvent.new

    @safety_event.comment = params[:comment]
    @safety_event.classification_id = params[:classification_id]
    @safety_event.user_id = params[:user_id]
    @safety_event.root_cause = params[:root_cause]
    @safety_event.action_plan = params[:action_plan]

    save_status = @safety_event.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/safety_events/new", "/create_safety_event"
        redirect_to("/safety_events")
      else
        redirect_back(:fallback_location => "/", :notice => "Safety event created successfully.")
      end
    else
      render("safety_events/new.html.erb")
    end
  end

  def edit
    @safety_event = SafetyEvent.find(params[:id])

    render("safety_events/edit.html.erb")
  end

  def update
    @safety_event = SafetyEvent.find(params[:id])

    @safety_event.comment = params[:comment]
    @safety_event.classification_id = params[:classification_id]
    @safety_event.user_id = params[:user_id]
    @safety_event.root_cause = params[:root_cause]
    @safety_event.action_plan = params[:action_plan]

    save_status = @safety_event.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/safety_events/#{@safety_event.id}/edit", "/update_safety_event"
        redirect_to("/safety_events/#{@safety_event.id}", :notice => "Safety event updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Safety event updated successfully.")
      end
    else
      render("safety_events/edit.html.erb")
    end
  end

  def destroy
    @safety_event = SafetyEvent.find(params[:id])

    @safety_event.destroy

    if URI(request.referer).path == "/safety_events/#{@safety_event.id}"
      redirect_to("/", :notice => "Safety event deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Safety event deleted.")
    end
  end
end
