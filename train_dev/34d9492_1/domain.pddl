(define (domain appworld-34d9492-1)
  (:requirements :strips :typing :negative-preconditions :equality)
  (:types
    app person username password token directory filepath month - object
  )
  (:constants
    file-system phone supervisor - app
    photo-img-02237d7-jpg photo-img-0d36b21-jpeg photo-img-0e15e48-jpg photo-img-164a3fe-jpeg photo-img-16b39ad-png photo-img-18b06cc-png photo-img-1a2b16d-jpeg photo-img-254fbd9-jpg photo-img-26cb65d-png photo-img-29f19c8-jpg photo-img-2dbefae-png photo-img-2ecf83d-jpeg photo-img-301305f-jpg photo-img-32dc30d-jpeg photo-img-44361f7-jpeg photo-img-4d1aafc-jpeg photo-img-4d7f44a-jpeg photo-img-537a8a3-png photo-img-5c2f56b-jpeg photo-img-62679d2-jpeg photo-img-6a1d6f6-jpeg photo-img-6a74f01-jpeg photo-img-6d078f8-jpg photo-img-750c944-jpeg photo-img-799a654-jpeg photo-img-7e6273e-png photo-img-846760e-jpg photo-img-8df984b-png photo-img-8f8933a-jpeg photo-img-a1640a1-png photo-img-a46cf01-jpg photo-img-a5da8e1-png photo-img-abab143-png photo-img-b70df1d-png photo-img-c1d84e4-jpeg photo-img-d77a00c-png photo-img-da771fe-jpeg photo-img-ede9877-jpeg photo-img-f1ac2b4-jpg photo-img-f24e638-jpeg photo-img-f8dd7c3-jpeg photo-img-fcc5ff7-jpeg - filepath
    petra-dir budapest-dir amsterdam-dir - directory
  )
  (:predicates
    (passwords-known)
    (password-for ?a - app ?pw - password)
    (has-token ?a - app ?t - token)
    (supervisor-email ?p - person ?u - username)
    (known-username ?u - username)
    (current-date-known)
    (in-directory ?f - filepath ?d - directory)
    (directory-listed ?d - directory)
    (created-in ?f - filepath ?m - month)
    (known-created-in ?f - filepath ?m - month)
    (month-destination ?m - month ?d - directory)
    (moved-path ?src - filepath ?d - directory ?dst - filepath)
    (moved ?f - filepath ?d - directory)
    (task-completed)
  )

  ; API: supervisor.show_profile
  (:action supervisor-show-profile
    :parameters (?p - person ?u - username)
    :precondition (and (supervisor-email ?p ?u) (not (task-completed)))
    :effect (known-username ?u)
  )

  ; API: supervisor.show_account_passwords
  (:action supervisor-show-account-passwords
    :parameters ()
    :precondition (not (task-completed))
    :effect (passwords-known)
  )

  ; API: file_system.login
  (:action file-system-login
    :parameters (?u - username ?pw - password ?t - token)
    :precondition (and (passwords-known) (known-username ?u) (password-for file-system ?pw) (not (has-token file-system ?t)) (not (task-completed)))
    :effect (has-token file-system ?t)
  )

  ; API: phone.get_current_date_and_time
  (:action phone-get-current-date-and-time
    :parameters ()
    :precondition (not (task-completed))
    :effect (current-date-known)
  )

  ; API: file_system.show_directory
  (:action file-system-show-directory
    :parameters (?t - token ?d - directory)
    :precondition (and (has-token file-system ?t) (not (task-completed)))
    :effect (directory-listed ?d)
  )

  ; API: file_system.show_file
  (:action file-system-show-file
    :parameters (?f - filepath ?t - token ?d - directory ?m - month)
    :precondition (and (has-token file-system ?t) (current-date-known) (in-directory ?f ?d) (directory-listed ?d) (created-in ?f ?m) (not (task-completed)))
    :effect (known-created-in ?f ?m)
  )

  ; API: file_system.move_file
  (:action file-system-move-file
    :parameters (?src - filepath ?dst - filepath ?t - token ?m - month ?d - directory)
    :precondition (and (has-token file-system ?t) (known-created-in ?src ?m) (month-destination ?m ?d) (moved-path ?src ?d ?dst) (not (moved ?src ?d)) (not (task-completed)))
    :effect (moved ?src ?d)
  )

  ; API: supervisor.complete_task
  (:action supervisor-complete-task
    :parameters ()
    :precondition (and
      (moved photo-img-02237d7-jpg petra-dir)
      (moved photo-img-0d36b21-jpeg amsterdam-dir)
      (moved photo-img-0e15e48-jpg budapest-dir)
      (moved photo-img-164a3fe-jpeg amsterdam-dir)
      (moved photo-img-16b39ad-png budapest-dir)
      (moved photo-img-18b06cc-png petra-dir)
      (moved photo-img-1a2b16d-jpeg petra-dir)
      (moved photo-img-254fbd9-jpg petra-dir)
      (moved photo-img-26cb65d-png budapest-dir)
      (moved photo-img-29f19c8-jpg amsterdam-dir)
      (moved photo-img-2dbefae-png amsterdam-dir)
      (moved photo-img-2ecf83d-jpeg budapest-dir)
      (moved photo-img-301305f-jpg budapest-dir)
      (moved photo-img-32dc30d-jpeg budapest-dir)
      (moved photo-img-44361f7-jpeg amsterdam-dir)
      (moved photo-img-4d1aafc-jpeg petra-dir)
      (moved photo-img-4d7f44a-jpeg petra-dir)
      (moved photo-img-537a8a3-png amsterdam-dir)
      (moved photo-img-5c2f56b-jpeg petra-dir)
      (moved photo-img-62679d2-jpeg petra-dir)
      (moved photo-img-6a1d6f6-jpeg budapest-dir)
      (moved photo-img-6a74f01-jpeg budapest-dir)
      (moved photo-img-6d078f8-jpg petra-dir)
      (moved photo-img-750c944-jpeg petra-dir)
      (moved photo-img-799a654-jpeg amsterdam-dir)
      (moved photo-img-7e6273e-png amsterdam-dir)
      (moved photo-img-846760e-jpg petra-dir)
      (moved photo-img-8df984b-png amsterdam-dir)
      (moved photo-img-8f8933a-jpeg budapest-dir)
      (moved photo-img-a1640a1-png amsterdam-dir)
      (moved photo-img-a46cf01-jpg petra-dir)
      (moved photo-img-a5da8e1-png budapest-dir)
      (moved photo-img-abab143-png amsterdam-dir)
      (moved photo-img-b70df1d-png budapest-dir)
      (moved photo-img-c1d84e4-jpeg amsterdam-dir)
      (moved photo-img-d77a00c-png budapest-dir)
      (moved photo-img-da771fe-jpeg amsterdam-dir)
      (moved photo-img-ede9877-jpeg amsterdam-dir)
      (moved photo-img-f1ac2b4-jpg petra-dir)
      (moved photo-img-f24e638-jpeg budapest-dir)
      (moved photo-img-f8dd7c3-jpeg budapest-dir)
      (moved photo-img-fcc5ff7-jpeg budapest-dir)
      (not (task-completed)))
    :effect (task-completed)
  )
)
