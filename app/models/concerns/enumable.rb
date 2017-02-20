module Concerns
    module Enumable
        extend ActiveSupport::Concern

        included do
            
            def self.es(*keys)
                @es ||= defined_enums.inject({}) { |es, (_, hash)| es.merge! hash }
                keys.size > 1 ? keys.map { |key| @es[key.to_s] } : @es[keys.pop.to_s]
            end
        end
    end
end