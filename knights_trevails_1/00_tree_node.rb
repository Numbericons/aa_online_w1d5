class PolyTreeNode 
    attr_reader :parent, :children, :value
    attr_accessor :move_tree

    def initialize(value, parent = nil) #self = b node
        @parent = parent
        @children = []
        @value = value
        @move_tree = []
    end

    def parent=(node) #parent=(a)
        if self.parent
            self.parent.children.delete(self)
        end
        @parent = node
        node.children << self unless node.nil? || node.children.include?(self)
        # node.children << self if !node.nil? && !node.children.include?(self)
        # node.children << self if !node.nil? #&& !node.children.include?(self)
    end

    def add_child(child_node)
        return nil if child_node.nil?
        self.children << child_node
        child_node.parent=(self)
    end

    def remove_child(child_node)
        raise "Node is not a child" if child_node.nil? || !self.children.include?(child_node)

        self.children.delete(child_node)
        child_node.parent=(nil)
    end
    
    def inspect
        "Node:" + self.value.inspect
    end

    #     a     "a" value = 0, children = [b,c], parent = nil
    #    / \
    #   b   c   b=1  c =2
    #  / \ / \
    # d  e f  g   d= 3 e=4  

    def dfs(target_value) #a
        return self if target_value == self.value

        self.children.each do |child| #b  ->>> want to return "d" into "b", return "d" into "a"
            result = child.dfs(target_value)
            return result if result #if target was "d", don't want to return "b" into "a"
        end

        nil
    end

    def bfs(target_value) #push shift     target_value = "f"   #[0,0]
        new_queue = [self]  # [node.value = [0,0] ] 

        until new_queue.empty? #new_queue =  ["e", "f", "g"]
            parent = new_queue.shift #parent = "e", new_queue = ["f", "g"]
            return parent if parent.value == target_value #false
            new_queue += parent.children #["f", "g"] + []
            # parent.children.each { |node| new_queue << node }
        end
        nil
    end
end


