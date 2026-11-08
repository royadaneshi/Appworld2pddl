(define (problem task-afc4005-3)
  (:domain appworld-afc4005-3)
  (:objects
    jonathan-ball - person
    jo-ball-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-workout - query
    workout-plan-note - note
    sunday-workout-minutes - duration)
  (:init
    (password-for simple-note simple-note-password)
    (note-matches query-workout workout-plan-note)
    (duration-of workout-plan-note sunday-workout-minutes))
  (:goal (and (found-duration sunday-workout-minutes) (task-completed))))
