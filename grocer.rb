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
  coupons.each do |info|
    c_item = info[:item]
    c_num = info[:num]
    c_cost = info[:cost]
    c_name = "#{c_item} W/COUPON"
    if cart[c_item] && cart[c_item][:count] >= c_num
      num = cart[c_item][:count] / c_num
      cart[c_name] = {price: c_cost, clearance: cart[c_item][:clearance], count: num}

      cart[c_item][:count] = cart[c_item][:count] % c_num
      if cart[c_item][:count] == 0
        cart.delete(cart[c_item])
      end
    end
  end
  cart
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
