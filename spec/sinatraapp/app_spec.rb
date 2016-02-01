require './spec/spec_helper'
require 'sinatraapp/app'                                                                                                                   
                                                                                                                                             
describe 'sinatraapp' do                                                                                                                   
                                                                                                                                             
  describe 'Home' do                                                                                                             
    it 'should get page index 200' do                                                                                                                   
      get '/'                                                                                                                                
      expect(last_response).to be_ok                                                                                                         
    end                                                                                                                                      
    describe 'create entry' do
      describe 'with invalid information'do
        it 'should not create entry' do
        end
        it 'error message ' do
        end
      end
      describe 'with valid information' do
        it 'should create entry' do 
        end
      end
    end
  end                                                                                                                                        


  describe 'entries' do
    describe 'separate view of entry page'
    
    describe 'separate view of raw text page' do
    end
    describe 'separate view of markwodn page' do
    end
  end


end   
