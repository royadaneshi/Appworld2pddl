(define (problem task-afc4005-1)
  (:domain appworld-afc4005-1)
  (:objects
    kyle-moore - person
    kyl-moor-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-workout - query
    workout-plan-note - note
    workout-duration-today - duration
  )
  (:init
    (password-for simple-note simple-note-password)
    (note-matches workout-plan-note query-workout)
    (answer-in workout-plan-note workout-duration-today)
  )
  (:goal (and
    (found-duration workout-duration-today)
    (task-completed)
  ))
)
