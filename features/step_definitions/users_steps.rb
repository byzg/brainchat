#coding: utf-8
def email_from_name(name)
  "#{name}@mail.ru"
end
def is_number?(obj)
  obj.to_s == obj.to_i.to_s
end
Пусть(/^существует (.*?)$/) do |user_name|
  user = User.new(name: user_name, email: email_from_name(user_name),
                  password: 'qwe321', password_confirmation: 'qwe321')
  expect(user.valid?).to be true
  user.confirm!
end

Пусть(/^юзером создается (.*?)$/) do |user_name|
  step %|я захожу на страницу "Создание собеседника"|
  step %|я ввожу "#{user_name}" в поле "Имя"|
  step %|я ввожу "#{email_from_name(user_name)}" в поле "E-mail"|
  step %|я нажимаю кнопку "Создать"|
end

Пусть(/^в системе (\d+) юзера$/) do |count|
  expect(User.all.count).to eq(count.to_i)
end

Тогда(/^у юзера (.*?) должен быть друг (.*?)$/) do |user1_name, user2_name|
  user1 = User.find_by_email(email_from_name(user1_name))
  user2 = User.find_by_email(email_from_name(user2_name))
  expect(user1.friends.pluck(:id).include?(user2.id)).to be true
end

Тогда(/^у юзера с емейлом (.*?) параметр (.*?) должен быть (.*?)$/) do |email, atr, val|
  val = val.to_i if is_number?(val)
  expect(User.find_by_email(email).send(atr)).to eq(val)
end