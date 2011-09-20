module Prism
  module Microformat
    class HReviewAggregate < POSH
      FRIENDLY_NAME = "hReview-aggreate"
      WIKI_URL = "http://microformats.org/wiki/hreview-aggregate"
      XMDP = 'http://microformats.org/profile/hreview-aggregate'

      name :'hreview-aggregate'

      # Extracts a property from a node using a given pattern
      def self.extract_property(node, property, microformat=:valueclass)
        prop_node = node.css(".#{property.to_s}")
        return nil unless prop_node.length >= 1
        parser = Prism.map(microformat)
        parser.extract_from(prop_node.first)
      end

      # FIX: Add 'worst', 'best' and 'value'
      # FIX: Add support for multiple ratings using rel='tag'
      has_one :summary, :rating, :count, :votes

      has_one :item do
        extract do |node|
          # FIX: Add hProduct
          value = find_one_of(node, :hcard, :hcalendar)

          unless value
            fn = HReview.extract_property(node, :fn)
            url = HReview.extract_property(node, :url, :url)
            photo = HReview.extract_property(node, :photo, :url)
            # FIX: Using a Struct breaks away from using Prism::POSH::Base
            # but I was struggling to get it to work otherwise
            item = Struct.new(:fn, :url, :photo) do
              def to_h
                {fn: fn, url: url, photo: photo}
              end
            end
            value = item.new(fn, url, photo)
          end
          value
        end
      end

    end

  end
end
