(define (problem task-31dc501-3)
  (:domain appworld-31dc501-3)
  (:objects
    jared - person
    phone-3016947686 - username
    phone-password - password
    phone-token - token
    weekday-wake-up-alarm - alarm
    minutes-20 - minutes)
  (:init
    (password-for phone phone-password)
    (wants-snooze weekday-wake-up-alarm minutes-20))
  (:goal (and
    (snooze-set weekday-wake-up-alarm minutes-20)
    (task-completed))))
