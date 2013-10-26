#require 'net/pop'
#puts "fghjgfh"
#Net::POP3.start("pop.yandex.ru", nil, "byzg@yandex.ru", "blin2ru") do |inc|
#  letters = inc.mails
#  puts letters.last.pop.from
#  puts
#  puts
#  #puts letters.last.subject
#end

require 'net/pop'
begin
  pop = Net::POP3.new('pop.yandex.ru')
  pop.start('byzg@yandex.ru', 'blin2ru')
  puts pop.mails.last.header
rescue
  puts "Не проконтачило=("
end

