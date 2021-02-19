class JobsController < ApplicationController
  before_action :authenticate_collaborator!

  def new
    @job = current_collaborator.company.jobs.new
  end

  def create
    @job = current_collaborator.company.jobs.new(job_params)
    define_date
    return redirect_to @job if @job.save

    render :new
  end

  def show
    @job = current_collaborator.company.jobs.find(params[:id])
  end

  private

  def job_params
    params.require(:job).permit(:title_job, :description, :salary_range, :level, :requisite, :date_limit, :quantity, :status)
  end

  def define_date
    @job.date_limit = if job_params[:date_limit].blank?
      30.days.from_now
    else
      job_params[:date_limit]
    end
  end

end
