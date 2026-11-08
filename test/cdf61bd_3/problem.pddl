(define (problem task-cdf61bd-3)
  (:domain appworld-cdf61bd-3)
  (:objects
    alex - person
    username-alexwhite-at-gmail-com - username
    amazon-password - password
    amazon-token - token
    email-alexwhite-at-gmail-com - email
    order-pink-tshirt-april - order
    pink-tshirt - product
    review-pink-tshirt - review
    rating-1 - rating
    title-stitching-fell-apart-in-the-washer - title
  )
  (:init
    (password-for amazon amazon-password)
    (known-email alex email-alexwhite-at-gmail-com)
    (order-last-calendar-month order-pink-tshirt-april)
    (ordered-in pink-tshirt order-pink-tshirt-april)
    (review-of review-pink-tshirt pink-tshirt)
    (target-review review-pink-tshirt)
    (target-rating rating-1)
    (target-title title-stitching-fell-apart-in-the-washer)
  )
  (:goal (and
    (review-rating review-pink-tshirt rating-1)
    (review-title review-pink-tshirt title-stitching-fell-apart-in-the-washer)
    (task-completed)
  ))
)
