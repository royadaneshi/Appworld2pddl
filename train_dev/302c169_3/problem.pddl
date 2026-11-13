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
    (required-time-arg alarm-wake-up time-omitted)
    (required-time-arg alarm-weekly-work-standup-meeting time-omitted)
    (required-time-arg alarm-water-plants time-omitted)
    (required-enabled-arg alarm-wake-up bool-false)
    (required-enabled-arg alarm-weekly-work-standup-meeting bool-false)
    (required-enabled-arg alarm-water-plants bool-false))
  (:goal (and
    (alarm-updated alarm-go-to-sleep)
    (alarm-updated alarm-wake-up)
    (alarm-updated alarm-weekly-work-standup-meeting)
    (alarm-updated alarm-water-plants)
    (task-completed))))
