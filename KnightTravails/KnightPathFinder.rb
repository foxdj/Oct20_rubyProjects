# KnightPathFinder.rb
require_relative '00_tree_node'

class KnightPathFinder

    MOVES = [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
    ]

    def self.valid_moves(pos)
        valid_moves = []
        x, y = pos

        MOVES.each do |dx, dy|
            new_pos = [x + dx, y + dy]

            if new_pos.all? { |coord| coord.between?(0,7) }
                valid_moves << new_pos
            end
        end

        valid_moves
    end


    def initialize(starting_pos)
        @starting_pos = starting_pos
        @considered_pos = [starting_pos]

        build_move_tree
    end

    def build_move_tree
        self.root_node = PolyTreeNode.new(@starting_pos)
        nodes = [root_node]
        until nodes.empty?
            current_node = nodes.shift
            current_pos = current_node.value
            new_move_positions(current_pos).each do |next_pos|
                next_node = PolyTreeNode.new(next_pos)
                current_node.add_child(next_node)
                nodes << next_node
            end
        end
    end

    def new_move_positions(pos)
        KnightPathFinder.valid_moves(pos)
            .reject { |new_pos| considered_positions.include?(new_pos) }
            .each { |new_pos| considered_positions << new_pos }
    end

end