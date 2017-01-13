class BarApi

  def self.client
    @client ||= Yelp::Client.new({
      consumer_key: 'rCPjCJMrMc2naKiFJG1OuQ',
      consumer_secret: '1vNPcyEIxqJPrtJwO4Xc5U59HNE',
      token: 'Lo5IU4mxbJyJra2FfK9DURuhvU5NjKTf',
      token_secret: 'ldhx6chbaEg9GTVL2Oi6ws6hFpM'
      })
  end

  def self.search(zipcode, term)
    results = client.search(zipcode, term)
    results.businesses.map do |result|
      if !Bar.find_by({yelp_id: result.id})
        Bar.create({yelp_id: result.id, name: result.name, address: result.location.address.join(", "), city: result.location.city, zipcode: result.location.postal_code, phone: result.display_phone, url: result.url, rating:result.rating, image: result.image_url})
      else
        Bar.find_by({yelp_id: result.id})
      end
    end
  end

end
