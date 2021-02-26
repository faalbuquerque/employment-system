class JobsController < ApplicationController
  before_action :authenticate_collaborator!, except: %i[show]
  before_action :fetch_job, only: %i[show edit update destroy]
  before_action :require_same_company_collaborator, except: %i[new create show]

  def new
    @job = current_collaborator.company.jobs.new
  end

  def create
    @job = current_collaborator.company.jobs.new(job_params)
    @job.define_date(job_params[:date_limit])
    return redirect_to @job, notice: 'Vaga cadastrada com sucesso!' if @job.save

    render :new
  end

  def show
  end

  def edit
  end

  def update
    @job.define_date(job_params[:date_limit])

    return redirect_to @job, notice: 'Vaga alterada com sucesso!' if @job.update(job_params.merge(date_limit: @job.date_limit))

    render :edit
  end

  def destroy
    return redirect_to current_collaborator.company if @job.destroy

    render current_collaborator.company.jobs
  end

  private

  def job_params
    params.require(:job).permit(:title_job, :description, :salary_range, :level, :requisite, :date_limit, :quantity, :status)
  end

  def fetch_job
    @job = Job.wich_is_for_who(collaborator_signed_in?, current_collaborator,
                               params[:id])
  end

  def require_same_company_collaborator
    return redirect_to root_path unless @job.is_same_company_collaborator?(current_collaborator)
  end
end
