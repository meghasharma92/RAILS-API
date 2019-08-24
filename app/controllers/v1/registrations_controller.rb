class V1::RegistrationsController < Devise::RegistrationsController
	before_action :ensure_params_exists, only: :create

	#signup
	def create
		user = User.create(user_params)
		if user.save
			json_response('Signed up successfully.',true, user, :ok)
		else
			json_response('Something wrong',false, {}, :unprocessable_entity)
		end
	end

	private

	def user_params
		params.require(:user).permit(:email,:password,:password_confirmation)
	end

	def ensure_params_exists
		return if params[:user].present?
		json_response('Missing params.',false, {}, :bad_request)
	end
end
