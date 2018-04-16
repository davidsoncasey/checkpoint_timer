require 'checkpoint_timer'

describe CheckpointTimer::Timer do
  let(:instance) { described_class.new }

  describe '#start' do
    subject do
      instance.start
    end

    it 'sets checkpoint_counter to 0' do
      subject
      expect(instance.checkpoint_counter).to eq 0
    end

    it 'sets start_time and current_time' do
      subject
      expect(instance.start_time).to_not be nil
      expect(instance.current_time).to_not be nil
    end
  end

  describe '#checkpoint' do
    subject do
      instance.checkpoint
    end

    context 'when timer has not been started' do
      it 'raises CheckpointTimer::TimerNotStartedError' do
        expect { subject }.to raise_error(CheckpointTimer::TimerNotStartedError)
      end
    end

    context 'when timer has been started' do
      before(:each) { instance.start }

      it 'sets checkpoint counter' do
        subject
        expect(instance.checkpoint_counter).to eq 1
      end

      it 'returns a nonzero number' do
        expect(subject).to be > 0
      end

      context 'when logging is enabled' do
        context 'and message is nil' do
          subject do
            instance.checkpoint(logging: true)
          end
          it 'logs checkpoint to standard out' do
            expect { subject }.to output(/Checkpoint/).to_stdout
          end
        end

        context 'and message is present' do
          let(:message) { 'hello' }

          subject do
            instance.checkpoint(logging: true, message: message)
          end

          it 'outputs message' do
            expect{ subject }.to output(/#{message}/).to_stdout
          end
        end
      end
    end
  end
end
