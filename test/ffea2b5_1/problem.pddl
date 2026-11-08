(define (problem task-ffea2b5-1)
  (:domain appworld-ffea2b5-1)
  (:objects
    kyle chad - person
    kyl-moor-at-gmail-com - username
    simple-note-password file-system-password gmail-password - password
    simple-note-token file-system-token gmail-token - token
    query-workout - query
    workout-plan-note - note
    workout-plan-content - content
    workout-plan-txt - file-path
    chad-workout-thread - email-thread
    draft-reply-to-chad - draft)
  (:init
    (username-for simple-note kyl-moor-at-gmail-com)
    (username-for file-system kyl-moor-at-gmail-com)
    (username-for gmail kyl-moor-at-gmail-com)
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (token-for simple-note simple-note-token)
    (token-for file-system file-system-token)
    (token-for gmail gmail-token)
    (note-matches-query workout-plan-note query-workout)
    (note-content workout-plan-note workout-plan-content)
    (thread-matches-query chad-workout-thread query-workout)
    (draft-in-thread draft-reply-to-chad chad-workout-thread))
  (:goal (and
    (sent draft-reply-to-chad)
    (attached draft-reply-to-chad workout-plan-content)
    (task-completed)))
)
