(define (problem task-cb4ee7a-1)
  (:domain appworld-cb4ee7a-1)
  (:objects
    erica - name
    wilson - name
    eri-powe-at-gmail-com - email
    gmail-username-eri-powe - username
    amazon-username-eri-powe - username
    gmail-password - password
    amazon-new-password - password
    gmail-token - token
    amazon-token - token
    query-verification - query
    amazon-verification-thread - email-thread
    amazon-verification-code - code
    supervisor-card - payment-card
    supervisor-card-name - card-name
    supervisor-card-owner-name - owner-name
    supervisor-card-number - card-number
    supervisor-card-expiry-year - expiry-year
    supervisor-card-expiry-month - expiry-month
    supervisor-card-cvv - cvv-number)
  (:init
    (supervisor-first-name erica)
    (supervisor-last-name wilson)
    (supervisor-email eri-powe-at-gmail-com)
    (username-for gmail gmail-username-eri-powe)
    (username-for amazon amazon-username-eri-powe)
    (password-for gmail gmail-password)
    (signup-password amazon-new-password)
    (token-for gmail gmail-token)
    (token-for amazon amazon-token)
    (verification-email-thread amazon-verification-thread)
    (query-matches query-verification amazon-verification-thread)
    (code-in-thread amazon-verification-thread amazon-verification-code)
    (card-details supervisor-card supervisor-card-name supervisor-card-owner-name supervisor-card-number supervisor-card-expiry-year supervisor-card-expiry-month supervisor-card-cvv))
  (:goal (and (account-created)
              (account-verified)
              (subscribed-prime monthly)
              (task-completed)))
)
