module Enumerable
  # Your code goes here
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
