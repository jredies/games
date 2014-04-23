#!/usr/bin/ruby
require 'rubygems'
require 'bundler/setup'

# require your gems as usual
require 'plexus'
require 'plexus/dot'

include Plexus

class Array
	def exists?
		not self.all? { |x| not yield(x) }
	end
end

class Set
	def to_s
		s = "{ "
		for i in self
			s = s + i.to_s + " "
		end
		return s + "}"
	end
end


class Node
  attr_reader :id, :player
  def initialize(id, player)
    @id = id
    @player = player
  end

  def to_s
    "(" + id.to_s + "," + player.to_s + ")"
  end
end

class Game
  attr_accessor :arena
  def initialize
    @arena = DirectedMultiGraph.new
  end

  def add_node!(v)
    @arena.add_vertex! v
  end

  def add_edge!(v,w)
    @arena.add_edge!(v,w)
  end

  def output
    arena.write_to_graphic_file
  end

  def winningRegions
		w = Set.new

    arena.vertices.each { |v| w.add(v) if arena.out_degree(v) == 0 and v.player == 0}

		for i in (0..arena.vertices.size)
			print "Iteration: " + i.to_s

			for v in arena.vertices
				nv = arena.neighborhood(v,:out)
				if ( v.player == 0)
					w.add(v) if nv.all? { |x| w.include? x}
				else
					w.add(v) if nv.exists? { |x| w.include? x}
				end
			end

			puts w

		end

		return w

	end
end

g = Game.new
v = Node.new(:v,1)
u = Node.new(:u,1)
w = Node.new(:w,0)
t = Node.new(:t,0)
s = Node.new(:s,1)

g.add_node!(v)
g.add_node!(u)
g.add_node!(w)
g.add_node!(t)
g.add_node!(s)

g.add_edge!(v,u)
g.add_edge!(v,w)
g.add_edge!(w,t)
g.add_edge!(w,s)

g.output

g.winningRegions
