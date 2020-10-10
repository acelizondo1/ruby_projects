def fibs(n)
    fib_array = []
    for i in 0..(n-1)
        if i == 0 || i == 1 
            fib_array[i] = i
        else
            fib_array[i] = fib_array[i-2] + fib_array[i-1]
        end
    end
    fib_array
end

def fibs_rec(n, array)
    array[n-1] = n-1 if n==1 || n==2
    array[n-1] = fibs_rec(n-1, array)[n-2] + fibs_rec(n-2, array)[n-3] if n > 2
    array
end

fibs(5)          #=>[0,1,1,2,3]
fibs(10)         #=>[0,1,1,2,3,5,8,13,21,34]

fibs_rec(5, [])  #=>[0,1,1,2,3]
fibs_rec(10, []) #=>[0,1,1,2,3,5,8,13,21,34]

def merge_sort(array)
    if array.length > 1
        half = array.each_slice( (array.size/2.0).round ).to_a
        first_half = half[0]
        second_half = half[1]
        first_half = merge_sort(first_half)
        second_half = merge_sort(second_half)
        
        sorted_array = []
        until first_half.empty? && second_half.empty?
            if !first_half.empty? && (second_half.empty? || first_half[0] < second_half[0])
                sorted_array.push(first_half.shift)
            else
                sorted_array.push(second_half.shift)
            end
        end
        array = sorted_array
    end
    return array
end

merge_sort([5,1,5,1,50,2,62,4]) #=> [1,1,2,4,5,5,50,62]
merge_sort([82, 8, 99, 41, 37, 11, 57, 92, 16, 74, 80, 100, 45, 71, 87, 93, 96, 25, 98, 40, 26, 21, 55, 20, 95, 42, 81, 70, 89, 56, 85, 29, 46, 10, 34, 72, 28, 32, 79, 77, 43, 48, 23, 31, 14, 1, 52, 47, 6, 44])
#=>[1, 6, 8, 10, 11, 14, 16, 20, 21, 23, 25, 26, 28, 29, 31, 32, 34, 37, 40, 41, 42, 43, 44, 45, 46, 47, 48, 52, 55, 56, 57, 70, 71, 72, 74, 77, 79, 80, 81, 82, 85, 87, 89, 92, 93, 95, 96, 98, 99, 100]