module Api
    module V1
        class RolesController < ApplicationController
            protect_from_forgery with: :null_session
            def index
                roles = Role.all

                render json: RoleSerializer.new(roles).serialized_json
            end

            def show
                role = Role.find_by(id: params[:id])
                
                render json: RoleSerializer.new(role).serialized_json
            end

            def create
                role = Role.new(role_params)

                if role.save
                    render json: RoleSerializer.new(role).serialized_json
                else
                    render json: {error: role.errors.full_messages}, status: 422
                end
            end

            def update
                role = Role.find_by(id: params[:id])

                if role.update(role_params)
                    render json: RoleSerializer.new(role).serialized_json
                else
                    render json: {error: role.errors.full_messages}, status: 422
                end
            end

            def destroy
                role = Role.find_by(id: params[:id])

                if role.destroy
                    head :no_content
                else
                    render json: {error: role.errors.full_messages}, status: 422
                end
            end

            private

            def role_params
                params.require(:role).permit(:name, :description)
            end
        end
    end
end
