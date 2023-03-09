require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Entangle do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ entangle }).should.be.instance_of Command::Entangle
      end
    end
  end
end

