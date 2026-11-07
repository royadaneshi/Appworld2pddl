(define (problem task-302c169-2)
  (:domain appworld-302c169-2)
  (:objects
    katie-simpson - person
    phone-6727300099 - username
    phone-password - password
    phone-token - token
    alarm-wake-up alarm-other-1 alarm-other-2 - alarm
    time-wake-up-original time-wake-up-minus-40 - alarm-time
    enabled-false - bool-value)
  (:init
    (password-for phone phone-password)
    (phone-username phone-6727300099)
    (wake-up-alarm alarm-wake-up)
    (alarm-time alarm-wake-up time-wake-up-original)
    (minus-40-minutes time-wake-up-original time-wake-up-minus-40)
    (alarm-enabled alarm-other-1)
    (alarm-enabled alarm-other-2)
    (bool-false enabled-false))
  (:goal (and
    (alarm-time alarm-wake-up time-wake-up-minus-40)
    (wake-up-alarm-rescheduled)
    (not (alarm-enabled alarm-other-1))
    (not (alarm-enabled alarm-other-2))
    (task-completed)))
)
