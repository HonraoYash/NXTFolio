# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoginInfo, type: :model do
  let(:login_info) { described_class.create(id: 11, email: 'abcd@email', password: 'aA1!') }
  # let(:general_info_2) { described_class.create(id: 10, first_name: 'David', last_name: 'Johns', city: 'Houston', state: 'Texas', country: 'United States', company: 'test company', industry: 'Creator', highlights: 'test', emailaddr: 'abcd2@email.com') }

  describe '.search' do
    subject(:search_result_1) { LoginInfo.search({ email: 'abcd@email', email_regex: nil }) }
    subject(:search_result_2) { LoginInfo.search({ email: 'abcd@email', email_regex: 'Contains' }) }
    subject(:search_result_3) { LoginInfo.search({ email: 'abcd@email', email_regex: 'Starts With' }) }
    subject(:search_result_4) { LoginInfo.search({ email: 'abcd@email', email_regex: 'Ends With' }) }
    subject(:search_result_5) { LoginInfo.search({ email: 'abcd@email', email_regex: 'Exactly Matches' }) }
    subject(:search_result_6) { LoginInfo.search({ email_regex: 'smothing else' }) }
    it 'search for users' do
      expect(search_result_1).not_to eq(nil)
      expect(search_result_2).not_to eq(nil)
      expect(search_result_3).not_to eq(nil)
      expect(search_result_4).not_to eq(nil)
      expect(search_result_5).not_to eq(nil)
      expect(search_result_6).not_to eq(nil)
    end
  end

  describe '#validate_pwd' do
    it 'validate pwd' do
      expect(login_info.validate_pwd).not_to eq(nil)
    end
  end
end
