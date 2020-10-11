class LinkedList

    def initialize
        @head = nil
        @tail = nil
        @size = 0
    end

    #adds a new node containing value to the end of the list
    def append(value)
        new_node = Node.new(value)
        if @head == nil
            @head = new_node
            @tail = new_node
        else
            @tail.next_node = new_node
            @tail = new_node
        end
        @size += 1
    end

    #adds a new node containing value to the start of the list
    def prepend(value)
        new_node = Node.new(value)
        new_node.next_node = @head
        @head = new_node
        @tail = new_node if @head.next_node == nil
        @size += 1
    end

    #returns the total number of nodes in the list
    def size
        return @size
    end

    #returns the first node in the list
    def head
        return @head
    end

    #returns the last node in the list
    def tail
        return @tail
    end

    #returns the node at the given index
    def at(index)
        node = @head
        for i in 0..index-1
            node = node.next_node
        end
        return node
    end

    #removes the last element from the list
    def pop
        return_node = @tail
        @tail = at(@size-2) 
        @tail.next_node = nil
        @size -= 1
        return return_node
    end

    #returns true if the passed in value is in the list and otherwise returns false.
    def contains?(value)
        node = @head
        for i in 0..@size-1
            if node.value == value
                return true
            else
                node = node.next_node
            end
        end
        false
    end

    #returns the index of the node containing value, or nil if not found.
    def find(value)
        node = @head
        for i in 0..@size-1
            if node.value == value
                return i
            else
                node = node.next_node
            end
        end
        nil
    end

    #represent your LinkedList objects as strings, so you can print them out and preview them in the console. The format should be: ( value ) -> ( value ) -> ( value ) -> nil
    def to_s
        node = @head
        node_string = ""
        for i in 0..@size-1
            node_string += "( #{node.value} ) -> "
            node_string += "nil" if node.next_node == nil
            node = node.next_node
        end
        node_string
    end

    #inserts the node with the provided value at the given index
    def insert_at(value, index)
        new_node = Node.new(value)
        previous_node = at(index-1)
        new_node.next_node = previous_node.next_node
        previous_node.next_node = new_node
        @size += 1
    end

    #emoves the node at the given index
    def remove_at(index)
        remove_node = at(index)
        previous_node = at(index-1)
        previous_node.next_node = remove_node.next_node
        @size -= 1
        remove_node
    end
end

#(You will need to update the links of your nodes in the list when you remove a node.)

class Node
    attr_accessor :value, :next_node
    def initialize(value=nil)
        @value = value
        @next_node = nil
    end
end

linked_list = LinkedList.new()

linked_list.append(2)
linked_list.prepend(1)
linked_list.append(3)
p linked_list.head
p linked_list.tail
p linked_list.size
linked_list.append(4)

p linked_list.to_s

linked_list.insert_at(50, 1)
p linked_list.to_s
p linked_list.remove_at(1)
p linked_list.to_s