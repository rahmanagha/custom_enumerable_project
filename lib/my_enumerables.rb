module Enumerable
  # Your code goes here
  def my_all?
    return to_enum(:my_all?) unless block_given?

    self.my_each do |elem|
      return false unless yield(elem)
    end
    true
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array

  def my_each
  index = 0
    while index < self.length
      yield(self[index])
    index += 1
    end
    self
  end
end
