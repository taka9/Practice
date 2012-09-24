# -*- encoding: utf-8 -*-
#
# やること
# block, Proc, lambda
#
# わからないこと
# yieldはいつ使えるのか
# Procでreturnすると怒られるよね？怒られる
# lambdaは怒られない
#
# わかったこと
# proc, lambda は手続き型オブジェクト
# ブロック = &手続き型オブジェクト なのかな
#
# メソッドにブロックを渡したい場合は、
# ブロック付きメソッドと普通のメソッドに手続き型オブジェクトを渡すやり方があると
# checkArray がメソッドに手続き型オブジェクトを渡す方法
# checkArray2, checkArray3がブロック付きメソッド

def log message, &block
  puts message + " 開始"
  block.call
  puts message + " 終了"
end

def checkArray array, block
  count = 0
  array.each do |item|
    if block.call item
      count += 1
    end
  end
  puts 'trueCount : ' + count.to_s
end

def checkArray2
  array = [5, 1, 2, 8, 4, 5, 2, 2, 2, 9]
  count = 0
  array.each do |item|
    if yield(item)
      count += 1
    end
  end
  puts 'trueCount : ' + count.to_s
end

def checkArray3 &block
  array = [5, 1, 2, 8, 4, 5, 2, 2, 2, 9]
  count = 0
  array.each do |item|
    if yield item
      count += 1
    end
  end
  puts 'trueCount : ' + count.to_s
end

condition1 = Proc.new { |item| item.to_i <= 5 }
condition2 = Proc.new { |item| item.to_i % 2 != 0 }
condition3 = Proc.new do |item| item == 5 end

log 'テスト1' do checkArray [5, 1, 2, 8, 4, 5, 2, 2, 2, 9], condition2 end
log 'テスト2' do checkArray2 do |item| item == 2 end end

# ちゃんとProcが送られていない
log 'テスト3' do checkArray3 &condition2 end
# ちゃんとProcが送られていない
log 'テスト4' do checkArray2 &condition3 end

# do-end で囲まないとエラーが出ることがあるけどなぜ
# log 'yieldテスト1' { checkArray2 {|item| item == 2} }
log 'テスト5' do checkArray2 {|item| item == 2} end

# これはダメっぽい
# checkArray2 Proc.new{|item| item == 2}
# &をつければOK
log 'テスト6' do checkArray2 &Proc.new{|item| item == 2} end

proc = Proc.new{|item| item == 2}
log 'テスト7' do checkArray2 &proc end

proc2 = Proc.new do |item| item == 3 end
log 'テスト8' do checkArray2 &proc end

# yieldは&ついてないとダメなのかな
log 'テスト9' do checkArray3 &Proc.new{|item| item == 2} end

