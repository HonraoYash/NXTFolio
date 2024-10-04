# frozen_string_literal: true

module AttributeValues
  extend ActiveSupport::Concern

  def set_attribute_values
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
