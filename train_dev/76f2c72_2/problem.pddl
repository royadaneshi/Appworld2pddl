(define (problem task-76f2c72-2)
  (:domain appworld-76f2c72-2)
  (:objects
    chelsea-burch - person
    chelsea-burch-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    bills-internet-dir - directory
    internet-bill-2023-01 internet-bill-2023-02 internet-bill-2023-03 internet-bill-2023-04 - bill-file
    amount-0 total-through-2023-01 total-through-2023-02 total-through-2023-03 total-through-2023-04 - amount
  )
  (:init
    (username-for file-system chelsea-burch-at-gmail-com)
    (password-for file-system file-system-password)
    (in-directory internet-bill-2023-01 bills-internet-dir)
    (in-directory internet-bill-2023-02 bills-internet-dir)
    (in-directory internet-bill-2023-03 bills-internet-dir)
    (in-directory internet-bill-2023-04 bills-internet-dir)
    (bill-this-year internet-bill-2023-01)
    (bill-this-year internet-bill-2023-02)
    (bill-this-year internet-bill-2023-03)
    (bill-this-year internet-bill-2023-04)
    (running-total amount-0)
    (adds-to internet-bill-2023-01 amount-0 total-through-2023-01)
    (adds-to internet-bill-2023-02 total-through-2023-01 total-through-2023-02)
    (adds-to internet-bill-2023-03 total-through-2023-02 total-through-2023-03)
    (adds-to internet-bill-2023-04 total-through-2023-03 total-through-2023-04)
    (final-total total-through-2023-04)
  )
  (:goal (and
    (running-total total-through-2023-04)
    (task-completed)
  ))
)
