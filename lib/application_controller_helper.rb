module ApplicationControllerHelper

  def self.included(base)
    base.send :include, PrivateMethods
  end

  module PrivateMethods
    private

    def mail_server_and_domain(email)
      email[((email =~ /@/)+1)..-1]
    end

    def get_pop(account_password_crypted)
      account_password = Encryptor.decrypt(ENV['ACCOUNT_PASSWORD_KEY'],
                                           account_password_crypted,
                                           session[:account_password_salt])
      Net::POP3.enable_ssl(OpenSSL::SSL::VERIFY_NONE)
      pop = Net::POP3.new("pop.#{mail_server_and_domain(current_user.email)}")
      pop.start(current_user.email, account_password)
      pop
    end

    def logg(obj)
      Rails.logger.info '#'*90
      Rails.logger.info obj
      Rails.logger.info '#'*90
    end

    def exception_log(e)
      Rails.logger.info "#{'#'*30}EXCEPTION#{'#'*30}"
      Rails.logger.info "#{e.class} : #{e.message}"
      Rails.logger.info "#{e.backtrace.select{|t| t.include?("#{Rails.root}") }.join("\n\t")}"
    end

    def slash_request?
      request.format == '*/*'
    end

  end

end