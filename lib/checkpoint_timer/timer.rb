require 'pry'

module CheckpointTimer
  class TimerNotStartedError < StandardError
  end

  class Timer
    attr_reader :current_time,
                :previous_time,
                :start_time,
                :checkpoint_counter,
                :log_all

    def initialize(log_all: false)
      @log_all = log_all
    end

    def start
      @checkpoint_counter = 0
      @start_time = Time.now
      @current_time = start_time
    end

    # @param message [String]
    # @return [Fixnum]
    def checkpoint(logging: false, message: nil)
      raise TimerNotStartedError unless start_time
      @previous_time = current_time
      set_current_time
      iterate_counter

      log_checkpoint(message) if logging || log_all?
      elapsed_time
    end

    # @return [Fixnum]
    def total_checkpoint_time
      current_time - start_time
    end

    private

    # @param message [String]
    def log_checkpoint(message)
      puts "Checkpoint: #{checkpoint_counter}"
      puts message if message
      puts "Elapsed time since last checkpoint: #{format('%.3f', elapsed_time)}"
    end

    def iterate_counter
      @checkpoint_counter += 1
    end

    def set_current_time
      @current_time = Time.now
    end

    # @return [Fixnum]
    def elapsed_time
      current_time - previous_time
    end

    # @return [Boolean]
    def log_all?
      !!log_all
    end
  end
end
