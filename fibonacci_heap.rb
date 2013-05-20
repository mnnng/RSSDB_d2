

class FibonacciHeap
  class Node

    attr_accessor :p, :mark
    
    def initialize
      puts "initialize Node"
      @p = NIL
      @mark = false
      @left = NIL
      @right = NIL
      @degree = 0
    end

  end

  def initialize
    puts "initialize FibonacciHeap"
    @min = NIL
    @rootList = NIL
  end

  def decreaseKey(x, k)
    x.key = k
    y = x.p
    if y != NIL and x.key < y.key
      cut(x, y)
      cascadingCut(y)
    end
    if (x.key < @min.key)
      @min = x
    end
  end
  
  def cut(x, y)
    x.p = NIL
    y.mark = true
    y.degree-=1
    rootList.push(x)
  end

  def cascadingCut(y)
    z = y.p
    if z != NIL
      if y.mark == false
        y.mark = true
      else
        cut(y, z)
        cascadingCut(z)
      end
    end
  end

end

f = FibonacciHeap.new

