# frozen_string_literal: true

class Snowflake
  TIMESTAMP_BITS = 41
  SEQUENCE_BITS  = 12
  NODE_ID_BITS   = 10

  MAX_NODE_ID  = (1 << NODE_ID_BITS) # 1024
  MAX_SEQUENCE = (1 << SEQUENCE_BITS) # 4096

  @sequence = nil

  def initialize(sequence = 0)
    raise OverflowError, "invalid sequence (#{sequence} >= #{MAX_SEQUENCE})" if sequence >= MAX_SEQUENCE

    @sequence = sequence % MAX_SEQUENCE
  end

  def generate_id(target_time = nil)
    sequence = increment_sequence!

    time = format_time(target_time || current_time)

    compose(time, node_id, sequence)
  end

  def parse(flake_id)
    hash = {}
    hash[:epoch_time] = flake_id >> (SEQUENCE_BITS + NODE_ID_BITS)
    hash[:time]       = Time.at((hash[:epoch_time] + target_epoch) / 1000.0)
    hash[:node_id]    = (flake_id >> SEQUENCE_BITS).to_s(2)[-NODE_ID_BITS, NODE_ID_BITS].to_i(2)
    hash[:sequence]   = flake_id.to_s(2)[-SEQUENCE_BITS, SEQUENCE_BITS].to_i(2)
    hash
  end

  private

  def compose(time, node_id, sequence)
    ((time - target_epoch) << (SEQUENCE_BITS + NODE_ID_BITS)) +
      (node_id << SEQUENCE_BITS) +
      sequence
  end

  def format_time(time)
    time.strftime('%s%L').to_i
  end

  def current_time
    Time.now
  end

  def increment_sequence!
    @sequence = (@sequence + 1) % MAX_SEQUENCE
  end

  def target_epoch
    1_314_220_021_721
  end

  def node_id
    1
  end
end

class Snowflake::OverflowError < StandardError; end
