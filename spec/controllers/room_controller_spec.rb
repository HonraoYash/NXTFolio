# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomController, type: :controller do
  describe 'GET #show' do
    it 'should show the chatroom' do
      session[:current_user_key] = SecureRandom.hex(10)
      LoginInfo.create(email: 'test@test.com', password: 'Test#9', userKey: session[:current_user_key])
      general_info = GeneralInfo.create(first_name: 'R', last_name: 'Spec', company: 'Test', industry: 'Test',
<<<<<<< HEAD
                                        highlights: 'test', country: 'United States', state: 'California', city: 'San Jose',
                                        emailaddr: 'test@gmail.com', userKey: session[:current_user_key], notification: true)
=======
                                        highlights: 'test', country: 'United States', state: 'California', city: 'San Jose', emailaddr: 'test@gmail.com', userKey: session[:current_user_key], notification: true)
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      general_info.notification_from = [general_info.id]
      get :show, params: { id: general_info.id }
      expect(response).to have_http_status(:success)
    end

    it 'should show the chatroom with messages from a different user' do
      session[:current_user_key] = SecureRandom.hex(10)
      LoginInfo.create(email: 'test@test.com', password: 'Test#9', userKey: session[:current_user_key])
      general_info = GeneralInfo.create(first_name: 'R', last_name: 'Spec', company: 'Test', industry: 'Test',
<<<<<<< HEAD
                                        highlights: 'test', country: 'United States', state: 'California', city: 'San Jose',
                                        emailaddr: 'test@gmail.com', userKey: session[:current_user_key],
                                        notification: true, notification_from: [1])
=======
                                        highlights: 'test', country: 'United States', state: 'California', city: 'San Jose', emailaddr: 'test@gmail.com', userKey: session[:current_user_key], notification: true, notification_from: [1])
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      get :show, params: { id: general_info.id }
      expect(response).to have_http_status(:success)
    end

    it "doesn't return http success" do
      GeneralInfo.create(first_name: 'R', last_name: 'Spec', company: 'Test', industry: 'Test',
<<<<<<< HEAD
                         highlights: 'test', country: 'United States', state: 'California', city: 'San Jose',
                         emailaddr: 'test@gmail.com', userKey: session[:current_user_key])
=======
                         highlights: 'test', country: 'United States', state: 'California', city: 'San Jose', emailaddr: 'test@gmail.com', userKey: session[:current_user_key])
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      get :show
      expect(response).to redirect_to '/login_info/login'
    end
  end

  describe 'GET #create_message' do
    it 'should create a new chat message' do
      session[:current_user_key] = SecureRandom.hex(10)
      general_info = GeneralInfo.create(first_name: 'R', last_name: 'Spec', company: 'Test', industry: 'Test',
<<<<<<< HEAD
                                        highlights: 'test', country: 'United States', state: 'California', city: 'San Jose',
                                        emailaddr: 'test@gmail.com', userKey: session[:current_user_key])
=======
                                        highlights: 'test', country: 'United States', state: 'California', city: 'San Jose', emailaddr: 'test@gmail.com', userKey: session[:current_user_key])
>>>>>>> ba307ac00ee83b875eab1629d1aaf65172188590
      get :create_message, params: { id: general_info.id }
      expect(response).to redirect_to "/dm/#{general_info.id}"
    end

    it 'should not create a new chat message' do
      get :create_message, params: { id: 1 }
      expect(response).to redirect_to login_info_login_path
    end
  end
end
