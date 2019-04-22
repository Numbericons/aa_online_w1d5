require_relative '00_tree_node.rb'
require 'byebug'

#pos = [3,3]
    #[4,5], [5,4] [5,2], [4,1], [2,1], [1,2], [1,4], [2,5]
    #[4,5], [4,1]   

class KnightPathFinder
    attr_reader :root_node
    attr_accessor :considered_positions
    
    # pos = [3,3]
    def self.valid_moves(pos) #check pos is on the board
        valid = []
        (-2..2).each do |num|
            next if num == 0
            num.abs == 2 ? toggle = 1 : toggle = 2
            valid << [pos[0] + num, pos[1] + toggle] #[1, 4]   [2, 5]   [4, 5]
            valid << [pos[0] + num, pos[1] - toggle] #[1, 2]    [2, 1]  [4, 1]
        end
        valid.select do |sub_arr| #[1,4]
            # sub_arr.all? { |num| num >= 0 && num < 8 }
            sub_arr.all? { |num| num.between?(0, 7)}
        end
    end

    def initialize(root_pos)
        @root_node = PolyTreeNode.new(root_pos)
        @considered_positions = [self.root_node.value] 
        build_move_tree
    end

    def new_move_positions(parent_node)
        new_positions = KnightPathFinder.valid_moves(parent_node.value)
        # debugger
        new_positions = new_positions.reject { |valid_pos| self.considered_positions.include?(valid_pos) } #reject!
        self.considered_positions = (new_positions + self.considered_positions).uniq # [root] += [[1,2], [2,1]]  == [root, [1,2], [2,1]]
        new_positions.map! { |node_pos| PolyTreeNode.new(node_pos, parent_node) } 
        new_positions.each { |child_pos| parent_node.add_child(child_pos) }
    end
    
    def build_move_tree
        queue = [self.root_node] #might be self.root_node.value
        until queue.empty? 
            parent = queue.shift
            self.root_node.move_tree += new_move_positions(parent) #[node([0,0]), node([1,2]), node([2,1])]
            parent.children.each { |child| queue << child unless self.considered_positions.include?(child) }
        end
    end
    
    def find_path(end_pos) #traverse tree,   output [[],[],[]]
        destination = self.root_node.move_tree.select { |node| node.value == end_pos }
        #until parent of a node is nil, push parent into return array
    end

    def trace_path_back

    end

end

if __FILE__ == $PROGRAM_NAME
    kpf = KnightPathFinder.new([0, 0])
    
    knight = kpf.root_node.move_tree
    debugger
    p knight.root_node
    # p KnightPathFinder.valid_moves([0,0])
    # p KnightPathFinder.valid_moves([7,7])
    # p KnightPathFinder.valid_moves([1,0])
    # p kpf.find_path([2, 1]) #-> [[0,0], [2,1]]
    # p kpf.find_path([3, 3]) #-> [[0,0], [2,1], [3, 3]]
end

#left code at bottom, would pry throw an error