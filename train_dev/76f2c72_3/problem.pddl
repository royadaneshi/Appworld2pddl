(define (problem task-76f2c72-3)
  (:domain appworld-76f2c72-3)
  (:objects
    christina-harrison - person
    chrharrison-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    bills-cable-dir - directory
    cable-bill-2023-01 cable-bill-2023-02 cable-bill-2023-03 cable-bill-2023-04 - file
    amount-0 subtotal-through-2023-01 subtotal-through-2023-02 subtotal-through-2023-03 total-cable-2023 - amount)
  (:init
    (username-for file-system chrharrison-at-gmail-com)
    (password-for file-system file-system-password)
    (in-directory cable-bill-2023-01 bills-cable-dir)
    (in-directory cable-bill-2023-02 bills-cable-dir)
    (in-directory cable-bill-2023-03 bills-cable-dir)
    (in-directory cable-bill-2023-04 bills-cable-dir)
    (adds-to cable-bill-2023-01 amount-0 subtotal-through-2023-01)
    (adds-to cable-bill-2023-02 subtotal-through-2023-01 subtotal-through-2023-02)
    (adds-to cable-bill-2023-03 subtotal-through-2023-02 subtotal-through-2023-03)
    (adds-to cable-bill-2023-04 subtotal-through-2023-03 total-cable-2023)
    (running-total amount-0)
    (final-total total-cable-2023))
  (:goal (and (running-total total-cable-2023)
              (task-completed)))
)
