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
    invitee-email-1 invitee-email-2 invitee-email-3 invitee-email-4 invitee-email-5 invitee-email-6 invitee-email-7 invitee-email-8 - email
    invitation-subject - subject
    body-invitee-1 body-invitee-2 body-invitee-3 body-invitee-4 body-invitee-5 body-invitee-6 body-invitee-7 body-invitee-8 - body
  )
  (:init
    (username-for file-system mi-burch-at-gmail-com)
    (username-for gmail mi-burch-at-gmail-com)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (token-for file-system file-system-token)
    (token-for gmail gmail-token)
    (in-directory invitee-list-file dir-documents-personal)
    (draft-matches baby-shower-template-draft query-baby-shower)
    (draft-subject baby-shower-template-draft invitation-subject)
    (listed-in invitee-1 invitee-list-file)
    (listed-in invitee-2 invitee-list-file)
    (listed-in invitee-3 invitee-list-file)
    (listed-in invitee-4 invitee-list-file)
    (listed-in invitee-5 invitee-list-file)
    (listed-in invitee-6 invitee-list-file)
    (listed-in invitee-7 invitee-list-file)
    (listed-in invitee-8 invitee-list-file)
    (email-of invitee-1 invitee-email-1)
    (email-of invitee-2 invitee-email-2)
    (email-of invitee-3 invitee-email-3)
    (email-of invitee-4 invitee-email-4)
    (email-of invitee-5 invitee-email-5)
    (email-of invitee-6 invitee-email-6)
    (email-of invitee-7 invitee-email-7)
    (email-of invitee-8 invitee-email-8)
    (personalized-body baby-shower-template-draft invitee-1 body-invitee-1)
    (personalized-body baby-shower-template-draft invitee-2 body-invitee-2)
    (personalized-body baby-shower-template-draft invitee-3 body-invitee-3)
    (personalized-body baby-shower-template-draft invitee-4 body-invitee-4)
    (personalized-body baby-shower-template-draft invitee-5 body-invitee-5)
    (personalized-body baby-shower-template-draft invitee-6 body-invitee-6)
    (personalized-body baby-shower-template-draft invitee-7 body-invitee-7)
    (personalized-body baby-shower-template-draft invitee-8 body-invitee-8))
  (:goal (and
    (invited invitee-1)
    (invited invitee-2)
    (invited invitee-3)
    (invited invitee-4)
    (invited invitee-5)
    (invited invitee-6)
    (invited invitee-7)
    (invited invitee-8)
    (task-completed))))
