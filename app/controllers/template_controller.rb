# frozen_string_literal: true

class TemplateController < ApplicationController
  def create
    type = params[:prof_name]
    field_name_arr = params[:field_name]
    field_type_arr = params[:field_type]
    attributes_json = {}
    field_name_arr&.each_with_index do |field_name, index|
      attributes_json[field_name] = field_type_arr[index]
    end
    attributes_json = attributes_json.to_json
    Template.create(prof_name: type, prof_attribute: attributes_json)
    redirect_to root_path
  end

  # Associated with x`the view used for create
  def new; end

  def index
    return unless session[:is_admin] != true

    render file: "#{Rails.root}/public/404.html", layout: false, status: 404
  end
  # Params used to create the LoginInfo object

  private

  def template_params
    params.require(:prof_name).permit(:prof_attribute)
  end
end
