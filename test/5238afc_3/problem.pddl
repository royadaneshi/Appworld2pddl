(define (problem task-5238afc-3)
  (:domain appworld-5238afc-3)
  (:objects
    stacy - person
    st-maldonado-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    stapler-1 stapler-2 non-stapler-1 non-stapler-2 - product
    amazon-card-1 - payment-card
    home-address - address
    n1 n2 - count)
  (:init
    (password-for amazon amazon-password)
    (in-cart stapler-1)
    (in-cart stapler-2)
    (in-cart non-stapler-1)
    (in-cart non-stapler-2)
    (is-stapler stapler-1)
    (is-stapler stapler-2)
    (succ zero n1)
    (succ n1 n2)
    (non-staplers-in-cart n2))
  (:goal (and (order-placed) (task-completed))))
