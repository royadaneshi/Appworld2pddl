(define (problem task-8f79e35-2)
  (:domain appworld-8f79e35-2)
  (:objects
    ashley-moore invitee-1 invitee-2 invitee-3 invitee-4 invitee-5 invitee-6 invitee-7 - person
    as-moore-at-gmail-com - username
    file-system-password gmail-password - password
    file-system-token gmail-token - token
    dir-documents-personal file-baby-shower-invitees - path
    draft-baby-shower-template - draft
    email-invitee-1 email-invitee-2 email-invitee-3 email-invitee-4 email-invitee-5 email-invitee-6 email-invitee-7 - email
    subject-baby-shower-invitation - subject
    body-invitee-1 body-invitee-2 body-invitee-3 body-invitee-4 body-invitee-5 body-invitee-6 body-invitee-7 - body
  )
  (:init
    (credential-of-app file-system as-moore-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (credential-of-app gmail as-moore-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (file-in-directory file-baby-shower-invitees dir-documents-personal)
    (template-draft draft-baby-shower-template)
    (draft-subject draft-baby-shower-template subject-baby-shower-invitation)
    (invitee-listed invitee-1 file-baby-shower-invitees)
    (invitee-listed invitee-2 file-baby-shower-invitees)
    (invitee-listed invitee-3 file-baby-shower-invitees)
    (invitee-listed invitee-4 file-baby-shower-invitees)
    (invitee-listed invitee-5 file-baby-shower-invitees)
    (invitee-listed invitee-6 file-baby-shower-invitees)
    (invitee-listed invitee-7 file-baby-shower-invitees)
    (invitee-email invitee-1 email-invitee-1)
    (invitee-email invitee-2 email-invitee-2)
    (invitee-email invitee-3 email-invitee-3)
    (invitee-email invitee-4 email-invitee-4)
    (invitee-email invitee-5 email-invitee-5)
    (invitee-email invitee-6 email-invitee-6)
    (invitee-email invitee-7 email-invitee-7)
    (invite-body invitee-1 body-invitee-1)
    (invite-body invitee-2 body-invitee-2)
    (invite-body invitee-3 body-invitee-3)
    (invite-body invitee-4 body-invitee-4)
    (invite-body invitee-5 body-invitee-5)
    (invite-body invitee-6 body-invitee-6)
    (invite-body invitee-7 body-invitee-7))
  (:goal (and
    (invitation-sent invitee-1)
    (invitation-sent invitee-2)
    (invitation-sent invitee-3)
    (invitation-sent invitee-4)
    (invitation-sent invitee-5)
    (invitation-sent invitee-6)
    (invitation-sent invitee-7)
    (task-completed))))
