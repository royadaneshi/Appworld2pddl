(define (problem task-baeb104-3)
  (:domain appworld-baeb104-3)
  (:objects
    melissa - person
    username-3383946795 mel-bailey-at-gmail-com - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    roommates - relationship
    roommate-emails - email-list
    query-amsterdam - query
    amsterdam-photos-dir - directory
    amsterdam-photos-zip - file
    subject-amsterdam-trip-photos - subject
    body-amsterdam-trip-photos - body
  )
  (:init
    (credential-of-app phone username-3383946795)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app file-system mel-bailey-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app gmail mel-bailey-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (username-for phone username-3383946795)
    (username-for file-system mel-bailey-at-gmail-com)
    (username-for gmail mel-bailey-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (recipients-for roommates roommate-emails)
    (photos-of query-amsterdam amsterdam-photos-dir)
    (zip-of amsterdam-photos-dir amsterdam-photos-zip)
  )
  (:goal (and
    (email-sent roommate-emails amsterdam-photos-zip)
    (task-completed)
  ))
)
