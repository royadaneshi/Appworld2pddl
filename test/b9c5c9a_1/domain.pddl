(define (domain appworld-b9c5c9a-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory-path file-path phone-number content - object
    contact-name - object)
  (:constants
    file-system phone - app
  )
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (username-for ?a - app ?u - username)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (file-in-directory ?f - file-path ?d - directory-path)
    (known-id ?f - file-path)
    (file-read ?f - file-path)
    (invitee-in-file ?p - person ?f - file-path)
    (phone-of ?p - person ?n - phone-number)
    (found-latest-reply ?p - person)
    (content-draft ?f - file-path ?c - content)
    (incorporates-reply ?c1 - content ?p - person ?c2 - content)
    (final-content ?f - file-path ?c - content)
    (file-updated ?f - file-path ?c - content)
    (task-completed)
    (name-of ?p - person ?q - contact-name)
    (phone-known ?p - person))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u)
      (passwords-known)
      (username-for file-system ?u)
      (password-for file-system ?pw)
      (not (has-token file-system ?t))
      (not (task-completed))
    )
    :effect (has-token file-system ?t)
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory-path ?f - file-path)
    :precondition (and
      (has-token file-system ?t)
      (file-in-directory ?f ?d)
      (not (task-completed))
    )
    :effect (known-id ?f)
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file-path ?t - token)
    :precondition (and
      (has-token file-system ?t)
      (known-id ?f)
      (not (task-completed))
    )
    :effect (file-read ?f)
  )

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u)
      (passwords-known)
      (username-for phone ?u)
      (password-for phone ?pw)
      (not (has-token phone ?t))
      (not (task-completed))
    )
    :effect (has-token phone ?t)
  )

  ; API: phone.search_contacts  (the CSV has names only; the number comes from the contact book)
  (:action phone-search-contacts
    :parameters (?t - token ?q - contact-name ?p - person ?n - phone-number ?f - file-path)
    :precondition (and (has-token phone ?t) (file-read ?f) (invitee-in-file ?p ?f) (name-of ?p ?q) (phone-of ?p ?n) (not (phone-known ?p)) (not (task-completed)))
    :effect (phone-known ?p))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?n - phone-number ?p - person ?f - file-path ?c1 - content ?c2 - content)
    :precondition (and
      (has-token phone ?t)
      (file-read ?f)
      (invitee-in-file ?p ?f)
      (phone-of ?p ?n) (phone-known ?p)
      (not (found-latest-reply ?p))
      (content-draft ?f ?c1)
      (incorporates-reply ?c1 ?p ?c2)
      (not (task-completed))
    )
    :effect (and
      (found-latest-reply ?p)
      (not (content-draft ?f ?c1))
      (content-draft ?f ?c2)
    )
  )


  ; API: file_system.update_file
  (:action file-system-update-file
    :parameters (?f - file-path ?c - content ?t - token)
    :precondition (and
      (has-token file-system ?t)
      (file-read ?f)
      (content-draft ?f ?c)
      (final-content ?f ?c)
      (not (file-updated ?f ?c))
      (not (task-completed))
    )
    :effect (file-updated ?f ?c)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters (?f - file-path ?c - content)
    :precondition (and
      (file-updated ?f ?c)
      (not (task-completed))
    )
    :effect (task-completed)
  )
)
