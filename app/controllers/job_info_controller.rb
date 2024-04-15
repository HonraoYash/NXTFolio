class JobInfoController < ApplicationController
    # Variable that holds a params/object with all the attributes filled in
    def list
        
    end

    def jobshow
        # @general_info = JobInfo.find(params[:id])
    end



    # # # Associated with the view used for create
    # def new
    #     # get default email from session if available
    #     @job_info ||= JobInfo.new
    #     # @job_info.emailaddr = session[:current_login_user]["email"] if session.has_key? :current_login_user
    # end

    def index 

      # @job_infos = JobInfo.all 
      @job_infos = JobInfo.filterByUserKey session[:current_user_key]
      
    end

    def show 
      id = params[:id] # retrieve job ID from URI route
      puts "check params"
      puts params 
      @job_info = JobInfo.find(id) # look up job by unique ID
      
      # will render app/views/job_info/show.<extension> by default
    end

    def visitor_show 
      id = params[:id] # retrieve job ID from URI route
      puts "check params"
      puts params 
      @job_info = JobInfo.find(id) # look up job by unique ID
      
      # will render app/views/job_info/visitor_show.<extension> by default
    end


    def edit
      @job_info = JobInfo.find params[:id]
    end
  
    def update
      # @job_info = JobInfo.find params[:id]
      # @job_info.update!(job_info_params)
      # flash[:notice] = "#{@job_info.title} was successfully updated."
      # redirect_to job_info_path(@job_info)
    end

    def destroy
      # puts "check adfsadfa"
      @job_info = JobInfo.find(params[:id])
      @job_info.destroy
      flash[:notice_delete_job] = "Job '#{@job_info.title}' deleted."
      redirect_to "/job_info"
    end

    def new_job 
      @job_info = JobInfo.new
      if session[:current_user_key]
        current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
        if current_user
          @username = current_user[:first_name]
        end
      end
    end


    def post_job 
      if session[:current_user_key]
        current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
        if current_user
          @username = current_user[:first_name]
        end
      end
        # @job_info ||= JobInfo.new()
      @job_info = JobInfo.new(job_info_params)
      @job_info.userKey = session[:current_user_key]

      if @job_info.save
          flash[:success_post_job] = "   Job info created successfully"
          redirect_to job_search_jobshow_path
      else
          flash[:error_post_job] = "Error creating job info"
          render 'new_job'
      end
    end


    # Params used to create the JobInfo object
    def job_info_params
        # cannot use the first line, b/c currently the job_info is nil/missing
        params.require(:job_info).permit(:title, :description, :category, :profession, :country, :state, :city, :type, :low_salary, :high_salary, :userKey)
        # params.permit(:title, :description, :category, :profession, :country, :state, :city, :type, :low_salary, :high_salary)
    end





