(define (problem task-36705ae-2)
  (:domain appworld-36705ae-2)
  (:objects
    spencer wife - person
    spencer-powell-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-cable - query
    wife-request-thread bill-thread-1 bill-thread-2 bill-thread-3 - email-thread
    wife-request-email - email
    bill-attachment-1 bill-attachment-2 bill-attachment-3 - attachment
    bill-pdf-1 bill-pdf-2 bill-pdf-3 cable-bills-tar - file-path
    cable-bills-dir - directory-path
    body-please-find-attached - body
    count-0 count-1 count-2 count-3 - count
  )
  (:init
    (username-for gmail spencer-powell-at-gmail-com)
    (username-for file-system spencer-powell-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (thread-matches wife-request-thread query-cable)
    (thread-matches bill-thread-1 query-cable)
    (thread-matches bill-thread-2 query-cable)
    (thread-matches bill-thread-3 query-cable)
    (email-in-thread wife-request-email wife-request-thread)
    (sent-by wife-request-email wife)
    (request-email wife-request-email)
    (attachment-in-thread bill-attachment-1 bill-thread-1)
    (attachment-in-thread bill-attachment-2 bill-thread-2)
    (attachment-in-thread bill-attachment-3 bill-thread-3)
    (attachment-target bill-attachment-1 bill-pdf-1)
    (attachment-target bill-attachment-2 bill-pdf-2)
    (attachment-target bill-attachment-3 bill-pdf-3)
    (file-in-directory bill-pdf-1 cable-bills-dir)
    (file-in-directory bill-pdf-2 cable-bills-dir)
    (file-in-directory bill-pdf-3 cable-bills-dir)
    (archive-of cable-bills-dir cable-bills-tar)
    (succ count-0 count-1)
    (succ count-1 count-2)
    (succ count-2 count-3)
    (downloaded-count count-0)
    (bill-count count-3)
  )
  (:goal (and
    (replied wife-request-email body-please-find-attached cable-bills-tar)
    (task-completed)
  ))
)
