require_relative 'strategy'

class Class
  def strategy(strategy_hash)
    const_set :Strategy, strategy_hash
  end

  def uses(a_module)
    include Strategy
    if const_get(:Strategy) == Strategy
      method = instance_method(:default_strategy)
    else
      method = instance_method(const_get(:Strategy))
    end
    new_module = method.bind(self).call a_module
    include new_module
  end
end