(define (problem task-302c169-3)
  (:domain appworld-302c169-3)
  (:objects
    jeffery - person
    username-9654124977 - username
    phone-password - password
    phone-token - token
    time-go-to-sleep-plus-20 time-omitted - clock-time
    bool-false flag-omitted - flag)
  (:init
    (username-for phone username-9654124977)
    (password-for phone phone-password)
    (required-time-arg alarm-go-to-sleep time-go-to-sleep-plus-20)
    (required-enabled-arg alarm-go-to-sleep flag-omitted)
    (required-time-arg alarm-other-1 time-omitted)
    (required-enabled-arg alarm-other-1 bool-false)
    (required-time-arg alarm-other-2 time-omitted)
    (required-enabled-arg alarm-other-2 bool-false))
  (:goal (and
    (alarm-updated alarm-go-to-sleep)
    (alarm-updated alarm-other-1)
    (alarm-updated alarm-other-2)
    (task-completed))))
