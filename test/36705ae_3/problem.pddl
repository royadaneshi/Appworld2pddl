(define (problem task-36705ae-3)
  (:domain appworld-36705ae-3)
  (:objects
    jared-calhoun partner - person
    jar-calhoun-at-gmail-com - username
    gmail-password file-system-password - password
    token-gmail token-file-system - token
    query-cable-bill - query
    partner-request-thread bill-thread-1 bill-thread-2 bill-thread-3 - thread
    partner-request-email bill-email-1 bill-email-2 bill-email-3 - email
    bill-attachment-1 bill-attachment-2 bill-attachment-3 - attachment
    bills-cable-dir - dir-path
    bill-pdf-1 bill-pdf-2 bill-pdf-3 bills-cable-zip - file-path
    body-please-see-attached - body)
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (reply-body body-please-see-attached)
    ; threads returned by searching the inbox for cable bills
    (thread-matches query-cable-bill partner-request-thread)
    (thread-matches query-cable-bill bill-thread-1)
    (thread-matches query-cable-bill bill-thread-2)
    (thread-matches query-cable-bill bill-thread-3)
    (in-thread partner-request-email partner-request-thread)
    (in-thread bill-email-1 bill-thread-1)
    (in-thread bill-email-2 bill-thread-2)
    (in-thread bill-email-3 bill-thread-3)
    (sender partner-request-email partner)
    (request-email partner-request-email)
    (bill-email bill-email-1)
    (bill-email bill-email-2)
    (bill-email bill-email-3)
    (email-attachment bill-email-1 bill-attachment-1)
    (email-attachment bill-email-2 bill-attachment-2)
    (email-attachment bill-email-3 bill-attachment-3)
    ; each bill attachment is saved as ~/bills_cable/MM-YYYY.pdf (chronological order)
    (bill-file bill-attachment-1 bill-pdf-1)
    (bill-file bill-attachment-2 bill-pdf-2)
    (bill-file bill-attachment-3 bill-pdf-3)
    (next-bill-file bills-cable-dir bill-pdf-1)
    (next-bill-file bill-pdf-1 bill-pdf-2)
    (next-bill-file bill-pdf-2 bill-pdf-3)
    (last-bill-file bills-cable-dir bill-pdf-3)
    (zip-of bills-cable-dir bills-cable-zip))
  (:goal (and
    (replied partner-request-email body-please-see-attached bills-cable-zip)
    (task-completed))))
