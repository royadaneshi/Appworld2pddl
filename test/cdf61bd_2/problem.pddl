(define (problem task-cdf61bd-2)
  (:domain appworld-cdf61bd-2)
  (:objects
    jared - person
    jar-calhoun-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    email-jar-calhoun-at-gmail-com - email
    order-last-month - order
    beige-sweater - product
    beige-sweater-review - review
    rating-2 - rating
    title-pills-and-looks-worn-out-quickly - title)
  (:init
    (password-for amazon amazon-password)
    (supervisor-email email-jar-calhoun-at-gmail-com)
    (ordered-last-calendar-month order-last-month)
    (order-contains order-last-month beige-sweater)
    (review-of beige-sweater-review beige-sweater))
  (:goal (and
    (review-updated beige-sweater-review rating-2 title-pills-and-looks-worn-out-quickly)
    (task-completed))))
