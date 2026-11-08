(define (problem task-baeb104-2)
  (:domain appworld-baeb104-2)
  (:objects
    kristin-white - person
    phone-number-6017026518 kri-powe-at-gmail-com - username
    phone-password file-system-password gmail-password - password
    phone-token file-system-token gmail-token - token
    relationship-sibling - relationship
    sibling-emails - email-list
    substring-sydney - substring
    flag-true - flag
    sydney-photos-dir - directory
    sydney-photos-tar - file
    subject-sydney-trip-photos - subject
    body-sydney-trip-photos - body
  )
  (:init
    (username-for phone phone-number-6017026518)
    (username-for file-system kri-powe-at-gmail-com)
    (username-for gmail kri-powe-at-gmail-com)
    (password-for phone phone-password)
    (password-for file-system file-system-password)
    (password-for gmail gmail-password)
    (emails-for-relationship relationship-sibling sibling-emails)
    (matches-substring sydney-photos-dir substring-sydney)
    (tar-file sydney-photos-tar)
  )
  (:goal (and
    (archive-created sydney-photos-tar sydney-photos-dir)
    (email-sent sibling-emails sydney-photos-tar)
    (task-completed)
  ))
)
