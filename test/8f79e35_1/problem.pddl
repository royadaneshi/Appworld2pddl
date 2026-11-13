(define (problem task-8f79e35-1)
  (:domain appworld-8f79e35-1)
  (:objects
    gina-burch - person
    gina-ritter-at-gmail-com - username
    file-system-password gmail-password - password
    file-system-token gmail-token - token
    dir-documents-personal invitees-file - path
    template-draft - draft
    invitee-email-1 invitee-email-2 invitee-email-3 invitee-email-4 invitee-email-5 invitee-email-6 - email
    subject-baby-shower-invitation - subject
    body-for-invitee-1 body-for-invitee-2 body-for-invitee-3 body-for-invitee-4 body-for-invitee-5 body-for-invitee-6 - body
  )
  (:init
    (credential-of-app file-system gina-ritter-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app gmail gina-ritter-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (in-directory invitees-file dir-documents-personal)
    (draft-subject template-draft subject-baby-shower-invitation)
    (invitee-in-file invitee-1 invitees-file)
    (invitee-in-file invitee-2 invitees-file)
    (invitee-in-file invitee-3 invitees-file)
    (invitee-in-file invitee-4 invitees-file)
    (invitee-in-file invitee-5 invitees-file)
    (invitee-in-file invitee-6 invitees-file)
    (invitee-email invitee-1 invitee-email-1)
    (invitee-email invitee-2 invitee-email-2)
    (invitee-email invitee-3 invitee-email-3)
    (invitee-email invitee-4 invitee-email-4)
    (invitee-email invitee-5 invitee-email-5)
    (invitee-email invitee-6 invitee-email-6)
    (body-for invitee-1 body-for-invitee-1)
    (body-for invitee-2 body-for-invitee-2)
    (body-for invitee-3 body-for-invitee-3)
    (body-for invitee-4 body-for-invitee-4)
    (body-for invitee-5 body-for-invitee-5)
    (body-for invitee-6 body-for-invitee-6))
  (:goal (and
    (invitation-sent invitee-1)
    (invitation-sent invitee-2)
    (invitation-sent invitee-3)
    (invitation-sent invitee-4)
    (invitation-sent invitee-5)
    (invitation-sent invitee-6)
    (task-completed)))
)
