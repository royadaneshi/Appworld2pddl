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
    (credential-of-app gmail tra-wils-at-gmail-com)
    (credential-of-app gmail gmail-password)
    (credential-of-app gmail gmail-token)
    (credential-of-app file-system tra-wils-at-gmail-com)
    (credential-of-app file-system file-system-password)
    (credential-of-app file-system file-system-token)
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
