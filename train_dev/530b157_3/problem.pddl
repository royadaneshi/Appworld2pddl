(define (problem task-530b157-3)
  (:domain appworld-530b157-3)
  (:objects
    jeremy robert - person
    username-2786837088 username-jer-calhoun-at-gmail-com - username
    password-phone password-venmo - password
    token-phone token-venmo - token
    robert-email - email
    robert-phone-number - phone-number
    query-robert - query
    amount-grocery-cost - amount
    desc-thanks-for-the-groceries - description
    msg-done-thanks - message)
  (:init
    (username-for phone username-2786837088)
    (username-for venmo username-jer-calhoun-at-gmail-com)
    (password-for phone password-phone)
    (password-for venmo password-venmo)
    (contact-query robert query-robert)
    (email-of robert robert-email)
    (phone-of robert robert-phone-number)
    (owes robert amount-grocery-cost))
  (:goal (and
    (transaction-sent robert amount-grocery-cost desc-thanks-for-the-groceries)
    (text-sent robert msg-done-thanks)
    (task-completed))))
