(define (problem task-bcb9696-1)
  (:domain appworld-bcb9696-1)
  (:objects
    norman-smith manager - person
    normansmit-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-headshot - query
    headshot-draft - draft
    resume-attachment - attachment
    headshot-file - file
    headshot-file-path - path
    flag-true - flag
  )
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (draft-matches query-headshot headshot-draft)
    (draft-to headshot-draft manager)
    (draft-exists headshot-draft)
    (attached-to-draft resume-attachment headshot-draft)
    (file-matches query-headshot headshot-file)
    (file-at-path headshot-file headshot-file-path)
  )
  (:goal (and
    (removed-from-draft resume-attachment headshot-draft)
    (file-attached-to-draft headshot-file headshot-draft)
    (draft-sent headshot-draft)
    (task-completed)
  ))
)
