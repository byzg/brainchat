#coding: utf-8
def email_from_user_email_email(user_flag, email_flag, user_name)
  raise                             if [user_flag, email_flag, user_name].all?(&:nil?)
  raise                             if user_flag && email_flag && user_name.nil?
  return User.last.email            if user_flag && email_flag.nil? && user_name.nil?
  return email_from_name(user_name) if user_flag && email_flag.nil? && user_name
  return user_name                  if user_flag && email_flag && user_name
  return email_from_name(user_name) if user_flag.nil? && email_flag.nil? && user_name
  return user_name                  if user_flag.nil? && email_flag && user_name
  user_name                         if user_flag.nil? && email_flag && user_name.nil?
end

Пусть(/^(пользователь )?(с емейлом )?(?:"(.*?)" )?входит в систему(?: с паролем "(.*?)")?$/) do |user_flag, email_flag, user_name, pass|
  email = email_from_user_email_email user_flag, email_flag, user_name
  pass ||= 'qwe321'
  step %|я захожу на страницу "Авторизация"|
  step %|я ввожу "#{email}" в поле "E-mail"|
  step %|я ввожу "#{pass}" в поле "Пароль"|
  step %|я нажимаю кнопку "Войти"|
  sleep 1
  step %|я должен быть на странице "Авторизация ящика"|
end

Тогда(/^я выхожу из системы$/) do
  visit '/users/sign_out'
end

Пусть(/^почтовый сервер сообщит о (верном|неверном) пароле$/) do |correct|
  if correct == 'верном'
    Net::POP3.any_instance.stubs(:start).returns(nil)
    Net::POP3.any_instance.stubs(:mails).returns([])
  else
    Net::POP3.any_instance.stubs(:start).raises(Net::POPAuthenticationError)
  end
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
