class HomeController < ApplicationController
  def index
  end

  def search
    @results = fetch_jobs + fetch_companies
  end

  private

  def fetch_jobs
    Job.where('lower(title_job) LIKE lower(?) OR lower(description) LIKE lower(?)', "%#{params[:q]}%", "%#{params[:q]}%")
       .where(status: 'available')
  end

  def fetch_companies
    Company.where('lower(name) LIKE lower(?) OR lower(site) LIKE lower(?)', "%#{params[:q]}%", "%#{params[:q]}%")
  end
end
