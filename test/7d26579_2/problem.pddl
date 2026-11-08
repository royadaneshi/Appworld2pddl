(define (problem task-7d26579-2)
  (:domain appworld-7d26579-2)
  (:objects
    anthony-harrison - person
    an-harrison-at-gmail-com-username - username
    amazon-password - password
    amazon-token - token
    query-sweater - query
    an-harrison-at-gmail-com - email
    last-sweater-order - order
    sweater-product - product
    my-sweater-question - question
    answer-yes-or-no - answer)
  (:init
    (password-for amazon amazon-password)
    (order-matches last-sweater-order query-sweater)
    (in-order last-sweater-order sweater-product)
    (question-on my-sweater-question sweater-product)
    (asked-by my-sweater-question an-harrison-at-gmail-com)
    (answers-question answer-yes-or-no my-sweater-question))
  (:goal (and (found-answer answer-yes-or-no) (task-completed)))
)
