(define (problem task-771d8fc-3)
  (:domain appworld-771d8fc-3)
  (:objects
    thomas-solomon - person
    phone-username-2192158297 - username
    phone-password - password
    phone-token - token
    number-5708520672 - phone-number
    spam-text-message - text-message
    spam-voice-message - voice-message
  )
  (:init
    (phone-number-of thomas-solomon phone-username-2192158297)
    (username-for phone phone-username-2192158297)
    (password-for phone phone-password)
    (text-from spam-text-message number-5708520672)
    (voice-from spam-voice-message number-5708520672)
  )
  (:goal (and
    (text-deleted spam-text-message)
    (voice-deleted spam-voice-message)
    (task-completed)
  ))
)
