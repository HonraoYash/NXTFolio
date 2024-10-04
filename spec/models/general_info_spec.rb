# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeneralInfo, type: :model do
  let(:general_info) do
    described_class.create(id: 11, first_name: 'John', last_name: 'Johns', city: 'Houston', state: 'Texas',
<<<<<<< HEAD
                           country: 'United States', company: 'test company', industry: 'Creator',
                           highlights: 'test', emailaddr: 'abcd@email.com')
  end
  let(:general_info_two) do
    described_class.create(id: 10, first_name: 'David', last_name: 'Johns', city: 'Houston', state: 'Texas',
                           country: 'United States', company: 'test company', industry: 'Creator',
                           highlights: 'test', emailaddr: 'abcd2@email.com')
=======
                           country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd@email.com')
  end
  let(:general_info_2) do
    described_class.create(id: 10, first_name: 'David', last_name: 'Johns', city: 'Houston', state: 'Texas',
                           country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd2@email.com')
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
  end

  describe '#address' do
    subject(:address) { general_info.address }
    it 'returns the address' do
      expect(address).to eq('Houston, Texas, United States')
    end
  end

  describe '#attribute_values' do
    subject(:attribute_values) { general_info.attribute_values }
    it 'generates proper attribute_values' do
      expect(attribute_values).not_to eq(nil)
    end
  end

  describe '#follow' do
    subject(:follow) { general_info.follow(10) }
    it 'follow the given user' do
<<<<<<< HEAD
      expect(general_info_two.id).to eq(10)
=======
      expect(general_info_2.id).to eq(10)
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      expect(follow).not_to eq(nil)
    end
  end

  describe '#unfollow' do
    subject(:follow) { general_info.follow(10) }
    subject(:unfollow) { general_info.unfollow(10) }
    it 'unfollow the given user' do
<<<<<<< HEAD
      expect(general_info_two.id).to eq(10)
=======
      expect(general_info_2.id).to eq(10)
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      expect(unfollow).not_to eq(nil)
    end
  end

  describe '#get_users_they_follow' do
    subject(:follow) { general_info.follow(10) }
    subject(:follow_list) { general_info.get_users_they_follow }
    it 'get_users_they_follow' do
<<<<<<< HEAD
      expect(general_info_two.id).to eq(10)
=======
      expect(general_info_2.id).to eq(10)
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      expect(follow_list).not_to eq(nil)
    end
  end

  describe '#get_followers' do
    subject(:follow) { general_info.follow(10) }
<<<<<<< HEAD
    subject(:follower_list) { general_info_two.get_followers }
    it 'get_followers' do
      expect(general_info_two.id).to eq(10)
=======
    subject(:follower_list) { general_info_2.get_followers }
    it 'get_followers' do
      expect(general_info_2.id).to eq(10)
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      expect(follower_list).not_to eq(nil)
    end
  end

  describe '.search' do
<<<<<<< HEAD
    subject(:search_result_one) do
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', gender: 'male', compensation: '100',
                           job_type: 'Model', location: 'Houston', distance: '100' })
    end
    subject(:search_result_two) do
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', first_name_regex: 'Contains',
                           last_name_regex: 'Contains' })
    end
    subject(:search_result_three) do
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', first_name_regex: 'Starts With',
                           last_name_regex: 'Starts With' })
    end
    subject(:search_result_four) do
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', first_name_regex: 'Ends With',
                           last_name_regex: 'Ends With' })
    end
    subject(:search_result_five) do
=======
    subject(:search_result_1) do
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', gender: 'male', compensation: '100', job_type: 'Model',
                           location: 'Houston', distance: '100' })
    end
    subject(:search_result_2) do
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', first_name_regex: 'Contains',
                           last_name_regex: 'Contains' })
    end
    subject(:search_result_3) do
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', first_name_regex: 'Starts With',
                           last_name_regex: 'Starts With' })
    end
    subject(:search_result_4) do
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', first_name_regex: 'Ends With',
                           last_name_regex: 'Ends With' })
    end
    subject(:search_result_5) do
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      GeneralInfo.search({ first_name: 'david', last_name: 'Johns', first_name_regex: 'Exactly Matches',
                           last_name_regex: 'Exactly Matches' })
    end
    it 'search for users' do
<<<<<<< HEAD
      expect(search_result_one).not_to eq(nil)
      expect(search_result_two).not_to eq(nil)
      expect(search_result_three).not_to eq(nil)
      expect(search_result_four).not_to eq(nil)
      expect(search_result_five).not_to eq(nil)
=======
      expect(search_result_1).not_to eq(nil)
      expect(search_result_2).not_to eq(nil)
      expect(search_result_3).not_to eq(nil)
      expect(search_result_4).not_to eq(nil)
      expect(search_result_5).not_to eq(nil)
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
    end
  end

  describe '.see_Types' do
    it 'see_Types' do
      expect(GeneralInfo.see_Types).not_to eq(nil)
    end
  end

  describe '.check_Job' do
    it 'check_Job' do
      expect(GeneralInfo.check_Job?('notAdmin')).not_to eq(nil)
    end
  end

  describe '.delete_Job' do
    it 'delete_Job' do
      expect(GeneralInfo.delete_Job('Admin')).to eq(nil)
    end
  end

  describe '.create_Job' do
    it 'create_Job' do
      expect(GeneralInfo.create_Job('NewJobClass', true)).to eq(nil)
      new_class = Object.const_get('NewJobClass')

      expect(new_class.display_Name).not_to eq(nil)
      expect(new_class.add_Attr('test_name')).to eq(nil)
      expect(new_class.edit_Attr('test_name', 'new_test_name', %w[String String String String])).to eq(nil)
      expect(new_class.delete_Attr('new_test_name')).to eq(nil)
      expect(new_class.view_Attr).not_to eq(nil)
      expect(new_class.view_Attr_Type).not_to eq(nil)
      expect(new_class.view_Attr_Type('test_name')).to eq(nil)
      expect(new_class.view_Attr_Type('String')).not_to eq(nil)
      expect(new_class.update_File).to eq(nil)
    end
  end

  describe '.filterBy' do
    it 'filterBy' do
      expect(GeneralInfo.filterBy('United States', 'Texas', 'Model', 'Houston')).not_to eq(nil)
    end
  end
end
