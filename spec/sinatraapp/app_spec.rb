require './spec/spec_helper'
require 'sinatraapp/app'                                                                                                                   
                                                                                                                                             
describe 'sinatraapp/app.rb' do                                                                                                                   
                                                                                                                                             
  describe 'GET /' do                                                                                                             
    it 'should get page index 200' do                                                                                                                   
      visit '/'                                                                                                                                
      expect(last_response).to be_ok                                                                                                         
    end                                                                                                                                      
  end

  describe 'POST /add' do
    #投稿失敗
    describe "with invalid attributes" do
      before { visit '/' }

      it "does not save the new entry" do
      end

      it "redirect to top page" do
      end
    end

    #投稿成功
    describe "with valid attributes" do
      before do
        get '/'
        within('#post-entry') do
          fill_in "body", with:"post entry test"
          fill_in "name", with:"post test"
          click_button "POST"
        end
      end

      it { is_expected.to respond_to(:entry_id) }
      it { is_expected.to respond_to(:entry) }
      it { is_expected.to respond_to(:name) }

      it "save the new entry" do
      end

      it "redirect to top page" do
      end
    end
  end                                                                                                                                        

  describe 'GET /entry/:id' do
    it 'show the new entry of entry page' do
    end
    it 'show the new entry of raw text page' do
    end
    it 'show the new entry of markwodn page' do
    end
  end
end   
