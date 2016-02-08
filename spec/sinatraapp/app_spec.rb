require './spec/spec_helper'
require 'sinatraapp/app'                                                                                                                   
                                                                                                                                             
describe 'sinatraapp/app.rb' do                                                                                                                   
                                                                                                                                             
  describe 'GET /' do                                                                                                             
    it 'redirect to top page' do                                                                                                                   
      visit '/'
      expect(page).to have_content('新規投稿')
    end                                                                                                                                      
  end

  describe 'POST /add' do
    #投稿失敗
    describe "with invalid attributes" do
      before do
        visit '/'
        within('#post-entry') do
          fill_in "body", with:""
          fill_in "name", with:"post test"
          click_button "POST"
        end
      end

      it "does not save the new entry" do
        expect(page).to have_content('本文に何も書いてないです')
      end
    end

    #投稿成功
    describe "with valid attributes" do
      before do
        visit '/'
        within('#post-entry') do
          fill_in "body", with:"post entry test"
          fill_in "name", with:"post test"
          click_button "POST"
        end
      end

      it "redirect to top page" do
        expect(page).to be_has_content('post entry test')
      end
    end
  end                                                                                                                                        
end   
