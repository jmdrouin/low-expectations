
# An Expectation, on an object *source*, is a temporary object that
# will delegate all methods to its source, and triggers an exception
# if the method returns false (expectation not met)
#
# Examples: Expectation.new(1) < 2   # is fine
#           Expectation.new(1) == 3  # triggers an exception

class Expectation < BasicObject

  def initialize(source)
    @source = source
  end

  undef :==, :!=, :!

  def inspect
    "Expectation on #{@source}"
  end

  def method_missing(name, *args)
    if @source.send(name, *args) == false
      raise "Expectation not met: #{@source} #{name} #{args.join(', ')}"
    end
  end
end
