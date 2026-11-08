(define (problem task-cdf61bd-1)
  (:domain appworld-cdf61bd-1)
  (:objects
    leslie - person
    les-ball-at-gmail-com - username
    email-les-ball-at-gmail-com - email
    amazon-password - password
    amazon-token - token
    order-last-month - order
    product-grey-tshirt - product
    review-grey-tshirt - review
    rating-1 - rating
    title-shrunk-and-misshaped-after-first-wash - title)
  (:init
    (password-for amazon amazon-password)
    (supervisor-email leslie email-les-ball-at-gmail-com)
    (ordered-last-month order-last-month)
    (order-contains order-last-month product-grey-tshirt)
    (grey-tshirt product-grey-tshirt)
    (reviewed review-grey-tshirt product-grey-tshirt email-les-ball-at-gmail-com))
  (:goal (and
    (review-rating review-grey-tshirt rating-1)
    (review-title review-grey-tshirt title-shrunk-and-misshaped-after-first-wash)
    (task-completed)))
)
