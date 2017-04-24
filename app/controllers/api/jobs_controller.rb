class Api::JobsController < ApplicationController

  def index
    jobs = IndeedApi.search_jobs(params)
    job_info = info_for_output(jobs["results"])
    save_jobs(job_info)
    render json: job_info
  end

  def create
    if current_user
      current_user.jobs.create(params["job"])
    else

    end
  end

  private
  def info_for_output(jobs)
    jobs.map do |job|
      {
        jobtitle: job["jobtitle"],
        company: job["company"],
        url: job["url"],
        latitude: job["latitude"],
        longitude: job["longitude"],
        key: job["jobkey"],
        location: job["formattedLocationFull"],
        date_posted: job["formattedRelativeTime"]
      }
    end
  end
end
