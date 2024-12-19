# app/controllers/crud_controller.rb
class CrudController < ApplicationController
  def f_model_names
    Rails.application.eager_load! if Rails.env.development?
    models = ApplicationRecord.descendants
    model_names = models.map(&:name)
    model_names.reject do |name|
      %w[Permission Group ContentType Session LogEntry].include?(name)
    end
  end

  def f_fields_name(model)
    # model = model_name.constantize
    fields = model.columns_hash.select do |name, col|
      %w[string text boolean].include?(col.type.to_s) || name.end_with?('_id')
    end.keys
    ['id'] + fields
  end

  def f_versions
    "Rails v#{Rails::VERSION::STRING} Ruby v#{RUBY_VERSION}"
  end

  def safe_constantize_model(model_name)
    model_name.constantize
  rescue NameError => e
    puts "Error: Could not find model '#{model_name}': #{e.message}"
    nil
  end

  def home
    lname = session[:lname]
    unless lname
      session[:backafterreg] = '/wines/new'
      redirect_to login_path
      return
    end
    @versions = f_versions
    @title = 'CRU(D) on all tables'
    @model_list = f_model_names
    render 'crud/crud'
  end

  def check
    @versions = f_versions
    @title = 'CRU(D) on all tables'
    @model_name = params[:Mname]
    @model = safe_constantize_model(@model_name)
    if !@model
      redirect_to('/crud')
      nil
    else
      @fields = f_fields_name(@model)

      @object_list = @model.all.map do |record|
        @fields.map do |field|
          if field.downcase == 'pwd'
            '******' # Mask password fields
          else
            record.send(field)
          end
        end
      end

      @model_list = f_model_names
      render 'crud/crud'
    end
  end

  def rem
    @versions = f_versions
    @model_name = params[:MN]
    @model = safe_constantize_model(@model_name)
    record = @model.find_by(id: params[:id])
    record&.destroy
    @title = "CRU(D) on all tables, deleted id=#{params[:id]}"
    @model_list = f_model_names

    render 'crud/crud'
  end

  def new
    @model_name = params[:MN]
    @model = safe_constantize_model(@model_name)
    @fields = f_fields_name(@model).reject { |f| f == 'id' }
    @versions = f_versions
    @title = "Create New #{@model_name}"
    render 'crud/new'
  end

  def create
    @model_name = params[:MN]
    @model = safe_constantize_model(@model_name)
    # Filter out non-fillable fields
    permitted_params = params.require(:record).permit(f_fields_name(@model))
    @record = @model.new(permitted_params)
    @record.save
    @model = safe_constantize_model(@model_name)
    @fields = f_fields_name(@model).reject { |f| f == 'id' }
    @versions = f_versions
    @title = "Create New #{@model_name}"
    render 'crud/new'
  end
end
