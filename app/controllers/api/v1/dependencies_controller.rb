class Api::V1::DependenciesController < Api::BaseController
  def index
    gem_list = params[:gems].split(',')

    if gem_list.size <= Dependency::LIMIT
      render :text => Marshal.dump(Dependency.for(gem_list))
    else
      render :text   => "Too many packages to resolve, please request less than #{Dependency::LIMIT} packages",
             :status => :request_entity_too_large
    end
  end
end
