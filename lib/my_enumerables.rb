module Enumerable
  # Your code goes here
  def my_all?
    return to_enum(:my_all?) unless block_given?

    self.my_each do |elem|
      return false unless yield(elem)
    end
    true
  end

  def my_any?
    return to_enum(:my_any?) unless block_given?

    self.my_each do |elem|
      return true if yield(elem)
    end
    false
  end

  def my_count(*args)

    if args.length == 1
      count = 0
      self.my_each do |elem|
        count+=1 if elem == args[0]
      end
      return count
    end
    return self.length unless block_given?
    
    count = 0
    self.my_each do |elem|
      count+=1 if yield(elem)
    end
    count
  end

end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array

  def my_each

  return to_enum(:my_each) unless block_given?

  index = 0
    while index < self.length
      yield(self[index])
    index += 1
    end
    self
  end
end
