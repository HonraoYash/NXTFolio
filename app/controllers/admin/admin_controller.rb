# frozen_string_literal: true

module Admin
  class AdminController < ApplicationController
    # Probably some code here for if you have permission, but otherwise just links to other pages are here.
    # Maybe all the other pages could get consolidated here and seperated under tabs.

    def landing
      # GeneralInfo.load_Job_File #No longer needed- Job file is loaded in initializer
      @hasPermission = user_has_permission?
      print('Current USer Key is: ')
      print(session[:current_user_key])
      return unless @hasPermission == false

      redirect_to '/login_info/login'
    end

    def user_has_permission?
      user_key = session[:current_user_key]
      return false if user_key.nil?
      general_info = GeneralInfo.find_by(userKey: user_key)
      general_info&.is_admin || false
    end

    def create
      @hasPermission = user_has_permission?
      # if(@hasPermission == false)
      #   redirect_to "/login_info/login"
      # end

      @potentialJob = params[:job_name].to_s

      if !@potentialJob.nil? && @potentialJob != ''
        @potentialJob = @potentialJob.parameterize(separator: '_').upcase_first
        if GeneralInfo.check_Job?(@potentialJob) == false
          GeneralInfo.create_Job(@potentialJob)
          @potentialJob.constantize.new
          flash.now[:notice] =
            "#{@potentialJob.titleize} has been created.\nCurrent jobs are : #{GeneralInfo.see_Jobs.join(',')}"
        else
          flash.now[:notice] =
            "#{params[:job_name].titleize} already exists.\nCurrent jobs are : #{GeneralInfo.see_Jobs.join(',')}"
        end
      elsif params[:job_name] == ''
        flash.now[:notice] = 'Please enter a non-empty value.'
      end

      # else
      # Probably fetching page
    end

    def edit
      @hasPermission = user_has_permission?
      redirect_to '/login_info/login' if @hasPermission == false

      @jobs = []

      GeneralInfo.see_Jobs.each do |i|
        @jobs.push i.titleize
      end

      if !params[:job_name].nil? && !params[:attr_action].nil? && !params[:attr_name].nil?
        @job = params[:job_name].parameterize(separator: '_').upcase_first
        @job_Obj = params[:job_name].parameterize(separator: '_').upcase_first.constantize
        @action = params[:attr_action]
        @attr = params[:attr_name]

        if GeneralInfo.check_Job?(@job)
          if @action == 'Add' && @job_Obj.view_Attr.include?(@attr) == false
            @job_Obj.add_Attr(@attr)
            flash.now[:notice] =
              "Attribute #{@attr} added to #{@job}---#{@job}'s current attributes are #{@job_Obj.view_Attr.inspect}"
            x = @job_Obj.view_Attr.find_index(@attr)
            GeneralInfo.find_each do |user|
              if user[:job_name] == @job_Obj.name
                newAttr = user[:job_attr]
                newAttr[x] = 'Default'
                user.update_attribute(:job_attr, newAttr)
              end
            end
          elsif @action == 'Remove' && @job_Obj.view_Attr.include?(@attr)
            origLoc = @job_Obj.view_Attr.find_index(@attr)
            @job_Obj.delete_Attr(@attr)
            flash.now[:notice] =
              "Attribute #{@attr} removed from #{@job}---#{@job}'s current attributes are #{@job_Obj.view_Attr.inspect}"
            attrLength = @job_Obj.view_Attr.length
            GeneralInfo.find_each do |user|
              if user[:job_name] == @job_Obj.name
                x = origLoc
                newAttr = user[:job_attr]
                while x < attrLength
                  newAttr[x] = newAttr[x + 1]
                  x += 1
                end
                newAttr.delete(attrLength)
                user.update_attribute(:job_attr, newAttr)
              end
            end
          else
            flash.now[:notice] =
              "Attribute #{@attr} already in #{@job}---#{@job}'s current attributes are #{@job_Obj.view_Attr.inspect}"
          end

        else
          flash.now[:notice] = "Job #{@job.titleize} not found."
        end
      else
        flash.now[:notice] = 'Error: One or more empty fields'
      end
    end

    def delete
      @hasPermission = user_has_permission?
      redirect_to '/login_info/login' if @hasPermission == false

      @jobs = []

      unless params[:job_name].nil?
        @potentialJob = params[:job_name].to_s.parameterize(separator: '_').upcase_first
        if GeneralInfo.check_Job?(@potentialJob)
          GeneralInfo.delete_Job(@potentialJob)
          flash.now[:notice] = "#{params[:job_name].titleize} has been deleted."

          # GeneralInfo.delete_Job_From_File(params[:job_name])
        end
        # else
        # Probably fetching page
      end

      GeneralInfo.see_Jobs.each do |i|
        @jobs.push i.titleize
      end
    end
  end
end
