(define (problem task-245cb43-2)
  (:domain appworld-245cb43-2)
  (:objects
    norman - person
    normansmit-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    cutting-board-fitting cutting-board-too-large - product
    payment-card-1 - payment-card
    address-home - address
  )
  (:init
    (password-for amazon amazon-password)
    (in-wish-list cutting-board-fitting)
    (in-wish-list cutting-board-too-large)
    (cutting-board cutting-board-fitting)
    (cutting-board cutting-board-too-large)
    (fits-drawer cutting-board-fitting)
  )
  (:goal (and (ordered cutting-board-fitting) (task-completed)))
)
