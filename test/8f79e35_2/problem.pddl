(define (problem task-8f79e35-2)
  (:domain appworld-8f79e35-2)
  (:objects
    ashley-moore invitee-1 invitee-2 invitee-3 - person
    as-moore-at-gmail-com - username
    file-system-password gmail-password - password
    file-system-token gmail-token - token
    dir-documents-personal file-baby-shower-invitees - path
    draft-baby-shower-template - draft
    email-invitee-1 email-invitee-2 email-invitee-3 - email
    subject-baby-shower-invitation - subject
    body-invitee-1 body-invitee-2 body-invitee-3 - body)
  (:init
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (file-in-directory file-baby-shower-invitees dir-documents-personal)
    (invitee-listed invitee-1 file-baby-shower-invitees)
    (invitee-listed invitee-2 file-baby-shower-invitees)
    (invitee-listed invitee-3 file-baby-shower-invitees)
    (invitee-email invitee-1 email-invitee-1)
    (invitee-email invitee-2 email-invitee-2)
    (invitee-email invitee-3 email-invitee-3)
    (template-draft draft-baby-shower-template)
    (draft-subject draft-baby-shower-template subject-baby-shower-invitation)
    (invite-body invitee-1 body-invitee-1)
    (invite-body invitee-2 body-invitee-2)
    (invite-body invitee-3 body-invitee-3))
  (:goal (and
    (invitation-sent invitee-1)
    (invitation-sent invitee-2)
    (invitation-sent invitee-3)
    (task-completed))))
