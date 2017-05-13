class V1::UserTokenController < Knock::AuthTokenController
	def create

      render json: current_user, auth_token, status: :created
    end
end
