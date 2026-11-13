(define (problem task-baeb104-1)
  (:domain appworld-baeb104-1)
  (:objects
    nancy-ritter - person
    phone-username-2307354647 nan-ritt-at-gmail-com - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    roommate - relationship
    roommate-emails - email-list
    substring-bali - substring
    flag-true - flag
    bali-photos-dir - directory
    bali-zip - zipfile
    subject-bali-trip-photographs - subject
    body-bali-trip-photographs - body)
  (:init
    (credential-of-app phone phone-username-2307354647)
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app file-system nan-ritt-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app gmail nan-ritt-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (username-for phone phone-username-2307354647)
    (username-for file-system nan-ritt-at-gmail-com)
    (username-for gmail nan-ritt-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (contacts-with roommate roommate-emails)
    (directory-matches bali-photos-dir substring-bali)
    (archive-of bali-photos-dir bali-zip))
  (:goal (and
    (email-sent roommate-emails bali-zip)
    (task-completed)))
)
