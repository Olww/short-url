require 'test_helper'

class ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  test 'should not create invalid short_url' do
    post '/short_url', params: { short_url: { link: 'not_url' } }
    assert_response :error
  end

  test 'should сreate a short url with random new url' do
    assert_difference('ShortUrl.count', 1) do
      post '/short_url', params: { short_url: { link: 'test.com', internal_path: 'test_url' } }
    end
    assert_response :success
    assert_equal @response.body, "{\"short_url\":\"http://www.example.com/short_url/#{ShortUrl.last.internal_path}\"}"
    assert_not_equal @response.body, '{"short_url":"http://www.example.com/short_url/test_url"}'
  end

  test 'should return a not found' do
    get '/short_url/not_found_url'
    assert_response :not_found
  end

  test 'should return an old url by a short url' do
    short_url = ShortUrl.create(link: 'test.com')
    get "/short_url/#{short_url.internal_path}"
    assert_response :success
    assert_equal @response.body, "{\"link\":\"#{short_url.link}\"}"
  end
end
