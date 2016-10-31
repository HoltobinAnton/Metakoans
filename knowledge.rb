class Module
def attribute(attr, &block)
  case attr
    when Hash
      name  = attr.keys[0]
      value = attr[name]
    when String, Symbol
      name  = attr
      value = nil
  end

  sym = name.to_sym
  instance_variable = :"@#{name}"

  define_method(:"#{name}?") do
    send(sym)
  end

  define_method(:"#{name}=") do |value|
    instance_variable_set(:"@#{name}", value)
  end

  define_method(sym) do
    if instance_variable_defined?(instance_variable)
      instance_variable_get(instance_variable)
    else
      block ? instance_eval(&block) : value
    end
  end
end
end
