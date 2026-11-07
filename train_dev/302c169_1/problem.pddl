(define (problem task-302c169-1)
  (:domain appworld-302c169-1)
  (:objects
    richard-riddle - person
    phone-4436271690 - username
    phone-password - password
    phone-token - token
    alarm-go-to-sleep alarm-other-1 alarm-other-2 - alarm
    time-sleep-current time-sleep-plus-1h - alarm-time
    false-value - bool-value)
  (:init
    (username-for phone phone-4436271690)
    (password-for phone phone-password)
    (go-to-sleep-alarm alarm-go-to-sleep)
    (alarm-time alarm-go-to-sleep time-sleep-current)
    (one-hour-later time-sleep-current time-sleep-plus-1h)
    (enabled alarm-go-to-sleep)
    (enabled alarm-other-1)
    (enabled alarm-other-2)
    (is-false false-value))
  (:goal (and
    (shifted-one-hour-later alarm-go-to-sleep)
    (enabled alarm-go-to-sleep)
    (not (enabled alarm-other-1))
    (not (enabled alarm-other-2))
    (task-completed)))
)
