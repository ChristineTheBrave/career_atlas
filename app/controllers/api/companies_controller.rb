class Api::CompaniesController < ApplicationController

  def index
    company = GlassdoorApi.search_company(params)
    company_info = output_info(company["response"]["employers"])
    render json: company_info
  end

  private

  def output_info(company_info_to_output)
    company_info_to_output.map do |el|
      {
        company: el["name"],
        logo: el["squareLogo"],
        overall_rating: el["overallRating"],
        culture_rating: el["cultureAndValuesRating"],
        leadership_rating: el["seniorLeadershipRating"],
        compensation_rating: el["compensationAndBenefitsRating"],
        opportunity_rating: el["careerOpportunitiesRating"],
        work_life_balance_rating: el["workLifeBalanceRating"],
        recommend_to_friend_rating: el["recommendToFriendRating"]
      }
    end
  end
end