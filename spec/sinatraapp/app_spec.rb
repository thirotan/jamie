require './spec/spec_helper'
require 'sinatraapp/app'                                                                                                                   
                                                                                                                                             
describe 'sinatraapp/app.rb' do                                                                                                                   
                                                                                                                                             
  describe 'GET /' do                                                                                                             
    it 'should get page index 200' do                                                                                                                   
      get '/'                                                                                                                                
      expect(last_response).to be_ok                                                                                                         
    end                                                                                                                                      
  end

  describe 'POST /add' do
    before { @entry = add_entry('test_user1', 'test entry') }
    #投稿失敗
    describe "with invalid attributes" do
      it "does not save the new entry" do
      end
      it "redirect to top page" do
      end
    end

    #投稿成功
    describe "with valid attributes" do
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
