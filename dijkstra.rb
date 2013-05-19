#!/usr/bin/ruby

require "matrix"

class Knot
  attr_accessor :dist, :nome
  
  def initialize(dist, nome)
    @dist = dist
    @nome = nome
  end

end

class Dijkstra
  attr_accessor :m
  
  def initialize
    @m = Matrix[
      [0, 1, 1, 5],
      [0, 0, 0, 2],
      [0, 0, 0, 1],
      [0, 0, 0 ,0]
    ]
    @queue = [Knot.new(999, 0), Knot.new(999, 1), Knot.new(999, 2), Knot.new(999, 3)]
    @dist = Array.new(@m.row_size, 999)
    @prev = Array.new(@m.row_size)

  end

  def calcShortestPath(inicio, fim)
    
    @queue.map { |x| x.dist = 0 if x.nome == inicio }
    
    while (!@queue.empty?)
      sortDistVet()
      
      u = @queue.shift
      puts "u: #{u.nome}"
      
      puts "rowsize: #{@m.row_size}"
      (0..@m.row_size-1).each do |j| 
        edge_peso = @m[u.nome,j]
        puts "adj of #{u.nome}: #{j}, edge_peso: #{edge_peso}"
        if (edge_peso != 0 && @queue.any?{|item| item.nome == j})
          if (u.dist + edge_peso < @dist[j])
            puts "new min dist for j: #{j} is #{u.dist + edge_peso}"
            @dist[j] = u.dist + edge_peso
            @queue.map { |x| x.dist = @dist[j] if x.nome == j }
            @prev[j] = u.nome
          end
        end
      end
      
    end
    
    puts "previous:"
    @prev.each do |i|
      print i, ","
    end
  end

  def sortDistVet
    puts "before sort:\n"
    @queue.each do |knot|
       puts "nome: #{knot.nome} dist: #{knot.dist}"
    end
     
    #@queue = @queue.sort_by {|knot| [knot.dist]}
    @queue = @queue.sort {|a, b| a.dist <=> b.dist}
    
    puts "after sort:\n"
    @queue.each do |knot|
       puts "nome: #{knot.nome} dist: #{knot.dist}"
     end
     
  end
  
end

puts "Dijkstra - shortest path"
dij = Dijkstra.new
dij.calcShortestPath(0, 3)


