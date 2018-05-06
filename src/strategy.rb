module Strategy
  def default_strategy(a_module)
    new_module = Module.new
    a_module.const_get(:Methods).each do |method_name, block|
      if(block.is_a? Array)
        new_module.send(:define_method, method_name){
          raise "Metodo conflictivo"
        }
      else
        new_module.send(:define_method, method_name, block)
      end
    end
    new_module
  end

  def execute_all(a_module)
    new_module = Module.new
    a_module.const_get(:Methods).each do |method_name, block|
      if block.is_a? Array
        new_module.send(:define_method, method_name){
          block.each { |code| code }
          #Problema aca
        }
      else
        new_module.send(:define_method, method_name, block)
      end
    end
    new_module
  end
end