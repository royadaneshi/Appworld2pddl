(define (problem task-5238afc-3)
  (:domain appworld-5238afc-3)
  (:objects
    stacy - person
    st-maldonado-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    amazon-card-1 - payment-card
    home-address - address
    non-stapler-1 non-stapler-2 non-stapler-3 non-stapler-4 non-stapler-5 non-stapler-6 stapler-1 stapler-2 stapler-3 stapler-4 stapler-5 non-stapler-7 non-stapler-8 non-stapler-9 non-stapler-10 - product
    n1-1 n1-2 n1-3 n1-4 n1-5 n1-6 n1-7 n1-8 n1-9 n2 - count
  )
  (:init
    (password-for amazon amazon-password)
    (in-cart non-stapler-1)
    (in-cart non-stapler-2)
    (in-cart non-stapler-3)
    (in-cart non-stapler-4)
    (in-cart non-stapler-5)
    (in-cart non-stapler-6)
    (in-cart stapler-1)
    (in-cart stapler-2)
    (in-cart stapler-3)
    (in-cart stapler-4)
    (in-cart stapler-5)
    (in-cart non-stapler-7)
    (in-cart non-stapler-8)
    (in-cart non-stapler-9)
    (in-cart non-stapler-10)
    (is-stapler stapler-1)
    (is-stapler stapler-2)
    (is-stapler stapler-3)
    (is-stapler stapler-4)
    (is-stapler stapler-5)
    (succ zero n1-1)
    (succ n1-1 n1-2)
    (succ n1-2 n1-3)
    (succ n1-3 n1-4)
    (succ n1-4 n1-5)
    (succ n1-5 n1-6)
    (succ n1-6 n1-7)
    (succ n1-7 n1-8)
    (succ n1-8 n1-9)
    (succ n1-9 n2)
    (non-staplers-in-cart n2))
  (:goal (and (order-placed) (task-completed))))
