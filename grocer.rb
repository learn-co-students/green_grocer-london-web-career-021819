require 'pry'
def consolidate_cart(cart)
  # code here

  hash = {}
  i = 0
  array = cart.uniq

  while i < array.length
    array[i].each do |key, val|
      hash[key] = val
      cart.each do |v2|
        binding.pry
      end

    end
    i += 1
  end


  binding.pry

  hash
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
