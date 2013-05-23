

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
      @child = NIL
    end

  end

  def initialize
    puts "initialize FibonacciHeap"
    @min = NIL
    @rootList = []
    @A = []
    @maxDegree = 0
    @n = 0
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

  def consolidate
    (0..@maxDegree).each {|i| @A[i] = NIL}
    
    @rootList.each do |w|
      x = w
      d = x.degree
      while @A[d] != NIL
        y = @A[d]
        if x.key > y.key
          temp = x
          x = y
          y = temp
        end
        link(y,x)
        @A[d] = NIL
        d += 1
      end
      @A[d] = x
    end
    @min = NIL
    (0..@maxDegree).each do |i|
      if @A[i] != NIL
        if @min == NIL
          @rootList = NIL
          @rootList << @A[i]
          @min = @A[i]
        else
          @rootList << @A[i]
          if @A[i].key < @min.key
            @min = @A[i]
          end
        end
      end
    end
  end

  def link(y,x)
    @rootList.delete(y)
    y.p = x
    x.degree +=1
    y.mark = false
  end

  def delete(x)
    decrease(x,-1)
    extractmin()
  end

  def extractmin()
    z = @min
    if z != NIL
      c = z.child
      begin
        @rootList << c
        c.p = NIL
        c = c.right
      end while c != z.child
      if z == z.right
        @min = NIL
      elsif @min == z.right
        consolidate
      end
      @n -= 1
    end
    return z
  end

  def insert(x)
    x.degree = 0
    x.p = NIL
    x.child = NIL
    x.mark = false
    if @min == NIL
      @rootList << x
      @min = x
    else
      @rootList << x
      if x.key < @min.key
        @min = x
      end
    end
    @n += 1
  end

end

f = FibonacciHeap.new


