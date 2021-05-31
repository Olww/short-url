require 'test_helper'

class ShortUrlTest < ActiveSupport::TestCase
  test 'should validate link to be URL' do
    short_url = ShortUrl.new(link: 'not_url')
    assert_not short_url.save
  end

  test 'should validate link length' do
    short_url = ShortUrl.new(link: rand(2 ** 530).to_s(2))
    assert_not short_url.save
  end

  test 'should validate link presence' do
    short_url = ShortUrl.new
    assert_not short_url.save
  end

  test 'should generate random internal_path and be valid' do
    test_internal_path = 'random_test_internal_path'
    short_url = ShortUrl.new(link: 'testurl.com', internal_path: test_internal_path)
    assert short_url.save
    assert_not_equal short_url.internal_path, test_internal_path
  end
end
