# frozen_string_literal: true

module ActionSequence
  ###
  # A Sequence calls an array of actions over a shared context,
  # skipping the remaining actions if the context has failed
  ##
  class Sequence
    def initialize(actions: [], initial_context: {})
      @actions = actions
      @context = Context.new(initial_context: initial_context)
    end

    def call
      actions.each do |action|
        return context if context.failed?

        action.call(context)
      end

      context
    end

    private

    attr_reader :actions, :context
  end
end
