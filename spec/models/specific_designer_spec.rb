# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SpecificDesigner, type: :model do
<<<<<<< HEAD
  describe 'search without user info' do
    it 'search with designer matching user info and genre info' do
      general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                                        country: 'United States', company: 'test company', industry: 'Creator',
                                        highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: general_info.userKey, influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any',
                                                 experience: '11+ years', genre: 'Art')
      checkboxes = { "Art": 'Art' }
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), '11+ years'
=======
  describe 'search' do
    it 'search with designer matching user info and genre info' do
      general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                                        country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: general_info.userKey, influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any', experience: '11+ years', genre: 'Art')
      checkboxes = { "Art": 'Art' }
      experience = '11+ years'
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), experience
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      expect(return_array[0]).to eq(specific_designer.user_key)
    end

    it 'search without designer matching user info' do
      GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
<<<<<<< HEAD
                         country: 'United States', company: 'test company', industry: 'Creator',
                         highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: SecureRandom.hex(10), influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any',
                                                 experience: '11+ years', genre: 'Art')
      checkboxes = { "Art": 'Art' }
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), '11+ years'
      expect(return_array[0]).to eq(specific_designer.user_key)
    end
  end
end

RSpec.describe SpecificDesigner, type: :model do
  describe 'search with genre info' do
    it 'search without designers matching genre info' do
      GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                         country: 'United States', company: 'test company', industry: 'Creator',
                         highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: SecureRandom.hex(10), influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any',
                                                 experience: '11+ years')
      checkboxes = { "Art": 'Art' }
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), '11+ years'
=======
                         country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: SecureRandom.hex(10), influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any', experience: '11+ years', genre: 'Art')
      checkboxes = { "Art": 'Art' }
      experience = '11+ years'
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), experience
      expect(return_array[0]).to eq(specific_designer.user_key)
    end

    it 'search without designers matching genre info' do
      GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                         country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: SecureRandom.hex(10), influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any', experience: '11+ years')
      checkboxes = { "Art": 'Art' }
      experience = '11+ years'
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), experience
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      expect(return_array[0]).to eq(specific_designer.user_key)
    end

    it 'search without experience but with genre info' do
      general_info = GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
<<<<<<< HEAD
                                        country: 'United States', company: 'test company', industry: 'Creator',
                                        highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: general_info.userKey, influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any',
                                                 experience: '11+ years', genre: 'Art')
      checkboxes = { "Art": 'Art' }
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), nil
      expect(return_array[0]).to eq(specific_designer.user_key)
    end
  end
end

RSpec.describe SpecificDesigner, type: :model do
  describe 'search without any genre' do
    it 'search without any experience or genre info' do
      GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                         country: 'United States', company: 'test company', industry: 'Creator',
                         highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: SecureRandom.hex(10), influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any',
                                                 experience: '11+ years')
      checkboxes = { "Art": 'Art' }
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), nil
=======
                                        country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: general_info.userKey, influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any', experience: '11+ years', genre: 'Art')
      checkboxes = { "Art": 'Art' }
      experience = nil
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), experience
      expect(return_array[0]).to eq(specific_designer.user_key)
    end

    it 'search without any experience or genre info' do
      GeneralInfo.create(first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
                         country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com', userKey: SecureRandom.hex(10))
      specific_designer = described_class.create(user_key: SecureRandom.hex(10), influencers: 'Me',
                                                 specialties: 'Being cool', compensation: 'Any', experience: '11+ years')
      checkboxes = { "Art": 'Art' }
      experience = nil
      return_array = SpecificDesigner.search checkboxes, GeneralInfo.pluck(:userKey), experience
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      expect(return_array[0]).to eq(specific_designer.user_key)
    end
  end

  describe 'attribute_values' do
    it 'attribute_values' do
      specific_designer = described_class.create(influencers: 'Me', specialties: 'Being cool',
                                                 compensation: 'Any', experience: '11+ years', genre: 'Art')
      specific_designer.attribute_values
    end
  end
end
