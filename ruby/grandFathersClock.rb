def chaim &block
  hour = Time.now.hour
  if hour > 12
    hour -= 12
  end

  if hour == 0
    hour = 12
  end

  hour.times do
    block.call
  end
end

chaim do puts 'DONG!' end
