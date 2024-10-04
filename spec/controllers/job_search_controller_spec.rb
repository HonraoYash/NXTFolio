# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JobSearchController, type: :controller do
  describe 'GET#jobshow' do
    it 'should show jobs' do
      session[:current_user_key] = SecureRandom.hex(10)
      GeneralInfo.create(first_name: 'R', last_name: 'Spec', company: 'Test', industry: 'Test',
<<<<<<< HEAD
                         highlights: 'test', country: 'United States', state: 'California', city: 'San Jose',
                         emailaddr: 'test@gmail.com', userKey: session[:current_user_key])
=======
                         highlights: 'test', country: 'United States', state: 'California', city: 'San Jose', emailaddr: 'test@gmail.com', userKey: session[:current_user_key])
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      get :jobshow
    end
  end
end
