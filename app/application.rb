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

      #create the cart with another elsif
      elsif req.path.match (/cart/)
      #then you can call this condition, to rule out first if it's empty  or not. setting another if within an elsif
      if @@cart.empty?
        resp.write "Your cart is empty"
      else  #else you iterate if it's not empty, but set the latter to first check if that coniton passes
        @@cart.each do |item|
          resp.write "#{item}\n"
        end
      end
          #create the route next or GET param in another elsif & add conditions to what you wanna do  with it
        elsif req.path.match(/add/)
          item_to_add = req.params["item"] #setting up req parm key
            if @@items.include? item_to_add #local var ref to the item iteration
              @@cart << item_to_add
              #add a resp to that action
              resp.write "added #{item_to_add}"
            else
      resp.write "We don't have that item!"
      end
    else
      resp.write "Path Not Found"
    end
      resp.finish
    end

    def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end



          # we're setting it equal to a local var which we call later in reference to that instead of writing it out like that:
          # search_term = req.params["item"]
          # resp.write handle_search(search_term)
