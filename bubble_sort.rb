def bubble_sort(array)
    needs_swap = true
    # keeps the loop running until no more swaps need to be made
    while needs_swap
        i = 0
        swap_counter = 0
        while i < array.length
            if i+1 < array.length
                # if the value to the right is greater than the value on the left swap it
                if array[i] > array[i + 1]
                    # sets a temporary value to store the value at the i index
                    temp = array[i]
                    # replaces the value at the i index with the value to the right of it
                    array[i] = array[i + 1]
                    # replaces the value to the right of the i index with the original value at the i index
                    array[i + 1] = temp
                    swap_counter += 1
                end
            end
            i += 1
        end
        # if no swaps were made it means that the arrray has been sorted and it should stop sorting
        if swap_counter == 0
            needs_swap = false
        end
    end
    return array
end


# Test
p bubble_sort([4,3,2])
# expected [2,3,4]
p bubble_sort([4,3,78,2,0,2])
# expected [0,2,2,3,4,78]
p bubble_sort([9,8,7,6,5,4,3,2,1,0])
# expected [0,1,2,3,4,5,6,7,8,9]