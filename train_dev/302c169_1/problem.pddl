(define (problem task-302c169-1)
  (:domain appworld-302c169-1)
  (:objects
    richard-riddle - person
    phone-4436271690 - username
    phone-password - password
    phone-token - token
    alarm-go-to-sleep alarm-other-1 alarm-other-2 - alarm
    time-sleep-plus-1h time-other-1 time-other-2 - clock-time
    true-value false-value - bool-value)
  (:init
    (username-for phone phone-4436271690)
    (password-for phone phone-password)
    (go-to-sleep-alarm alarm-go-to-sleep)
    (desired-time alarm-go-to-sleep time-sleep-plus-1h)
    (desired-time alarm-other-1 time-other-1)
    (desired-time alarm-other-2 time-other-2)
    (desired-enabled alarm-go-to-sleep true-value)
    (desired-enabled alarm-other-1 false-value)
    (desired-enabled alarm-other-2 false-value))
  (:goal (and
    (alarm-updated alarm-go-to-sleep)
    (alarm-updated alarm-other-1)
    (alarm-updated alarm-other-2)
    (alarm-time alarm-go-to-sleep time-sleep-plus-1h)
    (alarm-enabled alarm-go-to-sleep true-value)
    (alarm-enabled alarm-other-1 false-value)
    (alarm-enabled alarm-other-2 false-value)
    (task-completed)))
)
