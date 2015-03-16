#coding: utf-8
Пусть(/^есть чат "(.*?)" с создателем "(.*?)" и участниками:$/) do |chat_subject, creator_email, members|
  creator = User.find_by_email(creator_email)
  members_ids = [creator.id]  
  members.hashes.each do |hash|
    user_name = hash['member'].match(/^.+(?=@)/).to_s
    members_ids << (User.find_by_email(hash['member']) || FactoryGirl.create(:user, email: hash['member'], name: user_name)).id
  end
  chat = FactoryGirl.build(:chat, owner: creator, subject: chat_subject)
  chat.user_ids = members_ids
  chat.save
end

Пусть(/^в последнем чате есть (\d+) сообщений от пользователя "(.*?)"$/) do |count, user|
  user = User.find_by_email(user)
  chat = Chat.last
  count.to_i.times { FactoryGirl.create(:message, user: user, chat: chat) }
end

Пусть(/^в списке чатов я вижу "(.*?)"$/) do |chat_subject|
  expect(page.find('table#chat_list')).to have_content chat_subject
end