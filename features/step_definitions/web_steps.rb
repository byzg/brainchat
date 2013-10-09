#coding: utf-8
PAGES={
    "Главная" => '/'
}

Пусть(/^я захожу на страницу "(.*?)"$/) do |page|
  visit PAGES[page]
end

Пусть(/^я вижу "(.*?)"$/) do |text|
  page.should have_text text
end