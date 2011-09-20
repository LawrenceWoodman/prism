require File.join(File.dirname(File.absolute_path(__FILE__)),'..','test_helper')

class HReviewAggregateTest < Test::Unit::TestCase
  @@klass = Prism::Microformat::HReviewAggregate
  
  # hreviewaggregate1.html
  describe 'single occurence test' do
    def self.before_all
      @doc ||= Nokogiri.parse(get_fixture('hreviewaggregate/hreviewaggregate1.html'))
      @hreview ||= @@klass.parse_first(@doc)
    end
    
    setup do
      @hreview ||= self.class.before_all
    end
    
    test 'The summary is a singular value' do
      assert_respond_to @hreview, :summary
      assert @hreview.has_property?(:summary)
      assert_equal 'Crepes on Cole is awesome', @hreview.summary
    end

    test 'The rating is a singular value' do
      assert_respond_to @hreview, :rating
      assert @hreview.has_property?(:rating)
      assert_equal '5', @hreview.rating
    end

    test 'The count is a singular value' do
      assert_respond_to @hreview, :count
      assert @hreview.has_property?(:count)
      assert_equal '3', @hreview.count
    end

    test 'The votes is a singular value' do
      assert_respond_to @hreview, :votes
      assert @hreview.has_property?(:votes)
      assert_equal '6', @hreview.votes
    end

    test 'The item is a singular value' do
      assert_respond_to @hreview, :item
      assert @hreview.has_property?(:item)
    end

  end

  # hreviewaggregate2.html
  describe 'extracting item hCard test' do
    def self.before_all
      @doc ||= Nokogiri.parse(get_fixture('hreviewaggregate/hreviewaggregate2.html'))
      @hreview ||= @@klass.parse_first(@doc)
    end

    setup do
      @hreview ||= self.class.before_all
      @item = @hreview.item
    end

    test 'item.fn is a singular value' do
      assert_equal 'Crepes on Cole', @item.fn
    end

    test 'item.org[0].organization_name is a singular value' do
      assert_equal 'Crepes on Cole', @item.org[0].organization_name
    end

    test 'item.adr[0].locality is a singular value' do
      assert_equal ['San Francisco'], @item.adr[0].locality
    end
  end

  # hreviewaggregate3.html
  describe 'extracting item fn (url|photo) test' do
    def self.before_all
      @doc ||= Nokogiri.parse(get_fixture('hreviewaggregate/hreviewaggregate3.html'))
      @hreview ||= @@klass.parse_first(@doc)
    end

    setup do
      @hreview ||= self.class.before_all
      @item = @hreview.item
    end

    test 'item.fn is a singular value' do
      assert_equal 'Crepes on Cole', @item.fn
    end

    test 'item.url is a singular value' do
      assert_equal 'http://example.com/', @item.url
    end

    test 'item.photo is a singular value' do
      assert_equal 'http://example.com/photos/crepes.png', @item.photo
    end
  end

  # hreviewaggregate3a.html
  describe 'extracting item url without photo test' do
    def self.before_all
      @doc ||= Nokogiri.parse(get_fixture('hreviewaggregate/hreviewaggregate3a.html'))
      @hreview ||= @@klass.parse_first(@doc)
    end

    setup do
      @hreview ||= self.class.before_all
      @item = @hreview.item
    end

    test 'item.url is a singular value' do
      assert_equal 'http://example.com/', @item.url
    end
  end

  # hreviewaggregate3b.html
  describe 'extracting item photo without url test' do
    def self.before_all
      @doc ||= Nokogiri.parse(get_fixture('hreviewaggregate/hreviewaggregate3b.html'))
      @hreview ||= @@klass.parse_first(@doc)
    end

    setup do
      @hreview ||= self.class.before_all
      @item = @hreview.item
    end

    test 'item.photo is a singular value' do
      assert_equal 'http://example.com/photos/crepes.png', @item.photo
    end
  end

end
