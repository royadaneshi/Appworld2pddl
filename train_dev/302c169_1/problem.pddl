(define (problem task-302c169-1)
  (:domain appworld-302c169-1)
  (:objects
    richard-riddle - person
    phone-4436271690 - username
    phone-password - password
    phone-token - token
    true-value false-value - bool-value
    alarm-go-to-sleep alarm-wake-up-weekdays alarm-wake-up-weekend alarm-pick-up-laundry - alarm
    time-sleep-plus-1h time-wake-up-weekdays time-wake-up-weekend time-pick-up-laundry - clock-time
  )
  (:init
    (username-for phone phone-4436271690)
    (password-for phone phone-password)
    (go-to-sleep-alarm alarm-go-to-sleep)
    (desired-time alarm-go-to-sleep time-sleep-plus-1h)
    (desired-enabled alarm-go-to-sleep true-value)
    (desired-time alarm-wake-up-weekdays time-wake-up-weekdays)
    (desired-time alarm-wake-up-weekend time-wake-up-weekend)
    (desired-time alarm-pick-up-laundry time-pick-up-laundry)
    (desired-enabled alarm-wake-up-weekdays false-value)
    (desired-enabled alarm-wake-up-weekend false-value)
    (desired-enabled alarm-pick-up-laundry false-value))
  (:goal (and
    (alarm-updated alarm-go-to-sleep)
    (alarm-time alarm-go-to-sleep time-sleep-plus-1h)
    (alarm-enabled alarm-go-to-sleep true-value)
    (alarm-updated alarm-wake-up-weekdays)
    (alarm-updated alarm-wake-up-weekend)
    (alarm-updated alarm-pick-up-laundry)
    (alarm-enabled alarm-wake-up-weekdays false-value)
    (alarm-enabled alarm-wake-up-weekend false-value)
    (alarm-enabled alarm-pick-up-laundry false-value)
    (task-completed)))
)
