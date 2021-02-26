class ApplicationsController < ApplicationController
  before_action :authenticate_candidate!, except: %i[edit update]
  before_action :require_collaborator_or_candidate, only: %i[edit update]
  before_action :redirect_if_no_relation, only: %i[edit update]

  def index
    @application_jobs = current_candidate.jobs
  end

  def create
    @job = Job.find(job_params[:id])
    @job.check_available_applications
    if not(current_candidate.jobs.include?(@job)) && @job.available?
      message = 'Candidatura efetuada!'
      return redirect_to applications_path, notice: message if current_candidate.jobs << @job
    end

    redirect_to @job, alert: 'Oops, erro na candidatura!'
  end

  def show
    @application = current_candidate.applications.find(params[:id])
    @job = @application.job
  end

  def edit
  end

  def update
    if @application.is_denied?(application_params)
      message = 'Candidatura cancelada!'

      return redirect_to @application, notice: message if candidate_signed_in?
      return redirect_to @job, notice: message if collaborator_signed_in?
    end

    flash.now[:alert] = 'Candidatura ja finalizada!'
    render :edit
  end

  def destroy
    return redirect_to root_path unless is_application_job_collaborator?
  end

  private

  def job_params
    params.require(:job).permit(:id)
  end

  def application_params
    params.require(:application).permit(:id, :refuse_msg)
  end

  def is_application_job_collaborator?
    @application = Application.find(params[:id])
    @jobs = current_collaborator.company.jobs
    @job = @application.job
    @jobs.include?(@job)
  end

  def is_application_job_candidate?
    @application = Application.find(params[:id])
    @jobs = current_candidate.jobs
    @job = @application.job
    @jobs.include?(@job)
  end

  def require_collaborator_or_candidate
    unless (collaborator_signed_in? || candidate_signed_in?)
      return redirect_to root_path
    end
  end

  def redirect_if_no_relation
    if collaborator_signed_in?
      return redirect_to root_path unless is_application_job_collaborator?
    else
      return redirect_to root_path unless is_application_job_candidate?
    end
  end
end
