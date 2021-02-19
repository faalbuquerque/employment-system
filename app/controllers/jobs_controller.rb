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

  def edit
    @job = current_collaborator.company.jobs.find(params[:id])
  end

  def update
    @job = current_collaborator.company.jobs.find(params[:id])
    return redirect_to @job if @job.update(job_params)

    render :edit
  end

  def destroy
    @job = current_collaborator.company.jobs.find(params[:id])
    return redirect_to current_collaborator.company if @job.delete
  
    render current_collaborator.company.jobs
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
