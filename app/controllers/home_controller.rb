class HomeController < ApplicationController

  def index
    @jobs = Job.all
  end

  def search
    @results = fetch_jobs + fetch_companies
  end

  private

  def fetch_jobs
    Job.where('title_job like ? OR description like ?', "%#{params[:q]}%", "%#{params[:q]}%").where(status: 'Disponivel')
  end

  def fetch_companies
    Company.where('name like ? OR site like ?', "%#{params[:q]}%", "%#{params[:q]}%")
  end
end
