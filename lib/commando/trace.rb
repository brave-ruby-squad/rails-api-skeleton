module Commando
  module Trace
    def to_s
      "#<#{object_trace}>"
    end

    def inspect
      "#<#{object_trace}\n#{traceable_attributes_info}>"
    end

    private

    def object_trace
      "#{self.class.name}:#{encoded_object_id}"
    end

    def encoded_object_id
      "0x00#{(object_id * 2).to_s(16)}"
    end

    def traceable_attributes_info
      Constants::TRACEABLE_ATTRIBUTES
        .map(&method(:traceable_attribute_info))
        .join(",\n")
    end

    def traceable_attribute_info(attribute)
      "\t#{attribute}: #{send(attribute)}"
    end
  end
end
