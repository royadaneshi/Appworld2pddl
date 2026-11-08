(define (problem task-8f79e35-1)
  (:domain appworld-8f79e35-1)
  (:objects
    gina-burch - person
    gina-ritter-at-gmail-com - username
    file-system-password gmail-password - password
    file-system-token gmail-token - token
    dir-documents-personal invitees-file - path
    template-draft - draft
    invitee-1-email invitee-2-email invitee-3-email - email
    subject-baby-shower-invitation - subject
    body-for-invitee-1 body-for-invitee-2 body-for-invitee-3 - body
  )
  (:init
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (in-directory invitees-file dir-documents-personal)
    (invitee-in-file invitee-1 invitees-file)
    (invitee-in-file invitee-2 invitees-file)
    (invitee-in-file invitee-3 invitees-file)
    (invitee-email invitee-1 invitee-1-email)
    (invitee-email invitee-2 invitee-2-email)
    (invitee-email invitee-3 invitee-3-email)
    (draft-subject template-draft subject-baby-shower-invitation)
    (body-for invitee-1 body-for-invitee-1)
    (body-for invitee-2 body-for-invitee-2)
    (body-for invitee-3 body-for-invitee-3)
  )
  (:goal (and
    (invitation-sent invitee-1)
    (invitation-sent invitee-2)
    (invitation-sent invitee-3)
    (task-completed)
  ))
)
