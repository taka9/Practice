# -*- encoding: utf-8 -*-
class Logger
  def print message, level, &block
    puts "\t" * level + '開始' + message
    res = block.call
    puts "\t" * level + '終了' + message + ', 戻り値' + res.to_s
    return res
  end
end

def checkNumber array, &block
  count = 0
  array.each do |item|
    if block.call item
      count += 1
    end
  end
  return count
end

logger = Logger.new
# ブロックの前にカンマは付けない
logger.print '外ブロック:配列の中に条件に合致する数値がいくつ入っているか', 0 do
  checkNumber [5, 1, 2, 8, 4, 5, 6, 2, 2, 9] do |item|
    logger.print '内ブロック:条件に合致するか', 1 do
      # ブロックの中ではreturnでなく、nextを使う
      puts item
      item >= 5
    end
  end
end

