#!/usr/bin/ruby
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'plexus'
require 'plexus/dot'

include Plexus

class Node
  attr_reader :id, :player
  def initialize(id, player)
    @id = id
    @player = player
  end

  def to_s
    "[" + id.to_s + "," + player.to_s + "]"
  end
end

class Game
  attr_accessor :arena
  def initialize
    @arena = DirectedMultiGraph.new
  end

  def addNode(v)
    @arena.add_vertex(v)
  end

  def addEdge(v,w)
    @arena.add_edge(v,w)
  end

  def exportToPng
    @arena.write_to_graphic_file
  end

end

a = Node.new(:a, 0)
b = Node.new(:b, 0)
c = Node.new(:c, 1)

g = Game.new

g.addNode(a)
g.addNode(b)
g.addNode(c)

puts g.arena.vertices.to_s + "bla"