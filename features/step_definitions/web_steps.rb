#coding: utf-8
PAGES={
    'Главная' => '/',
    'Авторизация' => '/users/sign_in',
    'Создание собеседника' => '/users/new',
    'Регистрация' => '/users/sign_up',
    'Авторизация ящика' => '/account_passwords/new'
}

Пусть(/^я захожу на страницу "(.*?)"$/) do |page|
  visit PAGES[page]
end

Пусть(/^я вижу "(.*?)"$/) do |text|
  expect(page).to have_content text
end

When /^я ввожу "([^"]*)" в поле "([^"]*)"$/ do |value, field_id|
  fill_in field_id, with: value
end

When /^я нажимаю кнопку "([^"]*)"$/ do |button_name|
  button_name = I18n.t(button_name[1..-1].to_sym) if button_name.first == ':'
  begin
    click_button button_name
  rescue
    if button_name.first == '#'
      page.execute_script("jQuery('input##{button_name}').click()")
    else
      page.execute_script(%|jQuery('input[value="#{button_name}"]').click()|)
    end
  end
end

When /^я должен быть на странице "([^"]*)"$/ do |page_name|
  expect(current_path).to eq(PAGES[page_name])
end

Пусть(/^я жду (\d+) секунд.*$/) do |seconds|
  sleep seconds.to_i
end

Пусть(/^я нажимаю на селектор "(.*?)"$/) do |selector|
  find(selector).click
end