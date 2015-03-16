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

Пусть(/^(пользователь )?(с емейлом )?(?:"(.*?)" )?входит в систему(?: с паролем "(.*?)")?(?: (не пропуская второй шаг))?$/) do |user_flag, email_flag, user_name, pass, second_step|
  email = email_from_user_email_email user_flag, email_flag, user_name
  pass ||= 'qwe321'
  step %|я захожу на страницу "Авторизация"|
  step %|я ввожу "#{email}" в поле "E-mail"|
  step %|я ввожу "#{pass}" в поле "Пароль"|
  step %|я нажимаю кнопку "Войти"|
  sleep 1
  step %|я должен быть на странице "Авторизация ящика"|
  unless second_step
    step %|почтовый сервер сообщит о верном пароле|
    step %|я ввожу "пароль" в поле "account_password_pass"|
    step %|я нажимаю кнопку "Отправить"|
    step %|я должен быть на странице "Главная"|
  end
end

Тогда(/^я выхожу из системы$/) do
  visit '/users/sign_out'
end

Пусть(/^почтовый сервер сообщит о (верном|неверном) пароле$/) do |correct|
  if correct == 'верном'
    @count_responce_of_post_server ||= 0
    @count_responce_of_post_server += 1
    if @count_responce_of_post_server > 1
      allow_any_instance_of(Net::POP3).to receive(:start).and_return(nil)
      allow_any_instance_of(Net::POP3).to receive(:mails).and_return([])
    else
      expect_any_instance_of(Net::POP3).to receive(:start).and_return(nil)
      expect_any_instance_of(Net::POP3).to receive(:mails).and_return([])
    end
  else
    expect_any_instance_of(Net::POP3).to receive(:start) { raise Net::POPAuthenticationError }
  end
end

Пусть(/^почтовый сервер не отвечает$/) do
  expect_any_instance_of(Net::POP3).to receive(:start) { raise(Net::OpenTimeout) }
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

Тогда(/^я должен был пройти первый шаг авторизации$/) do
  email = email_from_user_email_email(true, nil, nil)
  step %|я должен быть на странице "Авторизация ящика"|
  step %|я вижу "Для работы с сайтом необходимо ввести пароль от почтового ящика #{email}."|
end