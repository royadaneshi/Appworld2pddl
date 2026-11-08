(define (problem task-9b2dc64-2)
  (:domain appworld-9b2dc64-2)
  (:objects
    carl-brown - person
    carbrown-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    last-sweater sweater-black sweater-red - product
    sweater - product-type
    black red - color
    ordered-size - size
    home-address - address
    payment-card-1 - card)
  (:init
    (password-for amazon amazon-password)
    (last-purchased-of-type last-sweater sweater)
    (has-size last-sweater ordered-size)
    (variant-of sweater-black last-sweater)
    (variant-of sweater-red last-sweater)
    (has-color sweater-black black)
    (has-color sweater-red red)
    (has-size sweater-black ordered-size)
    (has-size sweater-red ordered-size)
    (wanted-color black)
    (wanted-color red)
    (is-home-address home-address))
  (:goal (and (ordered sweater-black) (ordered sweater-red) (delivered-to home-address) (task-completed))))
