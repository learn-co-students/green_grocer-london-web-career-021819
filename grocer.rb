def consolidate_cart(cart)
organized_cart = {}
  cart.each do |element|
    element.each do |item, hash|
      organized_cart[item] ||= hash
      organized_cart[item][:count] ||= 0
      organized_cart[item][:count] += 1
    end
  end
organized_cart
end

def apply_coupons(cart, coupons)
new_hash = {}
  cart.each do |item, data|
    coupons.each do |coupon|
      if item == coupon[:item] && data[:count] >= coupon[:num]
        data[:count] =  data[:count] - coupon[:num]
        if new_hash["#{item} W/COUPON"]
          new_hash["#{item} W/COUPON"][:count] += 1
        else
          new_hash["#{item} W/COUPON"] = {:price => coupon[:cost], :clearance => data[:clearance], :count => 1}
        end
      end
    end
    new_hash[item] = data
    end
new_hash
end

def apply_clearance(cart)
  cart.each do |item, value|
    if value[:clearance] == true
      value[:price] = value[:price]*4/5
    end
  end
end


def checkout(cart, coupons)
cart = consolidate_cart(cart)
cart = apply_coupons(cart, coupons)
cart = apply_clearance(cart)
  total = 0
  cart.each do |item, data|
    total += (data[:price] * data[:count]).to_f
  end
  if total > 100 
    total = total*9/10
  end
total
end