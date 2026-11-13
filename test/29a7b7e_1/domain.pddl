(define (domain appworld-29a7b7e-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token dirpath filepath mfile - object)
  (:constants
    file-system supervisor - app
    meeting-file-1 meeting-file-2 meeting-file-3 meeting-file-4 meeting-file-5 meeting-file-6 meeting-file-7 meeting-file-8 meeting-file-9 meeting-file-10 meeting-file-11 meeting-file-12 meeting-file-13 meeting-file-14 meeting-file-15 meeting-file-16 meeting-file-17 meeting-file-18 meeting-file-19 meeting-file-20 - mfile)
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (listed ?d - dirpath)
    (dir-exists ?d - dirpath)
    (in-directory ?f - mfile ?d - dirpath)
    (source-path ?f - mfile ?p - filepath)
    (dest-path ?f - mfile ?p - filepath)
    (dest-dir ?f - mfile ?d - dirpath)
    (parent-dir ?d - dirpath ?parent - dirpath)
    (reorganized ?f - mfile)
    (task-completed))

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (and (not (task-completed)))
    :effect (and (passwords-known)))

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (and (has-token file-system ?t)))

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - dirpath)
    :precondition (and (has-token file-system ?t) (dir-exists ?d) (not (task-completed)))
    :effect (and (listed ?d)))

  ; API: file_system.create_directory
  (:action file-system-create-directory
    :parameters (?d - dirpath ?t - token ?parent - dirpath)
    :precondition (and (has-token file-system ?t) (parent-dir ?d ?parent) (dir-exists ?parent) (listed ?parent) (not (dir-exists ?d)) (not (task-completed)))
    :effect (and (dir-exists ?d)))

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?src - filepath ?dst - filepath ?t - token ?f - mfile ?m - dirpath ?d - dirpath)
    :precondition (and (has-token file-system ?t) (in-directory ?f ?m) (listed ?m) (source-path ?f ?src) (dest-path ?f ?dst) (dest-dir ?f ?d) (dir-exists ?d) (not (reorganized ?f)) (not (task-completed)))
    :effect (and (reorganized ?f) (not (in-directory ?f ?m))))

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (reorganized meeting-file-1)
      (reorganized meeting-file-2)
      (reorganized meeting-file-3)
      (reorganized meeting-file-4)
      (reorganized meeting-file-5)
      (reorganized meeting-file-6)
      (reorganized meeting-file-7)
      (reorganized meeting-file-8)
      (reorganized meeting-file-9)
      (reorganized meeting-file-10)
      (reorganized meeting-file-11)
      (reorganized meeting-file-12)
      (reorganized meeting-file-13)
      (reorganized meeting-file-14)
      (reorganized meeting-file-15)
      (reorganized meeting-file-16)
      (reorganized meeting-file-17)
      (reorganized meeting-file-18)
      (reorganized meeting-file-19)
      (reorganized meeting-file-20)
      (not (task-completed)))
    :effect (and (task-completed))))
