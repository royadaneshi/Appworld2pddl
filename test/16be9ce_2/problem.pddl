(define (problem task-16be9ce-2)
  (:domain appworld-16be9ce-2)
  (:objects
    connor-brown mother - person
    phone-username-5734599766 amazon-username-connorbrow-at-gmail-com - username
    phone-password amazon-password - password
    phone-token amazon-token - token
    relationship-mother - relationship
    mothers-birthday-2022 - date
    drone-order - order
    drone-product - product
    drone-current-price - price
  )
  (:init
    (username-for phone phone-username-5734599766)
    (username-for amazon amazon-username-connorbrow-at-gmail-com)
    (password-for phone phone-password)
    (password-for amazon amazon-password)
    (relative mother relationship-mother)
    (birthday-of mother mothers-birthday-2022)
    (ordered-on drone-order mothers-birthday-2022)
    (order-contains drone-order drone-product)
    (product-price drone-product drone-current-price)
  )
  (:goal (and
    (found-price drone-product drone-current-price)
    (task-completed)
  ))
)
