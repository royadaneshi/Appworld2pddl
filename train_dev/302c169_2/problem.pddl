(define (problem task-302c169-2)
  (:domain appworld-302c169-2)
  (:objects
    katie-simpson - person
    phone-6727300099 - username
    phone-password - password
    phone-token - token
    alarm-wake-up alarm-other-1 alarm-other-2 - alarm
    time-wake-up-original time-wake-up-minus-40 time-other-1 time-other-2 - time-value
    enabled-wake-up-current enabled-true enabled-false - bool-value)
  (:init
    (password-for phone phone-password)
    (phone-username phone-6727300099)
    (alarm-setting alarm-wake-up time-wake-up-original enabled-wake-up-current)
    (alarm-setting alarm-other-1 time-other-1 enabled-true)
    (alarm-setting alarm-other-2 time-other-2 enabled-true)
    (time-arg alarm-wake-up time-wake-up-original time-wake-up-minus-40)
    (time-arg alarm-other-1 time-other-1 time-other-1)
    (time-arg alarm-other-2 time-other-2 time-other-2)
    (enabled-arg alarm-wake-up enabled-wake-up-current enabled-wake-up-current)
    (enabled-arg alarm-other-1 enabled-true enabled-false)
    (enabled-arg alarm-other-2 enabled-true enabled-false))
  (:goal (and
    (alarm-setting alarm-wake-up time-wake-up-minus-40 enabled-wake-up-current)
    (alarm-setting alarm-other-1 time-other-1 enabled-false)
    (alarm-setting alarm-other-2 time-other-2 enabled-false)
    (task-completed)))
)
