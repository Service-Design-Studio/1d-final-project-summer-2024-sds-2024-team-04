module Api
    module V1
        class UsersController < ApplicationController
            protect_from_forgery with: :null_session
            def index
                users = User.all

                render json: UserSerializer.new(users).serialized_json
            end

            def show
                user = User.find_by(id: params[:id])
                
                if user
                    render json: UserSerializer.new(user).serialized_json
                else
                    render json: { error: 'User not found' }, status: :not_found
                end
            end

            def create
                user = User.new(user_params)

                if user.save
                    render json: UserSerializer.new(user).serialized_json
                else
                    render json: {error: user.errors.full_messages}, status: 422
                end
            end

            def update
                user = User.find_by(id: params[:id])

                if user.nil?
                    render json: { error: 'User not found' }, status: :not_found
                elsif user.update(user_params)
                render json: UserSerializer.new(user).serialized_json
                else
                render json: { error: user.errors.full_messages }, status: :unprocessable_entity
                end
            end

            def destroy
                user = User.find_by(id: params[:id])

                if user.nil?
                    render json: { error: 'User not found' }, status: :not_found
                elsif user.destroy
                    head :no_content
                else
                    render json: {error: user.errors.full_messages}, status: 422
                end
            end

            private
            
            def user_params
                params.require(:user).permit(:username, :password, :employee_id)
            end
        end
    end
end
