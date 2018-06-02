# Custom array flatten method
#
# This code has been heavily influenced by: http://blog.prettymuchallofthetime.com/algorithms/2015/10/31/flattening-arrays.html
class ArrayUtils
  def self.flatten(array)
    array.reduce([]) do |result, item|
      if item.is_a? Array
        result + flatten(item)
      else
        result << item
      end
    end
  end
end
