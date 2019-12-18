# frozen_string_literal: true

module ActionSequence
  ###
  # A Sequence that calls its actions in a transaction
  ##
  class TransactionSequence < Sequence
    def call
      ::ActiveRecord::Base.transaction do
        super
      end
    end
  end
end
