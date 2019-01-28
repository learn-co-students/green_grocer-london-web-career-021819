require 'pry'

def consolidate_cart(cart)
  basket = {}
    cart.each do |item| # cart is an array of items
      item.each do |name, details| # each item has a name and a hash of details
        if basket.has_key?(name) # could also just say 'if basket[name]'...(if item with that name is already in the basket it will evaluate to true)
          basket[name][:count] += 1 # if its in the basket already it will have :count key
        else
          basket[name] = details # add a new key/value pair...(details will bring all its values with it)
          basket[name][:count] = 1 # add a count key set to 1 of that item
        end
      end
    end
  basket
end

def apply_coupons(cart, coupons)
  coup = coupons[0][:item]
    if cart.has_key?(coup)
      cart["#{coup} W/COUPON"] = {}
    end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
