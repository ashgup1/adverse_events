class SeveritiesController < ApplicationController
  def index
    @q = Severity.ransack(params[:q])
    @severities = @q.result(:distinct => true).includes(:safety_events).page(params[:page]).per(10)

    render("severities/index.html.erb")
  end

  def show
    @safety_event = SafetyEvent.new
    @severity = Severity.find(params[:id])

    render("severities/show.html.erb")
  end

  def new
    @severity = Severity.new

    render("severities/new.html.erb")
  end

  def create
    @severity = Severity.new

    @severity.event_id = params[:event_id]

    save_status = @severity.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/severities/new", "/create_severity"
        redirect_to("/severities")
      else
        redirect_back(:fallback_location => "/", :notice => "Severity created successfully.")
      end
    else
      render("severities/new.html.erb")
    end
  end

  def edit
    @severity = Severity.find(params[:id])

    render("severities/edit.html.erb")
  end

  def update
    @severity = Severity.find(params[:id])

    @severity.event_id = params[:event_id]

    save_status = @severity.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/severities/#{@severity.id}/edit", "/update_severity"
        redirect_to("/severities/#{@severity.id}", :notice => "Severity updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Severity updated successfully.")
      end
    else
      render("severities/edit.html.erb")
    end
  end

  def destroy
    @severity = Severity.find(params[:id])

    @severity.destroy

    if URI(request.referer).path == "/severities/#{@severity.id}"
      redirect_to("/", :notice => "Severity deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Severity deleted.")
    end
  end
end