=begin
    def create
      @possible_Jobs = GeneralInfo.see_Jobs
      # Check to see if the required params are filled in
      @general_info = GeneralInfo.new(general_info_params)
      error_statement = ""
      if params[:general_info][:first_name] == ""
        error_statement += "First Name, "
      end
      if params[:general_info][:highlights] == ""
        error_statement += "Highlights, "
      end
      if params[:general_info][:last_name] == ""
        error_statement += "Last Name, "
      end
      if params[:general_info][:company] == ""
        error_statement += "Company"
      end
      if params[:general_info][:industry] == ""
        error_statement += "Industry"
      end
      if params[:general_info][:job_name] == ""
        error_statement += "Profession"
      end
      if params[:general_info][:country] == ""
        error_statement += "Country, "
      end
      if params[:general_info][:state] == ""
        error_statement += "State, "
      end
      if params[:general_info][:city] == ""
        error_statement += "City, "
      end
      if params[:general_info][:emailaddr] == ""
        error_statement += "Email, "
      end

      if error_statement.length > 0
        error_statement = error_statement[0, error_statement.length-2]
        error_statement += " are required."
        flash[:notice] = error_statement
        render :new and return
      end

      # Add room to LoginInfo DB here to
      # synchronize with GeneralInfo DB
      current_user = session[:current_login_user]
      login_user = LoginInfo.new(
        :email => params[:general_info][:emailaddr], 
        :password => current_user["password"], 
        :password_confirmation => current_user["password"]
      )
      userKey = SecureRandom.hex(10)
      login_user.userKey = userKey
      login_user.save!
      session[:current_user_key] = userKey

      # Creates a GeneralInfo object & assigns userKey to be the session key of the current room
      @general_info = GeneralInfo.new(general_info_params)
      logger.info("Hey I am here")
      logger.debug(@general_info.inspect)
      @general_info.userKey = session[:current_user_key]
      @general_info.is_admin = false

      $template_name = params[:general_info][:job_name]

      if GeneralInfo.any?
        @general_info.is_admin = false
        if(@general_info.job_name == 'Admin' || @general_info.job_name == 'admin')
          @general_info.job_name = 'Photographer'
        end
      else
        @general_info.job_name = 'Admin'
        @general_info.is_admin = true
      end

      unless @general_info.save!
        flash[:error] = "Unknown error when saving: try again later"
        render :action => 'new' and return
      end

      # Send Verification Email upon successful sign-up
      UserMailer.welcome_email(@general_info,current_user).deliver_now! #works
      if params[:select_one]
      session.delete(:current_login_user)
        redirect_to "/general_info/new2"
      elsif params[:select_two]
        redirect_to "/search_engine/show"
      end
    
      # Redirect to specific profession edit page
      if $template_name == "Designer"
        @general_info.update_attribute(:specific_profile_id,1)
        redirect_to "/specific_designer/edit"
      elsif $template_name == "Model"
      @general_info.update_attribute(:specific_profile_id,2)
        redirect_to "/specific_model/edit"
        elsif $template_name == "Photographer"
        @general_info.update_attribute(:specific_profile_id,3)
        redirect_to "/specific_photographer/edit"
      end
    end
=end
    # Copied from search_engine_controller.rb
    def filter_words(string)
      file = File.open("app/assets/stop_words_english.txt", "r")
      text = file.read
      file.close
      stopwords_list = text.split
      
      res = Set.new
      for word in string.split(/\W+/) do
          if !stopwords_list.include?(word.downcase.gsub(/\W+/, ''))
              res.add(word.downcase.gsub(/\W+/, ''))
          end
      end
      return res
    end

    
    def search
      if session[:current_user_key]
        current_user = GeneralInfo.find_by(userKey: session[:current_user_key])
        if current_user
          @username = current_user[:first_name]
        end
      end 
      @params_args = params #parameters passed from view

      @keyword = @params_args[:Keyword]
      if @keyword != nil
        @keyword = @keyword.downcase
      end
      
      country = @params_args[:Country]
      state = @params_args[:State]
      city= @params_args[:City]

      category = @params_args[:Category]
      profession = @params_args[:Profession]

      # if country != nil  && state!= nil  && city!= nil && category!= nil  && profession!= nil  && @keyword!= nil  
      #   if country.empty?  && state.empty?  && city.empty? && category.empty? && profession.empty?  && @keyword.empty? 
      #     @final_users = []
      #     render 'job_info/show'
      #   end
      # end
      
      @filtered_users = JobInfo.filterByFeature category, profession, country, state, city

      @final_users = []
      if @keyword.present?
          @filtered_users.each do |user|

              text_info = Set.new

              if user.title != nil 
                  text_info += filter_words(user.title)
              end

              if user.description != nil 
                  text_info += filter_words(user.description)
              end

              @keyword_set = filter_words(@keyword)
              
              for word in text_info
                  for keyword in @keyword_set
                      if word.include?(keyword) 
                          @final_users << user
                      end
                  end
              end
          end
      else
          @final_users = @filtered_users
      end

      # puts "Final users are: "
      # @final_users.each do |final|
      #   puts final['title']
      # end
    end
  end
  