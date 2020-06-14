require "pry"

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |hash|
    hash.each do |item, details|
      if new_cart.keys.include?(item)
        new_cart[item][:count] += 1
      else
      new_cart[item] = details
      new_cart[item][:count] = 1
      end
    end
  end
  new_cart
end
=begin
def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart.keys.include?("#{coupon[:item]} W/COUPON")
      cart["#{coupon[:item]} W/COUPON"][:count] += 1
      cart[coupon[:item]][:count] -= coupon[:num]
    else
      if cart.keys.include?(coupon[:item])
        cart["#{coupon[:item]} W/COUPON"] = {
          price: coupon[:cost],
          clearance: cart[coupon[:item]][:clearance],
          count: 1
        }
      cart[coupon[:item]][:count] -= coupon[:num]
      end
    end
  end
  cart
end
=end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    valid = false
    couponed_item = coupon[:item]
    coupon_name = "#{couponed_item} W/COUPON"
    couponed_previously = cart.keys.include?(coupon_name)
    if cart.keys.include?(couponed_item) && cart[couponed_item][:count] >= coupon[:num]
      valid = true
    end
    if valid
      if couponed_previously
        cart[coupon_name][:count] += 1
        cart[couponed_item][:count] -= coupon[:num]
      else
        cart["#{couponed_item} W/COUPON"] = {
          price: coupon[:cost],
          clearance: cart[coupon[:item]][:clearance],
          count: 1
        }
        cart[couponed_item][:count] -= coupon[:num]
      end
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item, details|
    if details[:clearance]
      details[:price] = (details[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  new_cart = consolidate_cart(cart)
  total = 0
  apply_coupons(new_cart, coupons)
  apply_clearance(new_cart)
  new_cart.each do |item, values|
    total += values[:price] * values[:count]
  end
  if total > 100
    total *= 0.9
  end
  total
end
