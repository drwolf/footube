require 'spec_helper'

describe VideoVersionsController, type: :controller do

  describe 'GET /:video_id/:version_id/progress.json' do

    let(:video) { FactoryGirl.create(:video).reload }
    let(:version) { FactoryGirl.create(:video_version, video: video, progress: 45).reload }

    it 'returns the conversion progress of the given video version' do
      get :progress, video_id: video.id, version_id: version.id, format: :json
      expect(response).to be_succes
      json = JSON.parse(response.body)
      expect(json).to eq({ 'progress' => 45 })
    end

  end

end
