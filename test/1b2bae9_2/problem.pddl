(define (problem task-1b2bae9-2)
  (:domain appworld-1b2bae9-2)
  (:objects
    kayla-burton - person
    ka-burt-at-gmail-com - username
    amazon-password file-system-password - password
    amazon-token file-system-token - token
    query-apple-watch-series-7 - query
    apple-watch-series-7 - product
    kayla-home-address - address
    primary-card - payment-card
    new-order - order
    bills-dir - dirpath
    receipt-file - file-path
  )
  (:init
    (credential-of-app amazon amazon-password)
    (credential-of-app amazon amazon-token)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (username-for amazon ka-burt-at-gmail-com)
    (username-for file-system ka-burt-at-gmail-com)
    (password-for amazon amazon-password)
    (password-for file-system file-system-password)
    (query-finds query-apple-watch-series-7 apple-watch-series-7)
    (is-home-address kayla-home-address)
    (bills-folder bills-dir)
    (receipt-path-for new-order receipt-file)
  )
  (:goal (and
    (order-placed new-order apple-watch-series-7 kayla-home-address)
    (receipt-saved new-order receipt-file)
    (task-completed)
  ))
)
