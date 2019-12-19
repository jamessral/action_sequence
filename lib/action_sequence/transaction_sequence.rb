# frozen_string_literal: true

module ActionSequence
  ###
  # A Sequence that calls its actions in a transaction
  ##
  class TransactionSequence
    def initialize(actions: [], initial_context: {}, transaction:)
      @actions = actions
      @context = Context.new(initial_context: initial_context)
      @transaction = transaction
    end

    def call
      transaction do
        super
      end
    end

    private

    attr_reader :transaction
  end
end
