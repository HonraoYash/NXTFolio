# frozen_string_literal: true

class SpecificPhotographer < ApplicationRecord
<<<<<<< HEAD
=======
  include AttributeValues
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
  attr_accessor :allgenres

  def self.search(params_arg)
    @final_return = []

    if params_arg.length.positive?
      GeneralInfo.all.find_each do |user_object|
        if user_object[:specific_profile_id] == 3
          spec_object = SpecificPhotographer.find_by(user_key: user_object['userKey'])

          puts spec_object.inspect

          incl = true
          params_arg.each do |param_key, param_val|
            next if param_key == 'checkboxes'

            chk_val = user_object[param_key]

            if chk_val.nil?
              puts param_key
              chk_val = spec_object[param_key]
            end

            incl = false if chk_val != param_val
          end

          # GENRE CHECKING

          if spec_object
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
            else
              incl = false
            end

            @final_return.push(user_object[:userKey]) if incl
          else
            incl = false
          end
        end
      end
    else
      GeneralInfo.all.find_each do |user_object|
        @final_return.push(user_object[:userKey]) if user_object[:specific_profile_id] == 3
      end
    end

    @final_return
  end

  # Sets appearance of profile view attributes
  def attribute_values
<<<<<<< HEAD
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
=======
    set_attribute_values
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
  end
end
