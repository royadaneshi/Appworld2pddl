(define (problem task-f6f2e67-2)
  (:domain appworld-f6f2e67-2)
  (:objects
    erica sister mother father - person
    username-4675246489 eri-powe-at-gmail-com - username
    phone-password gmail-password file-system-password - password
    phone-token gmail-token file-system-token - token
    rel-sister rel-mother rel-father - relationship
    sister-email mother-email father-email - email
    sister-photos-thread - email-thread
    sister-tar-attachment - attachment
    path-sister-tar path-work-dir path-childhood-pics path-work-dir-childhood-pics path-updated-tar - path
    subject-childhood-memories - subject
    body-checkout-attachments - body)
  (:init
    (username-for phone username-4675246489)
    (username-for gmail eri-powe-at-gmail-com)
    (username-for file-system eri-powe-at-gmail-com)
    (password-for phone phone-password)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (token-for phone phone-token)
    (token-for gmail gmail-token)
    (token-for file-system file-system-token)
    (relationship-of sister rel-sister)
    (relationship-of mother rel-mother)
    (relationship-of father rel-father)
    (email-of sister sister-email)
    (email-of mother mother-email)
    (email-of father father-email)
    (is-parent mother)
    (is-parent father)
    (thread-from sister-photos-thread sister)
    (attachment-in-thread sister-tar-attachment sister-photos-thread)
    (download-target path-sister-tar)
    (work-dir path-work-dir)
    (my-photos-dir path-childhood-pics)
    (subdirectory-of path-work-dir-childhood-pics path-work-dir)
    (tar-target path-updated-tar)
    (required-subject subject-childhood-memories)
    (required-body body-checkout-attachments))
  (:goal (and (parents-emailed) (task-completed)))
)
