(define (problem task-258796c-2)
  (:domain appworld-258796c-2)
  (:objects
    claudia-miller - person
    clmiller-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    query-kobo-clara-hd-ereader query-battery - query
    is-verified-true - boolean
    kobo-clara-hd-ereader - product
    battery-question - question
    battery-hours - hours)
  (:init
    (supervisor-user claudia-miller)
    (password-for amazon amazon-password)
    (search-query-for query-kobo-clara-hd-ereader kobo-clara-hd-ereader)
    (battery-query query-battery)
    (is-true is-verified-true)
    (question-about battery-question kobo-clara-hd-ereader))
  (:goal (and
    (verified-reviews-checked kobo-clara-hd-ereader)
    (verified-answers-checked battery-question)
    (found-battery-hours kobo-clara-hd-ereader battery-hours)
    (task-completed)))
)
