(define (problem task-530b157-1)
  (:domain appworld-530b157-1)
  (:objects
    matthew kristin - person
    username-4886643554 username-matthew-blac-at-gmail-com - username
    phone-password venmo-password - password
    phone-token venmo-token - token
    kristin-email - email
    kristin-phone-number - phone-number
    query-kristin - query
    amount-owed-for-groceries - amount
    note-groceries - note
    message-it-is-done - message
    groceries-payment - transaction
    done-text - text-message
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app venmo venmo-password)
    (credential-of-app venmo venmo-token)
    (username-for phone username-4886643554)
    (username-for venmo username-matthew-blac-at-gmail-com)
    (password-for phone phone-password)
    (password-for venmo venmo-password)
    (query-for kristin query-kristin)
    (transaction-spec groceries-payment kristin amount-owed-for-groceries note-groceries)
    (text-spec done-text kristin message-it-is-done)
  )
  (:goal (and
    (transaction-sent groceries-payment)
    (text-sent done-text)
    (task-completed)
  ))
)
