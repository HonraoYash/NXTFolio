class SpecificPhotographer < ApplicationRecord
  attr_accessor :allgenres
    
  def self.search checkboxes, general_info_user_keys, experience_arg, params_arg
    @user_array = Array.new
    @genre_checked_array = Array.new
    @return_array = Array.new
    @experience_str = params_arg[:experiece]
    @priority_hash = Hash.new
    @priority_return_array = Array.new
    
    # Search based on the user keys retrieved from GeneralInfo, store into @user_array
    if (!general_info_user_keys.nil? && general_info_user_keys.length > 0)
      # Gets here if general_info_user_keys has entries
      general_info_user_keys.each do |user_key_element|
        if SpecificPhotographer.exists?(user_key: user_key_element)
          @user_array.push(SpecificPhotographer.find_by(user_key: user_key_element))
        end
        
        if !(@user_array.length > 0)
          return @priority_return_array
        end      
      end
    else
      # Gets here if nothing came through general_info_user_keys
      @user_array = SpecificPhotographer.all
    end
    
    # If it was an empty search, go ahead and return @user if there was one
    if (checkboxes.nil? && params_arg.values.all? {|x| !x.nil?} && @user_array.length > 0)
      @user_array.each do |user_object|
        @priority_return_array.push(user_object[:user_key])
      end
      
      return @priority_return_array
    end
    
    # Genre requires a slightly different search
    # For every user in user_array, check if A genre matches ANY genre
    # If there are no genres, loop through @user_array & push the keys into @genre_checked_array
    if checkboxes.nil?
      # Gets here if genre is empty
      #Leave genre checked hash empty as we are not searching for genres.
    elsif !(@user_array.length > 0)
      # They did not search for anything in GeneralInfo and user_array never got populated, 
      # Therefore they are looking for everyone in the profession, using genres
      SpecificPhotographer.all.find_each do |user_object| 
        checkboxes.each do |key, checkbox_genre|
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object)
            break
          end
        end
      end
    else
      # Gets here if user_array has entries
      @user_array.each do |user_object|
        checkboxes.each do |key, checkbox_genre|
          @user_genre_str = String.new
          @key_str = String.new
          @user_genre_str = user_object[:genre]
          @key_str = key.to_s
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object)
            break
          end
        end
      end
    end
    
    # 1st check that there are any params worth searching
    if params_arg[:experience] != ''
      if(@genre_checked_array.length > 0)
        # Can search by experience & previous genre-checked results
        @genre_checked_array.each do |user_object|
          if SpecificPhotographer.where("user_key ILIKE ? AND experience ILIKE ?)" , user_object[:user_key], @experiece_arg)
            @return_array.push(user_object[:user_key])
          end
        end
      else
        # Can search by experience but have no previous genre-checked results
        # Search entire model and check for the params
        SpecificPhotographer.all.find_each do |user_object|
          if params_arg[:experience] == user_object[:experience]
            @return_array.push(user_object[:user_key])
          end
        end
      end
    else
      if(@genre_checked_array.length > 0)
        # Have no experience to search by but have genre-checks
        # Return genre-checked results
        @genre_checked_array.each do |user_object|
          @return_array.push(user_object[:user_key])
        end
      else
        # Have no experience to search by and no genre-checked results
        # Return everything in the table
        if (checkboxes.nil? || params_arg.nil?)
          SpecificPhotographer.all.find_each do |user_object|
            @return_array.push(user_object[:user_key]) 
          end
        end
      end
    end
    
    #Ranks users for how closely they matched the search params.
    @return_array.each do |user_key|
      @priority_counter = 0
      @user = SpecificPhotographer.find_by(user_key: user_key)
      
      if !checkboxes.nil?
        checkboxes.each do |key, checkbox_genre|
          if @user[:genre].to_s.include? key.to_s
            @priority_counter = @priority_counter + 1
          end
        end
      end

      if @user[:experience] == params_arg[:experience]
        @priority_counter = @priority_counter + 1
      end
      
      @priority_hash.store(@user[:user_key], @priority_counter)
    end
    
    @priority_hash = @priority_hash.sort_by {|k,v| v}.reverse
    
    @priority_hash.each do |user_key, value|
      @priority_return_array.push(user_key)
    end

    @final_return = []

    puts "----"
    puts params_arg.inspect

    if params_arg.length > 0
      GeneralInfo.all.find_each do |user_object|
        if user_object[:specific_profile_id] == 3
          puts user_object.inspect

          incl = true
          params_arg.each do |param_key, param_val|
            if user_object[param_key] != param_val
              incl = false
            end
          end

          if incl
            @final_return.push(user_object[:userKey])
          end
        end
      end
    else
      return @priority_return_array
    end
    
    return @final_return
  end
  
  # Sets appearance of profile view attributes
  def attribute_values 
    @attribute_values = Hash.new
    @attribute_values[:influencers] = "Influencers: " + self.influencers.to_s
    @attribute_values[:specialties] = "Specialities: " + self.specialties.to_s
    @attribute_values[:compensation] = "Compensation: " + self.compensation.to_s
    @attribute_values[:experience] = "Experience: " + self.experience.to_s
    
    @attribute_values[:genre] = "Genre(s): "
    if self.genre != nil
      self.genre.split(",").each do |genre|
        @attribute_values[:genre] += genre + ", "
      end
      @attribute_values[:genre] = @attribute_values[:genre][0, @attribute_values[:genre].length-2]
    end
    
    @attribute_values
  end
end
