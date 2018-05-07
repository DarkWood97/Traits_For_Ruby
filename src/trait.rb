require_relative 'class'
require_relative 'algebra'
require_relative 'strategy'
require_relative 'symbol'

class Trait
  def self.define(name, methods)
    Object.const_set name, Module.new
    Kernel.const_get(name).singleton_class.include(Algebra)
    Kernel.const_get(name).const_set :Methods, Hash.new
    methods.each do |method_name, block|
      Kernel.const_get(name).const_get(:Methods)[method_name] = block
    end
  end
end

Trait.define :MiTrait, {:my_method => proc{puts 'Hola'}, :my => proc{puts "deleted method"}}
Trait.define :MiOtroTrait, {:my_metho => proc{puts 'Hola'}, :my => proc{puts "deleted method"}}


class A
  uses MiTrait + MiOtroTrait
end

A.new.my_method

puts A.const_get :Strategy

puts A.new.methods.to_s

hash = {[1,2] => 1}

puts hash.to_s





