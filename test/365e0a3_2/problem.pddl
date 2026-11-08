(define (problem task-365e0a3-2)
  (:domain appworld-365e0a3-2)
  (:objects
    glenn - person
    glenn-burton-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    total-premium-paid - amount
  )
  (:init
    (password-for spotify spotify-password)
  )
  (:goal (and
    (found-total-paid total-premium-paid)
    (task-completed)
  ))
)
