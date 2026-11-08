(define (problem task-9ef798c-2)
  (:domain appworld-9ef798c-2)
  (:objects
    martin william - person
    mar-blac-at-gmail-com phone-number-3539110281 - username
    venmo-password phone-password - password
    venmo-token phone-token - token
    william-email - email
    query-william query-carpool - query
    william-carpool-request - payment-request)
  (:init
    (username-for venmo mar-blac-at-gmail-com)
    (username-for phone phone-number-3539110281)
    (password-for venmo venmo-password)
    (password-for phone phone-password)
    (token-for venmo venmo-token)
    (token-for phone phone-token)
    (query-for-person query-william william)
    (contact-email william william-email)
    (request-from william-carpool-request william)
    (query-for-request query-carpool william-carpool-request)
    (target-request william-carpool-request))
  (:goal (and (approved william-carpool-request) (task-completed))))
