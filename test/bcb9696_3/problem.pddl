(define (problem task-bcb9696-3)
  (:domain appworld-bcb9696-3)
  (:objects
    claudia-miller manager - person
    clmiller-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-headshot - query
    substring-headshot - substring
    true - flag
    draft-headshot-reply - draft
    attachment-resume - attachment
    headshot-file-path - file-path)
  (:init
    (credential-of-app gmail clmiller-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system clmiller-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (recipient-of draft-headshot-reply manager)
    (query-for query-headshot draft-headshot-reply)
    (substring-for substring-headshot headshot-file-path)
    (attached attachment-resume draft-headshot-reply)
    (wrong-attachment attachment-resume draft-headshot-reply)
    (correct-file headshot-file-path draft-headshot-reply))
  (:goal (and
    (sent draft-headshot-reply)
    (not (attached attachment-resume draft-headshot-reply))
    (file-attached headshot-file-path draft-headshot-reply)
    (task-completed)))
)
