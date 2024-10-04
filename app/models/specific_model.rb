# frozen_string_literal: true

class SpecificModel < ApplicationRecord
  attr_accessor :allgenres

  # params_arg are the params returned from the SpecificModel search but DOES NOT INCLUDE GENRE
  def self.search(params_arg)
    @final_return = []

    if params_arg.length.positive?
      GeneralInfo.all.find_each do |user_object|
        if user_object[:specific_profile_id] == 2
          spec_object = SpecificModel.find_by(user_key: user_object['userKey'])
          puts spec_object.inspect

          incl = true
          params_arg.each do |param_key, param_val|
            next if %w[checkboxes min_dress_size].include?(param_key)

            if %w[max_height min_height].include?(param_key)
              model_height_ft = 0
              model_height_in = 0

              model_height_ft = spec_object['height_feet'] unless spec_object['height_feet'].nil?

              model_height_in = spec_object['height_inches'] unless spec_object['height_inches'].nil?

              model_height_tot = (model_height_ft * 12) + model_height_in

              min_height = 0
              max_height = 99_999

              min_height = params_arg['min_height'].to_f if params_arg.include? 'min_height'

              max_height = params_arg['max_height'].to_f if params_arg.include? 'max_height'

              incl = false if model_height_tot < (min_height * 12) || model_height_tot > (max_height * 12)

              incl = model_dress_size.nonzero?
            elsif %w[max_dress_size min_dress_size].include?(param_key)

              model_dress_size = spec_object['dress_size']&.to_i
              min_size = params_arg['min_dress_size']&.to_i
              max_size = params_arg['max_dress_size']&.to_i
              puts min_size
              puts max_size
              puts model_dress_size
              incl = !(model_dress_size < min_size || model_dress_size > max_size)

              incl = model_dress_size.nonzero?
            else

              chk_val = user_object[param_key]

              if chk_val.nil?
                puts param_key
                chk_val = spec_object[param_key]
              end

              incl = (chk_val == param_val)
            end
          end

          # GENRE CHECKING

          if params_arg['checkboxes'] && incl && spec_object['genre']
            genre_arr = spec_object['genre'].split(',')

            puts genre_arr

            genre_incl = false
            params_arg['checkboxes'].each do |genre|
              if genre_arr.include? genre
                puts genre
                genre_incl = true
              end
            end

            incl = genre_incl
          end

          @final_return.push(user_object[:userKey]) if incl
        end
      end
    else
      GeneralInfo.all.find_each do |user_object|
        @final_return.push(user_object[:userKey]) if user_object[:specific_profile_id] == 2
      end
    end

    @final_return
  end

  # Sets appearance of profile view attributes
  def attribute_values
    @attribute_values = {}
    @attribute_values[:height] = "Height: #{height_feet} ft. #{height_inches} in."
    @attribute_values[:bust] = "Bust size: #{bust} in."
    @attribute_values[:waist] = "Waist size: #{bust} in."
    @attribute_values[:hips] = "Hips size: #{hips} in."
    @attribute_values[:cups] = "Cup size: #{cups}"
    @attribute_values[:shoe_size] = "Shoe size: #{shoe_size}"
    @attribute_values[:dress_size] = "Dress size: #{dress_size}"
    @attribute_values[:hair_color] = "Hair color: #{hair_color}"
    @attribute_values[:eye_color] = "Eye color: #{eye_color}"
    @attribute_values[:ethnicity] = "Ethnicity: #{ethnicity}"
    @attribute_values[:skin_color] = "Skin color: #{skin_color}"
    @attribute_values[:shoot_nudes] = "Shoots nudes: #{shoot_nudes}"
    @attribute_values[:tattoos] = "Has tattoos: #{tattoos}"
    @attribute_values[:piercings] = "Piercings: #{piercings}"
    @attribute_values[:experience] = "Experience: #{experience}"

    @attribute_values[:genre] = 'Genre: '
    unless genre.nil?
      genre.split(',').each do |genre|
        @attribute_values[:genre] += "#{genre}, "
      end
      @attribute_values[:genre] = @attribute_values[:genre][0, @attribute_values[:genre].length - 2]
    end

    @attribute_values
  end
end
