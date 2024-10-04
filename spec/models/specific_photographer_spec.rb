# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpecificPhotographer, type: :model do
  it 'handles search with both valid and invalid parameters' do
    general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                                      country: 'United States', company: 'test company', industry: 'Creator',
                                      highlights: 'test', emailaddr: 'abcd@email.com',
                                      userKey: SecureRandom.hex(10), specific_profile_id: 3)

    described_class.create({ user_key: general_info.userKey, influencers: 'Me',
                             specialties: 'Being cool', compensation: 'Any',
                             experience: '11+ years', genre: 'Acting' })

    # First test: search with valid parameters
    valid_params = { 'checkboxes' => ['Acting'] }
    valid_return = SpecificPhotographer.search valid_params
    expect(valid_return[0]).to eq(general_info.userKey)

    # Second test: search with invalid parameters
    invalid_params = { 'test' => 'test' }
    invalid_return = SpecificPhotographer.search invalid_params
    expect(invalid_return).to be_empty
  end
end

Rspec.describe SpecificPhotographer, type: :model do
  describe 'search without' do
    it 'handles search with and without parameters' do
      general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                                        country: 'United States', company: 'test company',
                                        industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com',
                                        userKey: SecureRandom.hex(10), specific_profile_id: 3)

      # First test: search without parameters
      params = {}
      final_return = SpecificPhotographer.search params
      expect(final_return[0]).to eq(general_info.userKey)

      # Second test: search with non-matching parameters
      params_with_checkboxes = { 'checkboxes' => ['Acting'] }
      final_return_with_checkboxes = SpecificPhotographer.search params_with_checkboxes
      expect(final_return_with_checkboxes).to be_empty
    end
  end

  describe 'attribute_values' do
    it 'attribute_values' do
      specific_photographer = described_class.create({ influencers: 'Me', specialties: 'Being cool',
                                                       compensation: 'Any', experience: '11+ years', genre: 'Acting' })
      specific_photographer.attribute_values
    end
  end
end
