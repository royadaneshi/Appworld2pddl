(define (problem task-31dc501-1)
  (:domain appworld-31dc501-1)
  (:objects
    kevin-blackburn - person
    username-3654328626 - username
    phone-password - password
    phone-token - token
    weekday-wake-up-alarm - alarm
    snooze-5 - snooze-minutes)
  (:init
    (password-for phone phone-password)
    (target-alarm weekday-wake-up-alarm)
    (target-snooze snooze-5))
  (:goal (and
    (snooze-set weekday-wake-up-alarm snooze-5)
    (task-completed)))
)
