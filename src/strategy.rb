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
        new_module.send(:define_method, method_name)do
          block.each do |a_block|
            a_block.call
          end
        end
      else
        new_module.send(:define_method, method_name, block)
      end
    end
    new_module
  end


end