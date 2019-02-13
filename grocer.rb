def consolidate_cart(cart)
  new_cart = {}
  cart.each do |cart_hash|
    cart_hash.each do |veg, data|
      if !new_cart[veg]
        new_cart[veg] = data
        new_cart[veg][:count] = 0
      end
      new_cart[veg][:count] += 1
    end
  end
  new_cart
end

# def apply_coupons(cart, coupons)
#   new_item = {}
#   coupons.each do |coupon_hash|
#     cart.each do |veg, data|
#       if veg == coupon_hash[:item] && data[:count] > coupon_hash[:num]
#         data[:count] = data[:count] - coupon_hash[:num]

#         new_name = coupon_hash[:item] + " W/COUPON"
#         new_item[new_name] = {
#           :price => coupon_hash[:cost],
#           :clearance => data[:clearence],
#           :count => 1
#         }
#       else
#         return cart
#       end
#     end
#   end

#   cart.merge(new_item)
# end


#My method above wasn't as good as this method
def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end


def apply_clearance(cart)
  cart.each do |item, hash|
    if hash[:clearence]
      new_price = hash[:price] * 0.80
      hash[:price] = new_price.round(2)
    end
  end
  cart
end

#Why dosn't the code just above work???

def apply_clearance(cart)
  cart.each do |name, properties|
    if properties[:clearance]
      updated_price = properties[:price] * 0.80
      properties[:price] = updated_price.round(2)
    end
  end
  cart
end


def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)
  total = 0
  final_cart.each do |name, properties|
    total += properties[:price] * properties[:count]
  end
  total = total * 0.9 if total > 100
  total
end
