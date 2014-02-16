# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Mailchat::Application.initialize!

Time::DATE_FORMATS.merge!({default: "%Y.%m.%d #{I18n.t('at')} %k:%M"})