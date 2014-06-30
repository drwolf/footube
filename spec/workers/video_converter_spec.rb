require 'spec_helper'

describe VideoConverter do

  describe '#perform' do

    before :each do
      FileUtils.stub(:mkdir_p)
      @converter = VideoConverter.new
      @video = FactoryGirl.create(:video).reload
    end

    it 'generates a screenshot and transcoded video for the given resolution' do
      ffmpeg_mock = double()
      FFMPEG::Movie.stub(:new).and_return(ffmpeg_mock)
      ffmpeg_mock.should_receive(:screenshot)
      ffmpeg_mock.should_receive(:transcode)
      @converter.perform(@video.id, '320x200')
    end

    it 'creates a new version and sets processed to 100 percent when done' do
      Video.stub(:find).and_return(@video)
      version = FactoryGirl.create(:video_version, video: @video, resolution: 'this one')
      ffmpeg_mock = double()
      FFMPEG::Movie.stub(:new).and_return(ffmpeg_mock)
      ffmpeg_mock.should_receive(:screenshot)
      ffmpeg_mock.should_receive(:transcode)
        .and_yield(0.0012345678) # 1
        .and_yield(0.0512345678) # 2
        .and_yield(0.0512345679) # 2
        .and_yield(0.0512345680) # 2
        .and_yield(0.2012345678) # 3
        .and_yield(1.0000000000) # 4
      @video.versions.stub(:create).and_return(version)
      version.should_receive(:save).exactly(5).times
      @converter.perform(@video.id, '320x200')
      expect(version).to be_instance_of VideoVersion
      expect(version.processed).to be true
      expect(version.progress).to eq 100.0
    end

    it 'does not create a new version if there is already one for the resolution' do
      ffmpeg_mock = double()
      ffmpeg_mock.stub(:screenshot)
      ffmpeg_mock.stub(:transcode)
      FFMPEG::Movie.stub(:new).and_return(ffmpeg_mock)
      FileUtils.stub(:mkdir_p)
      FactoryGirl.create(:video_version, video: @video, resolution: '320x200')
      expect {
        @converter.perform(@video.id, '320x200')
      }.to raise_error
    end

  end

end