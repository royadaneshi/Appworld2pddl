(define (problem task-76f2c72-1)
  (:domain appworld-76f2c72-1)
  (:objects
    james-solomon - person
    ja-solomon-at-gmail-com - username
    file-system-password - password
    file-system-token - token
    electricity-bills-dir - directory
    this-year-bill-1 this-year-bill-2 this-year-bill-3 this-year-bill-4 - file
    total-electricity-cost-this-year - amount)
  (:init
    (username-for file-system ja-solomon-at-gmail-com)
    (password-for file-system file-system-password)
    (bills-directory electricity-bills-dir)
    (next-entry electricity-bills-dir this-year-bill-1)
    (next-entry this-year-bill-1 this-year-bill-2)
    (next-entry this-year-bill-2 this-year-bill-3)
    (next-entry this-year-bill-3 this-year-bill-4)
    (last-bill this-year-bill-4)
    (total-of-bills total-electricity-cost-this-year))
  (:goal (and
    (inspected electricity-bills-dir)
    (inspected this-year-bill-1)
    (inspected this-year-bill-2)
    (inspected this-year-bill-3)
    (inspected this-year-bill-4)
    (current-date-known)
    (task-completed)))
)
