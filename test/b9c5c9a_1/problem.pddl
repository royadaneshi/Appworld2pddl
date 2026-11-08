(define (problem task-b9c5c9a-1)
  (:domain appworld-b9c5c9a-1)
  (:objects
    ashley-moore invitee-1 invitee-2 invitee-3 - person
    as-moore-at-gmail-com username-7336094411 - username
    file-system-password phone-password - password
    file-system-token phone-token - token
    dir-documents-personal - directory-path
    rsvp-csv-file - file-path
    phone-number-invitee-1 phone-number-invitee-2 phone-number-invitee-3 - phone-number
    csv-content-original csv-draft-after-reply-1 csv-draft-after-reply-2 csv-content-updated - content
  )
  (:init
    (username-for file-system as-moore-at-gmail-com)
    (username-for phone username-7336094411)
    (password-for file-system file-system-password)
    (password-for phone phone-password)
    (file-in-directory rsvp-csv-file dir-documents-personal)
    (invitee-in-file invitee-1 rsvp-csv-file)
    (invitee-in-file invitee-2 rsvp-csv-file)
    (invitee-in-file invitee-3 rsvp-csv-file)
    (phone-of invitee-1 phone-number-invitee-1)
    (phone-of invitee-2 phone-number-invitee-2)
    (phone-of invitee-3 phone-number-invitee-3)
    (content-draft rsvp-csv-file csv-content-original)
    (incorporates-reply csv-content-original invitee-1 csv-draft-after-reply-1)
    (incorporates-reply csv-draft-after-reply-1 invitee-2 csv-draft-after-reply-2)
    (incorporates-reply csv-draft-after-reply-2 invitee-3 csv-content-updated)
    (final-content rsvp-csv-file csv-content-updated)
  )
  (:goal (and
    (file-updated rsvp-csv-file csv-content-updated)
    (task-completed)
  ))
)
