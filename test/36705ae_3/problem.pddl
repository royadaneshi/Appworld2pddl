(define (problem task-36705ae-3)
  (:domain appworld-36705ae-3)
  (:objects
    jared-calhoun partner - person
    jar-calhoun-at-gmail-com - username
    gmail-password file-system-password - password
    token-gmail token-file-system - token
    query-cable-bill - query
    bills-cable-dir - dir-path
    body-please-see-attached - body
    partner-request-thread bill-thread-1 bill-thread-2 bill-thread-3 bill-thread-4 bill-thread-5 bill-thread-6 - thread
    partner-request-email bill-email-1 bill-email-2 bill-email-3 bill-email-4 bill-email-5 bill-email-6 - email
    bill-attachment-1 bill-attachment-2 bill-attachment-3 bill-attachment-4 bill-attachment-5 bill-attachment-6 - attachment
    bill-pdf-1 bill-pdf-2 bill-pdf-3 bill-pdf-4 bill-pdf-5 bill-pdf-6 bills-cable-zip - file-path
  )
  (:init
    (credential-of-app gmail jar-calhoun-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail token-gmail)
    (credential-of-app file-system jar-calhoun-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system token-file-system)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (reply-body body-please-see-attached)
    (sender partner-request-email partner)
    (request-email partner-request-email)
    (zip-of bills-cable-dir bills-cable-zip)
    (thread-matches query-cable-bill partner-request-thread)
    (in-thread partner-request-email partner-request-thread)
    (thread-matches query-cable-bill bill-thread-1)
    (in-thread bill-email-1 bill-thread-1)
    (bill-email bill-email-1)
    (email-attachment bill-email-1 bill-attachment-1)
    (bill-file bill-attachment-1 bill-pdf-1)
    (thread-matches query-cable-bill bill-thread-2)
    (in-thread bill-email-2 bill-thread-2)
    (bill-email bill-email-2)
    (email-attachment bill-email-2 bill-attachment-2)
    (bill-file bill-attachment-2 bill-pdf-2)
    (thread-matches query-cable-bill bill-thread-3)
    (in-thread bill-email-3 bill-thread-3)
    (bill-email bill-email-3)
    (email-attachment bill-email-3 bill-attachment-3)
    (bill-file bill-attachment-3 bill-pdf-3)
    (thread-matches query-cable-bill bill-thread-4)
    (in-thread bill-email-4 bill-thread-4)
    (bill-email bill-email-4)
    (email-attachment bill-email-4 bill-attachment-4)
    (bill-file bill-attachment-4 bill-pdf-4)
    (thread-matches query-cable-bill bill-thread-5)
    (in-thread bill-email-5 bill-thread-5)
    (bill-email bill-email-5)
    (email-attachment bill-email-5 bill-attachment-5)
    (bill-file bill-attachment-5 bill-pdf-5)
    (thread-matches query-cable-bill bill-thread-6)
    (in-thread bill-email-6 bill-thread-6)
    (bill-email bill-email-6)
    (email-attachment bill-email-6 bill-attachment-6)
    (bill-file bill-attachment-6 bill-pdf-6)
    (next-bill-file bills-cable-dir bill-pdf-1)
    (next-bill-file bill-pdf-1 bill-pdf-2)
    (next-bill-file bill-pdf-2 bill-pdf-3)
    (next-bill-file bill-pdf-3 bill-pdf-4)
    (next-bill-file bill-pdf-4 bill-pdf-5)
    (next-bill-file bill-pdf-5 bill-pdf-6)
    (last-bill-file bills-cable-dir bill-pdf-6))
  (:goal (and
    (replied partner-request-email body-please-see-attached bills-cable-zip)
    (task-completed))))
