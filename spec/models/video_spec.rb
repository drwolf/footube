require 'spec_helper'

describe Video do

  describe 'creating new instances' do
    
    it 'sets the processed to false as default' do
      video = Video.new title: 'Hello World', description: 'What the fuck?'
      expect(video.processed).to be_false
    end
    
  end

end
