class ClassificationsController < ApplicationController
  def index
    @q = Classification.ransack(params[:q])
    @classifications = @q.result(:distinct => true).includes(:safety_events).page(params[:page]).per(10)

    render("classifications/index.html.erb")
  end

  def show
    @safety_event = SafetyEvent.new
    @classification = Classification.find(params[:id])

    render("classifications/show.html.erb")
  end

  def new
    @classification = Classification.new

    render("classifications/new.html.erb")
  end

  def create
    @classification = Classification.new

    @classification.event_id = params[:event_id]

    save_status = @classification.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/classifications/new", "/create_classification"
        redirect_to("/classifications")
      else
        redirect_back(:fallback_location => "/", :notice => "Classification created successfully.")
      end
    else
      render("classifications/new.html.erb")
    end
  end

  def edit
    @classification = Classification.find(params[:id])

    render("classifications/edit.html.erb")
  end

  def update
    @classification = Classification.find(params[:id])

    @classification.event_id = params[:event_id]

    save_status = @classification.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/classifications/#{@classification.id}/edit", "/update_classification"
        redirect_to("/classifications/#{@classification.id}", :notice => "Classification updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Classification updated successfully.")
      end
    else
      render("classifications/edit.html.erb")
    end
  end

  def destroy
    @classification = Classification.find(params[:id])

    @classification.destroy

    if URI(request.referer).path == "/classifications/#{@classification.id}"
      redirect_to("/", :notice => "Classification deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Classification deleted.")
    end
  end
end
