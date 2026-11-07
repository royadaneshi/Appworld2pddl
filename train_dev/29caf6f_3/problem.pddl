(define (problem task-29caf6f-3)
  (:domain appworld-29caf6f-3)
  (:objects
    patricia leslie - person
    phone-2444880289 pa-ritter-at-gmail-com - username
    phone-password simple-note-password - password
    phone-token simple-note-token - token
    query-leslie query-recommendation-suggestion-movie query-movie-recommendation-suggestion - query
    leslie-phone-number - phone-number
    leslie-request-message - text-message
    note-movie-recommendations - note
    requested-director - director
    reply-movie-titles - message
  )
  (:init
    (username-for phone phone-2444880289)
    (username-for simple-note pa-ritter-at-gmail-com)
    (password-for phone phone-password)
    (password-for simple-note simple-note-password)
    (contact-query leslie query-leslie)
    (phone-number-of leslie leslie-phone-number)
    (message-query leslie-request-message query-recommendation-suggestion-movie)
    (request-from leslie-request-message leslie)
    (mentions-director leslie-request-message requested-director)
    (note-query note-movie-recommendations query-movie-recommendation-suggestion)
    (reply-content reply-movie-titles requested-director note-movie-recommendations)
  )
  (:goal (and (text-sent leslie reply-movie-titles) (task-completed)))
)
