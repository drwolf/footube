require 'spec_helper'

describe Video do

  describe '#new' do
    
    it 'sets the processed to false as default' do
      video = Video.new title: 'Hello World', description: 'What the fuck?'
      expect(video.processed).to be_false
    end
    
  end

  describe '.create_missing_versions' do

    before do
      ffmpeg_stub = double()
      ffmpeg_stub.stub(:screenshot)
      ffmpeg_stub.stub(:transcode)
      FFMPEG::Movie.stub(:new).and_return(ffmpeg_stub)
      FileUtils.stub(:mkdir_p)
    end

    it 'creates missing versions for all videos' do
      stub_const("Video::RESOLUTIONS", %w{320x200 640x480})
      video = FactoryGirl.create(:video).reload
      FactoryGirl.create(:video_version, video: video, resolution: '320x200')
      expect {
        Video.create_missing_versions
      }.to change { video.reload.versions.count }.by(1)
    end

  end

end
