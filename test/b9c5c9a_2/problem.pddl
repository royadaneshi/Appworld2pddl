(define (problem task-b9c5c9a-2)
  (:domain appworld-b9c5c9a-2)
  (:objects
    cory-wilson friend-1 friend-2 friend-3 - person
    corwils-at-gmail-com phone-5412564532 - username
    file-system-password phone-password - password
    file-system-token phone-token - token
    personal-stuff-dir - directory
    rsvp-csv-file - file
    rsvp-csv-updated-content - content
    friend-1-phone-number friend-2-phone-number friend-3-phone-number - phone-number
    c0 c1 c2 c3 - count)
  (:init
    (username-for file-system corwils-at-gmail-com)
    (username-for phone phone-5412564532)
    (password-for file-system file-system-password)
    (password-for phone phone-password)
    (file-in-directory rsvp-csv-file personal-stuff-dir)
    (rsvp-csv rsvp-csv-file)
    (invitee friend-1)
    (invitee friend-2)
    (invitee friend-3)
    (phone-of friend-1 friend-1-phone-number)
    (phone-of friend-2 friend-2-phone-number)
    (phone-of friend-3 friend-3-phone-number)
    (succ c0 c1)
    (succ c1 c2)
    (succ c2 c3)
    (replies-found c0)
    (total-invitees c3)
    (updated-content-for rsvp-csv-file rsvp-csv-updated-content))
  (:goal (and (rsvps-updated) (task-completed)))
)
