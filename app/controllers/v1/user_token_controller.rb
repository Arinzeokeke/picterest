class V1::UserTokenController < Knock::AuthTokenController
	def create

      render json: auth_token, status: :created
    end
end
