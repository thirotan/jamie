require './spec/spec_helper'
require 'sinatraapp/app'                                                                                                                   
                                                                                                                                             
describe 'sinatraapp/app.rb' do                                                                                                                   
                                                                                                                                             
  describe 'GET /' do                                                                                                             
    it 'redirect to top page' do                                                                                                                   
      visit '/'
      expect(page).to be_has_content('新規投稿')
    end                                                                                                                                      
  end

  describe 'POST /add' do
    #投稿失敗
    describe "with invalid attributes" do

      it "does not save the new entry" do
        skip
      end

      it "redirect to top page" do
        skip
      end
    end

    #投稿成功
    describe "with valid attributes" do
      #before do
      #  visit '/'
      #  within('#post-entry') do
      #    fill_in "body", with:"post entry test"
      #    fill_in "name", with:"post test"
      #    click_button "POST"
      #  end
      #end

      #it "redirect to top page" do
      #  expect(page).to be_has_content('post entry test')
      #end
    end
  end                                                                                                                                        

  describe 'GET /entry/:id' do
    it 'show the new entry of entry page' do
        skip
        #expect(last_response).to be_ok                                                                                                         
        #expect(response).to render_template("/entry/#{id}")                                                                                                        
    end
    it 'show the new entry of raw text page' do
        skip
        #expect(last_response).to be_ok                                                                                                         
        #expect(response).to render_template("/entry/#{id}/raw")                                                                                                        
    end
    it 'show the new entry of markwodn page' do
       skip
        #expect(last_response).to be_ok
        #expect(response).to render_template("/entry/#{id}/markdown")
    end
  end
end   
