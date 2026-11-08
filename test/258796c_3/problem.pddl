(define (problem task-258796c-3)
  (:domain appworld-258796c-3)
  (:objects
    glenn-burton - person
    hp-pavilion-15-laptop - product
    battery-question - question
    query-hp-pavilion-15-laptop query-battery - query
    verified-true - verified-flag
    battery-hours - hours)
  (:init
    (search-query-for query-hp-pavilion-15-laptop hp-pavilion-15-laptop)
    (battery-query query-battery)
    (verified-only verified-true)
    (question-about battery-question hp-pavilion-15-laptop))
  (:goal (and
    (verified-reviews-checked hp-pavilion-15-laptop)
    (verified-answers-checked hp-pavilion-15-laptop)
    (task-completed))))
