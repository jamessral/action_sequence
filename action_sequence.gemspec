# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'action_sequence'
  s.version = '0.0.1'
  s.date = '2019-12-18'
  s.summary = 'A small gem for managing sequences of actions over a shared-context'
  s.description = 'A small gem for managing sequences of actions over a shared-context'
  s.authors = ['James A. Sral']
  s.email = 'jamessral@gmail.com'
  s.files = [
    'lib/action_sequence.rb',
    'lib/action_sequence/context.rb',
    'lib/action_sequence/sequence.rb',
    'lib/action_sequence/transaction_sequence.rb'
  ]
  s.homepage =
    'https://rubygems.org/gems/action_sequence'
  s.license = 'MIT'
end
