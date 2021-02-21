class ApplicationsController < ApplicationController
  before_action :authenticate_candidate!

  def index
    @application_jobs = current_candidate.jobs
  end

  def create
    @job = Job.find(job_params[:id])
    @job.check_available_applications
    if not(current_candidate.jobs.include?(@job)) && @job.Disponivel?
      message = 'Candidatura efetuada!'
      return redirect_to applications_path, notice: message if current_candidate.jobs << @job
    end

    redirect_to @job, alert: 'Oops, erro na candidatura!'
  end

  def show
    @application = current_candidate.applications.find(params[:id])
    @job = @application.job

  end

  private

  def job_params
    params.require(:job).permit(:id)
  end
end
