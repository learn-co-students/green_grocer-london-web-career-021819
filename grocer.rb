def consolidate_cart(cart)
  return_cart = {}
  cart.each do |items|
    items.each do |item, values|
      if !(return_cart[item])
        return_cart[item] = values
        return_cart[item][:count] = 1
      else
        return_cart[item][:count] += 1
      end
    end
  end
  return_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |info| #iterating over the info in the coupons hash
    c_item = info[:item] #name of the item in the coupon
    c_num = info[:num] #number of items for the coupon to work
    c_cost = info[:cost]  #price of the items after teh coupon
    c_name = "#{c_item} W/COUPON" # name of couponed items in the cart
    if cart[c_item] && cart[c_item][:count] >= c_num #if the cart contains the coupon items in the right amount
      num = cart[c_item][:count] / c_num #how many times the coupon can apply
      cart[c_name] = {price: c_cost, clearance: cart[c_item][:clearance], count: num} #adding the new couponed items to the cart

      cart[c_item][:count] = cart[c_item][:count] % c_num #number of items left after couponed items are removed
      if cart[c_item][:count] == 0
        cart.delete(cart[c_item]) #if there are no originalitems left delete te item from teh cart
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |items, item_name|
    if item_name[:clearance] == true
      item_name[:price] = (item_name[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  total = 0 #running total
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart) #applying various discounts
  cart.each do |items, item_name|
    total = total + item_name[:price] * item_name[:count] #total is the current total + price of each itme * the number of each item
  end
  if total > 100
    total = (total * 0.9).round(2) #10% off if over 100
  end
  total
end
