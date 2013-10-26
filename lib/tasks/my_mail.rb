require 'net/pop'
begin
  pop = Net::POP3.new('pop.yandex.ru')
  pop.start('byzg@yandex.ru', 'blin2ru')
  puts pop.mails.last.header
rescue
  puts "Не проконтачило=("
end

