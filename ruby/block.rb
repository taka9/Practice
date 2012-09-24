# -*- encoding: utf-8 -*-
condition1 = Proc.new do |item|
  item >= 5
end

condition2 = Proc.new do |item|
  item % 2 == 0
end

condition3 = Proc.new do |item|
  item == 5
end

array = [5, 1, 2, 8, 4, 5, 6, 2, 2, 9]
def checkArray array, block
  array.each do |item|
    puts block.call item
    if block.call item
      puts item
    end
  end
end

def checkArray2
  array.each do |item|
    if yield(item)
      puts item
    end
  end
end

checkArray2 condition1
#checkArray array, condition2
#checkArray array, condition3
