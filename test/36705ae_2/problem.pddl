(define (problem task-36705ae-2)
  (:domain appworld-36705ae-2)
  (:objects
    spencer wife - person
    spencer-powell-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-cable - query
    wife-request-email - email
    cable-bills-dir - directory-path
    body-please-find-attached - body
    wife-request-thread bill-thread-1 bill-thread-2 bill-thread-3 bill-thread-4 bill-thread-5 bill-thread-6 - email-thread
    bill-attachment-1 bill-attachment-2 bill-attachment-3 bill-attachment-4 bill-attachment-5 bill-attachment-6 - attachment
    bill-pdf-1 bill-pdf-2 bill-pdf-3 bill-pdf-4 bill-pdf-5 bill-pdf-6 cable-bills-tar - file-path
    count-0 count-1 count-2 count-3 count-4 count-5 count-6 - count
  )
  (:init
    (username-for gmail spencer-powell-at-gmail-com)
    (username-for file-system spencer-powell-at-gmail-com)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (email-in-thread wife-request-email wife-request-thread)
    (sent-by wife-request-email wife)
    (request-email wife-request-email)
    (archive-of cable-bills-dir cable-bills-tar)
    (downloaded-count count-0)
    (thread-matches wife-request-thread query-cable)
    (thread-matches bill-thread-1 query-cable)
    (attachment-in-thread bill-attachment-1 bill-thread-1)
    (attachment-target bill-attachment-1 bill-pdf-1)
    (file-in-directory bill-pdf-1 cable-bills-dir)
    (thread-matches bill-thread-2 query-cable)
    (attachment-in-thread bill-attachment-2 bill-thread-2)
    (attachment-target bill-attachment-2 bill-pdf-2)
    (file-in-directory bill-pdf-2 cable-bills-dir)
    (thread-matches bill-thread-3 query-cable)
    (attachment-in-thread bill-attachment-3 bill-thread-3)
    (attachment-target bill-attachment-3 bill-pdf-3)
    (file-in-directory bill-pdf-3 cable-bills-dir)
    (thread-matches bill-thread-4 query-cable)
    (attachment-in-thread bill-attachment-4 bill-thread-4)
    (attachment-target bill-attachment-4 bill-pdf-4)
    (file-in-directory bill-pdf-4 cable-bills-dir)
    (thread-matches bill-thread-5 query-cable)
    (attachment-in-thread bill-attachment-5 bill-thread-5)
    (attachment-target bill-attachment-5 bill-pdf-5)
    (file-in-directory bill-pdf-5 cable-bills-dir)
    (thread-matches bill-thread-6 query-cable)
    (attachment-in-thread bill-attachment-6 bill-thread-6)
    (attachment-target bill-attachment-6 bill-pdf-6)
    (file-in-directory bill-pdf-6 cable-bills-dir)
    (succ count-0 count-1)
    (succ count-1 count-2)
    (succ count-2 count-3)
    (succ count-3 count-4)
    (succ count-4 count-5)
    (succ count-5 count-6)
    (bill-count count-6))
  (:goal (and
    (replied wife-request-email body-please-find-attached cable-bills-tar)
    (task-completed)
  ))
)
