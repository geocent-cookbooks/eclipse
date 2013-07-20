require 'minitest/spec'

require File.expand_path('../support/helpers', __FILE__)

describe 'eclipse::default' do

  include Helpers::Eclipse
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  # Example spec tests can be found at http://git.io/Fahwsw
  it 'runs no tests by default' do
  end

end
