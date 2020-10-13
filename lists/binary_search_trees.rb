class Node
    attr_accessor :data, :left, :right
    def initialize(data=nil)
        @data = data
        @left = nil
        @right = nil
    end
end

class Tree
    attr_reader :root

    def initialize(array)
        @root = build_tree(array.uniq!.sort)
    end

    def build_tree(array)
        mid = (0 + array.length-1)/2.round
        root_node = Node.new(array[mid])
        unless array.length < 3
            root_node.left = build_tree(array[0..mid-1])
            root_node.right = build_tree(array[mid+1..array.length-1])
        else
            if array.length == 2
                child_node = Node.new(array[1])
                root_node.data > array[1] ? root_node.left = child_node : root_node.right = child_node
            end
        end
        root_node
    end

    def insert(data)
        insert_node = Node.new(data)

        find(data) ? compare_node = nil : compare_node = @root
        until compare_node == nil
            if compare_node.data < insert_node.data
                unless compare_node.right == nil
                    compare_node = compare_node.right
                else
                    compare_node.right = insert_node
                    compare_node = nil
                end
            else
                unless compare_node.left == nil
                    compare_node = compare_node.left
                else
                    compare_node.left = insert_node
                    compare_node = nil
                end
            end
        end
    end

    def delete(data)
        target_node = find(data)
        parent_node = find_parent(data)
        
        if target_node.right == nil && target_node.left == nil
            parent_node.left = nil
            parent_node.right = nil
        elsif target_node.right == nil || target_node.left == nil
            if parent_node.right == target_node
                parent_node.right = target_node.right unless target_node.right == nil
                parent_node.right = target_node.left unless target_node.left == nil
            else
                parent_node.left = target_node.right unless target_node.right == nil
                parent_node.left = target_node.left unless target_node.left == nil
            end
        else 
            order_array = inorder(target_node)
            order_array.delete(target_node.data)
            parent_node.right == target_node ? parent_node.right = build_tree(order_array) : parent_node.left = build_tree(order_array)
        end
        target_node
    end

    def find(data)
        compare_node = @root
        compare = compare_node.data <=> data

        until compare == 0 || compare_node == nil
            if compare == -1
                compare_node.right == nil ? compare_node = nil : compare_node = compare_node.right
            else
                compare_node.left == nil ? compare_node = nil : compare_node = compare_node.left
            end
            compare = compare_node.data <=> data unless compare_node == nil
        end
        compare_node
    end

    def find_parent(data)
        compare_node = @root
        compare = compare_node.data <=> data

        until compare_node == nil
            if compare_node.right.data == data || compare_node.left.data == data
                return compare_node
            elsif compare == 0
                return -1
            else
                compare == 1 ? compare_node = compare_node.left : compare_node = compare_node.right
            end
            compare = compare_node.data <=> data
        end
    end

    def level_order
        data_array = []
        queue = []
        queue.push(@root)

        until queue.empty?
            current_node = queue.shift
            
            data_array.push(current_node.data)
            queue.push(current_node.left) unless current_node.left == nil
            queue.push(current_node.right) unless current_node.right == nil
        end
        data_array
    end

    def inorder(node=@root, data_array=[])
        unless node == nil
            data_array = inorder(node.left, data_array)
            data_array.push(node.data)
            data_array = inorder(node.right, data_array)
        end
        data_array
    end

    def preorder(node=@root, data_array=[])
        unless node == nil
            data_array.push(node.data)
            data_array = preorder(node.left, data_array)
            data_array = preorder(node.right, data_array)
        end
        data_array
    end

    def postorder(node=@root, data_array=[])
        unless node == nil
            data_array = postorder(node.left, data_array)
            data_array = postorder(node.right, data_array)
            data_array.push(node.data)
        end
        data_array
    end

    def height(node, size=0)
        node.left == nil ? left_height = size : left_height = height(node.left, size+1)
        node.right == nil ? right_height = size : right_height = height(node.right, size+1)

        if left_height > right_height
            return left_height
        else
            return right_height
        end
    end

    def depth(node)
        size = 0
        target_node = @root
        until target_node == node
            if target_node.data > node.data
                target_node = target_node.left
            else
                target_node = target_node.right
            end
            size += 1
        end
        size
    end

    def balanced?
        right_height = height(@root.right)
        left_height = height(@root.left)

        difference = right_height - left_height
        if difference == 0 || difference == -1 || difference == 1
            return true
        else
            return false
        end
    end

    def rebalance  
        sorted_array = inorder
        @root = build_tree(sorted_array)
    end

    def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
        pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
    end
end

tree = Tree.new(Array.new(15) { rand(1..100) })
tree.pretty_print
puts "The tree is balanced? #{tree.balanced?}"
puts "Tree elements in level order: #{tree.level_order}"
puts "Tree elements in preorder: #{tree.preorder}"
puts "Tree elements in order: #{tree.inorder}"
puts "Tree elements in post order: #{tree.postorder}"

for i in 0..10
    tree.insert(rand(500))
end
tree.pretty_print
puts "The tree is balanced? #{tree.balanced?}"

tree.rebalance
tree.pretty_print
puts "The tree is balanced? #{tree.balanced?}"
puts "Tree elements in level order: #{tree.level_order}"
puts "Tree elements in preorder: #{tree.preorder}"
puts "Tree elements in order: #{tree.inorder}"
puts "Tree elements in post order: #{tree.postorder}"