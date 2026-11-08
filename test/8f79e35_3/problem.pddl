(define (problem task-8f79e35-3)
  (:domain appworld-8f79e35-3)
  (:objects
    michael-burch - person
    mi-burch-at-gmail-com - username
    file-system-password gmail-password - password
    file-system-token gmail-token - token
    dir-documents-personal invitee-list-file - path
    baby-shower-template-draft - draft
    query-baby-shower - query
    invitee-1-email invitee-2-email invitee-3-email - email
    invitation-subject - subject
    body-invitee-1 body-invitee-2 body-invitee-3 - body)
  (:init
    (username-for file-system mi-burch-at-gmail-com)
    (username-for gmail mi-burch-at-gmail-com)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (token-for file-system file-system-token)
    (token-for gmail gmail-token)
    (in-directory invitee-list-file dir-documents-personal)
    (listed-in invitee-1 invitee-list-file)
    (listed-in invitee-2 invitee-list-file)
    (listed-in invitee-3 invitee-list-file)
    (email-of invitee-1 invitee-1-email)
    (email-of invitee-2 invitee-2-email)
    (email-of invitee-3 invitee-3-email)
    (draft-matches baby-shower-template-draft query-baby-shower)
    (draft-subject baby-shower-template-draft invitation-subject)
    (personalized-body baby-shower-template-draft invitee-1 body-invitee-1)
    (personalized-body baby-shower-template-draft invitee-2 body-invitee-2)
    (personalized-body baby-shower-template-draft invitee-3 body-invitee-3))
  (:goal (and
    (invited invitee-1)
    (invited invitee-2)
    (invited invitee-3)
    (task-completed))))
