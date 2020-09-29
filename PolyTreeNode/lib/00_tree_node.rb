class PolyTreeNode
    attr_reader :parent
    attr_accessor :value

    def initialize(value)
        @value = value
        @parent = nil
        @children = []
    end

    def parent=(parent)
        return if self.parent == parent
        if self.parent
            self.parent._children.delete(self)
        end

        @parent = parent
        self.parent._children << self unless self.parent.nil?
        self
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        if child && !self.children.include?(child)
            raise "Tried to remove child node that isn't a child"
        end
        child.parent = nil
    end

    protected

    def _children
        @children
    end
end