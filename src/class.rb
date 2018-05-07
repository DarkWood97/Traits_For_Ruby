require_relative 'strategy'

class Class
  def strategy(strategy_hash)
    const_set :Strategy, strategy_hash
  end

  def uses(a_module)
    include Strategy
    if const_get(:Strategy) == Strategy
      method = instance_method(:default_strategy)
      new_module = method.bind(self).call a_module
    elsif const_get(:Strategy).is_a? Array
      method = instance_method(const_get(:Strategy)[0])
      new_module = method.bind(self).call const_get(:Strategy)[1], a_module
    elsif const_get(:Strategy).is_a? Proc
      new_module = const_get(:Strategy).call a_module
    else
      method = instance_method(const_get(:Strategy))
      new_module = method.bind(self).call a_module
    end

    include new_module
  end
end

estragia = {:default_strategy=> [metodo1, metodo2], :execute_all=>[metodo3]}

