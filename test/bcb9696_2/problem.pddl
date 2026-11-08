(define (problem task-bcb9696-2)
  (:domain appworld-bcb9696-2)
  (:objects
    travis - person
    tra-wils-at-gmail-com - username
    gmail-password file-system-password - password
    gmail-token file-system-token - token
    query-headshot - query
    substring-headshot - substring
    flag-true - flag
    headshot-file - file-path)
  (:init
    (password-for gmail gmail-password)
    (password-for file-system file-system-password)
    (draft-matches headshot-draft query-headshot)
    (attached cv-attachment headshot-draft)
    (file-matches headshot-file substring-headshot)
    (attachment-of-file headshot-attachment headshot-file))
  (:goal (and
    (sent headshot-draft)
    (attached headshot-attachment headshot-draft)
    (not (attached cv-attachment headshot-draft))
    (task-completed)))
)
