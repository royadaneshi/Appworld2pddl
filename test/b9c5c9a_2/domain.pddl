(define (domain appworld-b9c5c9a-2)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types app person username password token directory file content phone-number count - object
    contact-name - object)
  (:constants file-system phone - app)
  (:predicates
    (credential-of-app ?a - app ?c - object)
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (username-for ?a - app ?u - username)
    (has-token ?a - app ?t - token)
    (file-in-directory ?f - file ?d - directory)
    (rsvp-csv ?f - file)
    (known-id ?f - file)
    (file-read ?f - file)
    (invitees-known)
    (invitee ?p - person)
    (phone-of ?p - person ?n - phone-number)
    (found-reply ?p - person)
    (succ ?n - count ?m - count)
    (replies-found ?n - count)
    (total-invitees ?n - count)
    (updated-content-for ?f - file ?c - content)
    (rsvps-updated)
    (task-completed)
    (name-of ?p - person ?q - contact-name)
    (phone-known ?p - person))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app file-system ?t) (credential-of-app file-system ?pw) (credential-of-app file-system ?u) (not (task-completed)) (passwords-known) (username-for file-system ?u) (password-for file-system ?pw) (not (has-token file-system ?t)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory ?f - file)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (file-in-directory ?f ?d))
    :effect (and (known-id ?f)))

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - file ?t - token)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (known-id ?f) (rsvp-csv ?f))
    :effect (and (file-read ?f) (invitees-known)))

  ; API: phone.login
  (:action phone-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (credential-of-app phone ?t) (credential-of-app phone ?pw) (credential-of-app phone ?u) (not (task-completed)) (passwords-known) (username-for phone ?u) (password-for phone ?pw) (not (has-token phone ?t)))
    :effect (and (has-token phone ?t)))

  ; API: phone.search_contacts  (the CSV has names only; the number comes from the contact book)
  (:action phone-search-contacts
    :parameters (?t - token ?q - contact-name ?p - person ?n - phone-number)
    :precondition (and (has-token phone ?t) (invitees-known) (invitee ?p) (name-of ?p ?q) (phone-of ?p ?n) (not (phone-known ?p)) (not (task-completed)))
    :effect (phone-known ?p))

  ; API: phone.search_text_messages
  (:action phone-search-text-messages
    :parameters (?t - token ?pn - phone-number ?p - person ?n - count ?m - count)
    :precondition (and (not (task-completed)) (has-token phone ?t) (invitees-known) (invitee ?p) (phone-of ?p ?pn) (phone-known ?p) (not (found-reply ?p)) (replies-found ?n) (succ ?n ?m))
    :effect (and (found-reply ?p) (replies-found ?m) (not (replies-found ?n))))


  ; API: file_system.update_file
  (:action file-system-update-file
    :parameters (?f - file ?c - content ?t - token ?n - count)
    :precondition (and (not (task-completed)) (has-token file-system ?t) (known-id ?f) (file-read ?f) (rsvp-csv ?f) (updated-content-for ?f ?c) (replies-found ?n) (total-invitees ?n))
    :effect (and (rsvps-updated)))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and (rsvps-updated) (not (task-completed)))
    :effect (and (task-completed)))
)
