require './spec/spec_helper'
require 'sinatraapp/app'                                                                                                                   
                                                                                                                                             
describe 'sinatraapp' do                                                                                                                   
                                                                                                                                             
  describe 'should get index' do                                                                                                             
    it 'should get 200' do                                                                                                                   
      get '/'                                                                                                                                
      expect(last_response).to be_ok                                                                                                         
    end                                                                                                                                      
  end                                                                                                                                        
end   
