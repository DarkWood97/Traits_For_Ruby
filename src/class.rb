require_relative 'strategy'

class Class
  include Strategy
  def strategy(strategy_hash = nil)
    const_set :Strategy, strategy_hash
  end

  def uses(a_module)
    new_module = execute_all(a_module)
    include new_module

  end
end