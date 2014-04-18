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
  def initialize
    @arena = DirectedMultiGraph.new
  end

  def addNode(v)

  end
end

a = Node.new(:a, 0)
b = Node.new(:b, 0)
c = Node.new(:c, 1)

dg = DirectedMultiGraph[a,b, a,c, c,c]

dg.write_to_graphic_file