require_relative '00_tree_node.rb'

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
        @considered_positions = [self.root_node] #might want root_node
        build_move_tree
    end

    def new_move_positions(pos)
        new_positions = KnightPathFinder.valid_moves(pos).reject { |valid_pos| self.considered_positions.include?(valid_pos) }
        new_positions.map! { |pos| PolyTreeNode.new(pos) }
        self.considered_positions += new_positions # [root] += [[1,2], [2,1]]  == [root, [1,2], [2,1]]
        new_positions
    end

    def build_move_tree
        new_move_positions(root_node.value) #[node([0,0]), node([1,2]), node([2,1])]
        # until self.considered_positions.empty?
            # self.considered_positions
        # end
    end

    def find_path #traverse tree,   output [[],[],[]]
        #until parent of a node is nil, push parent into return array
    end
end

if __FILE__ == $PROGRAM_NAME
    # kpf = KnightPathFinder.new([0, 0])
    p KnightPathFinder.valid_moves([0,0])
    p KnightPathFinder.valid_moves([7,7])
    p KnightPathFinder.valid_moves([1,0])
    # p kpf.find_path([2, 1]) #-> [[0,0], [2,1]]
    # p kpf.find_path([3, 3]) #-> [[0,0], [2,1], [3, 3]]
end

#left code at bottom, would pry throw an error