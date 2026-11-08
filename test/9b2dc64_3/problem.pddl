(define (problem task-9b2dc64-3)
  (:domain appworld-9b2dc64-3)
  (:objects
    jeremy-calhoun - person
    jer-calhoun-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    last-tshirt tshirt-black tshirt-green tshirt-black-other-size tshirt-green-other-size - product
    black green original-color - color
    ordered-size other-size - size
    qty-1 - quantity
    address-home address-work - address
    payment-card-1 - payment-card)
  (:init
    (password-for amazon amazon-password)
    (last-purchased-tshirt last-tshirt)
    (color-of last-tshirt original-color)
    (size-of last-tshirt ordered-size)
    (variant-of tshirt-black last-tshirt)
    (color-of tshirt-black black)
    (size-of tshirt-black ordered-size)
    (variant-of tshirt-green last-tshirt)
    (color-of tshirt-green green)
    (size-of tshirt-green ordered-size)
    (variant-of tshirt-black-other-size last-tshirt)
    (color-of tshirt-black-other-size black)
    (size-of tshirt-black-other-size other-size)
    (variant-of tshirt-green-other-size last-tshirt)
    (color-of tshirt-green-other-size green)
    (size-of tshirt-green-other-size other-size)
    (wanted-color black)
    (wanted-color green)
    (single-unit qty-1)
    (home-address address-home))
  (:goal (and
    (ordered tshirt-black)
    (ordered tshirt-green)
    (order-placed-to address-home)
    (task-completed))))
