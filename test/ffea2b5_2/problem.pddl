(define (problem task-ffea2b5-2)
  (:domain appworld-ffea2b5-2)
  (:objects
    cody lindsey - person
    cod-smith-at-gmail-com - username
    simple-note-password file-system-password gmail-password - password
    simple-note-token file-system-token gmail-token - token
    query-workout - query
    workout-plan-note - note
    workout-plan-content - content
    workout-plan-txt - file-path
    draft-reply-to-lindsey - draft
  )
  (:init
    (credential-of-app simple-note cod-smith-at-gmail-com)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (credential-of-app file-system cod-smith-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app gmail cod-smith-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (password-for simple-note simple-note-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (note-matches query-workout workout-plan-note)
    (content-of workout-plan-note workout-plan-content)
    (draft-matches query-workout draft-reply-to-lindsey)
    (draft-replies-to draft-reply-to-lindsey lindsey)
  )
  (:goal (and
    (file-created workout-plan-txt workout-plan-content)
    (draft-attached draft-reply-to-lindsey workout-plan-txt)
    (email-sent draft-reply-to-lindsey)
    (task-completed)
  ))
)
