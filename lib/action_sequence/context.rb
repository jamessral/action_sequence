# frozen_string_literal: true

require 'forwardable'

module ActionSequence
  ###
  # Context container to hold state for an
  # Sequence of Actions
  ##
  class Context
    extend Forwardable
    attr_reader :error_message

    def_delegators :@context, :fetch

    def initialize(initial_context: {})
      @context = initial_context
      @error_message = nil
    end

    def add_to_context!(hash)
      context.merge!(hash)
    end

    def failed?
      !error_message.nil?
    end

    def success?
      error_message.nil?
    end

    def fail_context!(error_message)
      @error_message = error_message
    end

    private

    attr_reader :context
  end
end
