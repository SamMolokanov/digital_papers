module Api
  module Status
    class ShowEndpoint < Grape::API
      resource :status do
        desc "Returns 200 if Service works"

        get do
          present status: "ok"
        end
      end
    end
  end
end
