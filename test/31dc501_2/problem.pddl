(define (problem task-31dc501-2)
  (:domain appworld-31dc501-2)
  (:objects
    joyce - person
    phone-3155673041 - username
    phone-password - password
    phone-token - token
    weekend-wake-up-alarm - alarm
    minutes-15 - minutes)
  (:init
    (password-for phone phone-password)
    (is-weekend-wake-up weekend-wake-up-alarm)
    (target-snooze minutes-15))
  (:goal (and (snooze-set weekend-wake-up-alarm minutes-15) (task-completed)))
)
