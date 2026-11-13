(define (problem task-a5b0084-3)
  (:domain appworld-a5b0084-3)
  (:objects
    melissa roommate-1 roommate-2 person-1 - person
    username-mel-bailey-at-gmail-com username-3383946795 - username
    gmail-password phone-password pw-at-fm-jb - password
    gmail-token phone-token - token
    mel-bailey-at-gmail-com - email
    spotify-reset-code - code
    query-password-reset - query
    rel-roommate - relationship
    phone-roommate-1 phone-roommate-2 phone-roommate-3 - phone-number
    message-spotify-password - message
    spotify-reset-thread - email-thread
  )
  (:init
    (credential-of-app gmail mel-bailey-at-gmail-com)
    (credential-of-app gmail username-mel-bailey-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail pw-at-fm-jb)
    (credential-of-app gmail gmail-token)
    (credential-of-app gmail message-spotify-password)
    (credential-of-app phone username-3383946795)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (username-for gmail username-mel-bailey-at-gmail-com)
    (username-for phone username-3383946795)
    (password-for gmail gmail-password)
    (password-for phone phone-password)
    (supervisor-email mel-bailey-at-gmail-com)
    (thread-matches spotify-reset-thread query-password-reset)
    (carries-code spotify-reset-thread spotify-reset-code)
    (reset-code-for spotify-reset-code spotify)
    (desired-password spotify pw-at-fm-jb)
    (roommate-relationship rel-roommate)
    (is-roommate roommate-1)
    (is-roommate roommate-2)
    (is-roommate person-1)
    (contact-phone roommate-1 phone-roommate-1)
    (contact-phone roommate-2 phone-roommate-2)
    (contact-phone person-1 phone-roommate-3)
    (message-contains message-spotify-password pw-at-fm-jb))
  (:goal (and
    (password-changed spotify pw-at-fm-jb)
    (texted roommate-1 pw-at-fm-jb)
    (texted roommate-2 pw-at-fm-jb)
    (texted person-1 pw-at-fm-jb)
    (task-completed)))
)
