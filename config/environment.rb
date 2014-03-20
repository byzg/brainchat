# Load the rails application
require File.expand_path('../application', __FILE__)
Dir[File.expand_path(File.join(File.dirname(__FILE__),'..','lib','*.rb'))].each {|f| require f}

# Initialize the rails application
Mailchat::Application.initialize!

Time::DATE_FORMATS.merge!({default: "%d.%m.%Y #{I18n.t('at')} %k:%M"})