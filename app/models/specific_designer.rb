# frozen_string_literal: true

class SpecificDesigner < ApplicationRecord
  attr_accessor :allgenres

  def self.search(checkboxes, general_info_user_keys, experience_arg)
    @user_array = []
    @genre_checked_array = []
    @return_array = []

    # Search based on the room keys retrieved from GeneralInfo, store into @user_array
    if general_info_user_keys.length.positive?
      # Gets here if general_info_user_keys has entries
      general_info_user_keys.each do |user_key_element|
        if SpecificDesigner.exists?(user_key: user_key_element)
          @user_array.push(SpecificDesigner.find_by(user_key: user_key_element))
        end
      end
    else
      # Gets here if nothing came through general_info_user_keys
    end

    # Genre requires a slightly different search
    # For every room in user_array, check if A genre matches ANY genre
    # If there are no genres, loop through @user_array & push the keys into @genre_checked_array
    if checkboxes.nil?
      # Gets here if genre is empty
      # Leave genre checked hash empty since we're not searching for genres
    elsif @user_array.length <= 0
      # They did not search for anything in GeneralInfo and room array never got populated,
      # Therefore they are looking for everyone in the profession, using genres
      SpecificDesigner.all.find_each do |user_object|
        checkboxes.each_key do |key|
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object)
            break
          end
        end
      end
    else
      # Gets here if user_array has entries
      @user_array.each do |user_object|
        checkboxes.each_key do |key|
          if user_object[:genre].to_s.include? key.to_s
            @genre_checked_array.push(user_object)
            break
          end
        end
      end
    end

    # 1st check that there are any params worth searching
    if !experience_arg.nil?
      if @genre_checked_array.length.positive?
        # Can search by experience & previous genre-checked results
        @genre_checked_array.each do |user_object|
          if SpecificDesigner.where('user_key ILIKE ? AND experience ILIKE ?)', user_object[:user_key],
                                    @experiece_arg)
            @return_array.push(user_object[:user_key])
          end
        end
      else
        # Can search by experience but have no previous genre-checked results
        # Search entire model and check for the params
        SpecificDesigner.all.find_each do |user_object|
          if SpecificDesigner.where('user_key ILIKE ?', user_object[:user_key])
            @return_array.push(user_object[:user_key]) # Might need to find by instead... very worse in efficiency tbh.
          end
        end
      end
    elsif @genre_checked_array.length.positive?
      @genre_checked_array.each do |user_object|
        @return_array.push(user_object[:user_key])
      end
    # Have no experience to search by but have genre-checks
    # Return genre-checked results
    else
      # Have no experience to search by and no genre-checked results
      # Return everything in the table
      SpecificDesigner.all.find_each do |user_object|
        @return_array.push(user_object[:user_key])
      end
    end

    @return_array
  end

  # Sets appearance of profile view attributes
  def attribute_values
    @attribute_values = {}
    @attribute_values[:influencers] = "Influencers: #{influencers}"
    @attribute_values[:specialties] = "Specialities: #{specialties}"
    @attribute_values[:compensation] = "Compensation: #{compensation}"
    @attribute_values[:experience] = "Experience: #{experience}"

    @attribute_values[:genre] = 'Genre(s): '
    unless genre.nil?
      genre.split(',').each do |genre|
        @attribute_values[:genre] += "#{genre}, "
      end
      @attribute_values[:genre] = @attribute_values[:genre][0, @attribute_values[:genre].length - 2]
    end

    @attribute_values
  end
end
