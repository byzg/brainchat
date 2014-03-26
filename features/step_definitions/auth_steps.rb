#coding: utf-8

Пусть(/^(юзер с емейлом )?"(.*?)" входит в систему(?: с паролем "(.*?)")?$/) do |email_flag, user_name, pass|
  email = (email_flag.nil? ? "#{user_name}@mail.ru" : user_name)
  pass ||= 'qwe321'
  step %|я захожу на страницу "Авторизация"|
  step %|я ввожу "#{email}" в поле "E-mail"|
  step %|я ввожу "#{pass}" в поле "Пароль"|
  step %|я нажимаю кнопку "Войти"|
  step %|я на странице "Главная"|
end

Тогда(/^я выхожу из системы$/) do
  visit '/users/sign_out'
end

Тогда(/^я регистрируюсь как юзер c именем "(.*?)" емейлом "(.*?)" паролем "(.*?)"(?: подтверждением пароля "(.*?)")?$/) do |name, email, pass, pass_conf|
  pass_conf = pass unless pass_conf
  step %|я захожу на страницу "Регистрация"|
  step %|я ввожу "#{name}" в поле "Имя"|
  step %|я ввожу "#{email}" в поле "E-mail"|
  step %|я ввожу "#{pass}" в поле "Пароль"|
  step %|я ввожу "#{pass_conf}" в поле "Подтверждение пароля"|
  step %|я нажимаю кнопку "Регистрация"|
end

Тогда(/^юзер с емейлом (.*?) подверждает свой емейл$/) do |email|
  user = User.find_by_email(email)
  visit "/users/confirmation?confirmation_token=#{user.confirmation_token}"
end

#Пусть(/^разрешен вход в систему без ввода пароля от почтового ящика$/) do
#  ApplicationController.any_instance.expects(:account_password_not_given?).returns(false)
#end
