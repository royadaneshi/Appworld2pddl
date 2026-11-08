(define (problem task-cb4ee7a-2)
  (:domain appworld-cb4ee7a-2)
  (:objects
    chris-mccoy - person
    chris - first-name
    mccoy - last-name
    chris-mcco-at-gmail-com - email
    username-chris-mcco-at-gmail-com - username
    gmail-password spotify-new-password - password
    gmail-token spotify-token - token
    query-spotify - query
    verification-thread - email-thread
    spotify-verification-code - verification-code
    supervisor-card - payment-card
    card-name-1 - card-name
    owner-name-chris-mccoy - owner-name
    card-number-1 - card-number
    expiry-year-1 - expiry-year
    expiry-month-1 - expiry-month
    cvv-number-1 - cvv-number)
  (:init
    (supervisor chris-mccoy)
    (first-name-of chris-mccoy chris)
    (last-name-of chris-mccoy mccoy)
    (email-of chris-mccoy chris-mcco-at-gmail-com)
    (login-username gmail username-chris-mcco-at-gmail-com)
    (login-username spotify username-chris-mcco-at-gmail-com)
    (password-for gmail gmail-password)
    (chosen-password spotify spotify-new-password)
    (query-matches query-spotify verification-thread)
    (code-in-thread verification-thread spotify-verification-code)
    (card-name-of supervisor-card card-name-1)
    (card-owner-of supervisor-card owner-name-chris-mccoy)
    (card-number-of supervisor-card card-number-1)
    (card-expiry-year-of supervisor-card expiry-year-1)
    (card-expiry-month-of supervisor-card expiry-month-1)
    (card-cvv-of supervisor-card cvv-number-1))
  (:goal (and (account-created spotify) (account-verified spotify)
              (premium-subscribed spotify yearly) (task-completed)))
)
