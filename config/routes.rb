Rails.application.routes.draw do

  mount Api::RootEndpoint => "api"
  mount GrapeSwaggerRails::Engine => "api/swagger"
end
