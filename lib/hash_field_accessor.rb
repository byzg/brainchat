module HashFieldAccessor

  def self.included(base)
    base.send :include, InstanceMethods
    base.class_eval do
      alias_method_chain :method_missing, :hfa
      def get_full_details
        val = read_attribute(self.class::DETAILS_FIELD)
        if val
          begin
            JSON.parse val
          rescue
            YAML.load val
          end
        else
          {}
        end
      end
      def set_full_details(hash)
        write_attribute(self.class::DETAILS_FIELD.to_sym, JSON.generate(hash || {}, :ascii_only => false))
      end
      alias_method self::DETAILS_FIELD.to_sym, :get_full_details
      alias_method "#{self::DETAILS_FIELD.to_sym}=".to_sym, :set_full_details
    end
  end

  module InstanceMethods
    def method_missing_with_hfa(method, *args, &block)
      meth = method.to_s.gsub('=','')
      if self.class::DETAILS_ACCESSIBLE.include?(meth.to_sym)
        return set_details_field(meth, args.first) if !attributes.has_key?(meth) && (method.to_s =~ /^\w+=$/)
        return details_field(method) unless attributes.has_key?(method.to_s)
      end
      method_missing_without_hfa(method, args, block)
    end

    def details_merge!(hash)
      write_to_hash_field(details_hash.merge(hash))
    end

    private
    def details_field(key)
      details_hash[key.to_s]
    end

    def details_hash
      if read_attribute(self.class::DETAILS_FIELD.to_sym) then JSON.parse(read_attribute(self.class::DETAILS_FIELD)) else {} end
    end

    def set_details_field(key, value)
      old_hash = details_hash
      old_hash[key] = value
      write_to_hash_field(old_hash)
    end

    def write_to_hash_field(old_hash)
      write_attribute(self.class::DETAILS_FIELD.to_sym, JSON.generate(old_hash || {}, :ascii_only => false))
    end

  end
end

