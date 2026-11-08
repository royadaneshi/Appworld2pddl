(define (problem task-afc4005-2)
  (:domain appworld-afc4005-2)
  (:objects
    william - person
    william-mart-at-gmail-com - username
    simple-note-password - password
    simple-note-token - token
    query-workout - query
    workout-plan-note - note
    workout-duration-yesterday - duration)
  (:init
    (password-for simple-note simple-note-password)
    (note-matches query-workout workout-plan-note)
    (duration-in-note workout-plan-note workout-duration-yesterday))
  (:goal (and (found workout-duration-yesterday)
              (task-completed)))
)
