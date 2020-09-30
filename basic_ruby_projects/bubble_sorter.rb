#Takes in an array of unsorted numbers and returns an array of sorted numbers from smallest to largest

def bubble_sort(array)
  unsorted_slots = array.length - 1

  until unsorted_slots == 0
    array.each_with_index do |target_value, target_index|
      if target_index < array.length-1 && target_value > array[target_index+1]
        array[target_index] = array[target_index+1]
        array[target_index+1] = target_value
      end
    end
    unsorted_slots -= 1
  end
  array
end

p bubble_sort([4,3,78,2,0,2])
#[0,2,2,3,4,78]
p bubble_sort([12,55,0,89,75,2,3,2])
#[0,2,2,3,12,55,75,89]
p bubble_sort([23, 60, 49, 58, 30, 95, 61, 4])
#[4,23,30,49,58,60,61,95]
p bubble_sort([96, 68, 84, 76, 89, 12, 79, 90])
#[12, 68, 76, 79, 84, 89, 90, 96]
p bubble_sort([63, 61, 69, 44, 89, 43, 47, 92])
#[43, 44, 47, 61, 63, 69, 89, 92]
p bubble_sort([9, 49, 30, 12, 37, 55, 73, 42])
#[9, 12, 30, 37, 42, 49, 55, 73]
p bubble_sort([87, 20, 34, 84, 13, 32, 8, 21])
#[8, 13, 20, 21, 32, 34, 84, 87]



