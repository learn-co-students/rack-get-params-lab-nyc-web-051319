# Create a new class array called @@cart to hold any items in your cart
# Create a new route called /cart to show the items in your cart
# Create a new route called /add that takes in a GET param with the key item. This should check to see if that item is in @@items and then add it to the cart if it is. Otherwise give an error

class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)

    elsif req.path.match(/add/)
      item = req.params["q"]
      resp.write add(item)

    elsif req.path.match(/cart/)
      return "bepis"

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end #end call

  def cart
    if @@cart.length == 0
      return "Your cart is empty"
    else
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
  end

  def add(item) #not working
    if @@items.include?(item)
      @@cart << item
      return "added #{item}"
    else
      return "We don't have that item"
    end
  end #end add method

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end #end handle_search

end #end class
