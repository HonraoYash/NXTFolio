# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpecificPhotographer, type: :model do
<<<<<<< HEAD
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
=======
  describe 'search' do
    it 'search with valid parameters' do
      general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                                        country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 3)
      described_class.create({ user_key: general_info.userKey, influencers: 'Me',
                               specialties: 'Being cool', compensation: 'Any', experience: '11+ years', genre: 'Acting' })
      params = { 'checkboxes' => ['Acting'] }
      final_return = SpecificPhotographer.search params
      expect(final_return[0]).to eq(general_info.userKey)
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
    end
  end

<<<<<<< HEAD
  describe 'attribute_values' do
    it 'attribute_values' do
      specific_photographer = described_class.create({ influencers: 'Me', specialties: 'Being cool',
                                                       compensation: 'Any', experience: '11+ years', genre: 'Acting' })
      specific_photographer.attribute_values
    end
=======
    it 'search with invalid parameters' do
      general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                                        country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 3)
      described_class.create({ user_key: general_info.userKey, influencers: 'Me',
                               specialties: 'Being cool', compensation: 'Any', experience: '11+ years', genre: 'Acting' })
      params = { 'test' => 'test' }
      final_return = SpecificPhotographer.search params
      expect(final_return).to be_empty
    end

    it 'search without parameters' do
      general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                                        country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 3)
      params = {}
      final_return = SpecificPhotographer.search params
      expect(final_return[0]).to eq(general_info.userKey)
    end

    it 'search without existing photographer' do
      GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                         country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10), specific_profile_id: 3)
      params = { 'checkboxes' => ['Acting'] }
      final_return = SpecificPhotographer.search params
      expect(final_return).to be_empty
    end
  end

  describe 'attribute_values' do
    it 'attribute_values' do
      specific_photographer = described_class.create({ influencers: 'Me', specialties: 'Being cool',
                                                       compensation: 'Any', experience: '11+ years', genre: 'Acting' })
      specific_photographer.attribute_values
    end
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
  end
end
