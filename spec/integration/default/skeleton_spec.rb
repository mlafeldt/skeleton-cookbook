require File.expand_path('../../spec_helper', __FILE__)

describe 'default node' do
  describe package('tree') do
    it { should be_installed }
  end
end
