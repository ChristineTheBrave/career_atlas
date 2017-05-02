require 'rails_helper'

RSpec.describe Api::JobsController, type: :controller do

  let(:john) { create_john }

  it "gets a list of jobs back" do
    search_params = { job_title: "Ruby", location: 20011, radius: 25, job_type: "fulltime" }

    stub_request(:get, /api.indeed.com\/ads\/apisearch/)
      .to_return(
        body: File.read(Rails.root.join("spec", "stubbed_requests", "job_search.json")),
        headers: {"Content-Type" => "application/json"}
      )
    get :index, params: search_params
    expect(json_body[0]["company"]).to eq("VeriSign")
    expect(json_body.count).to be > 1
  end
end
