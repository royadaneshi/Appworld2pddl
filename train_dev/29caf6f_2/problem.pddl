(define (problem task-29caf6f-2)
  (:domain appworld-29caf6f-2)
  (:objects
    glen laura - person
    username-8346699249 username-gl-moore-at-gmail-com - username
    phone-password simple-note-password - password
    phone-token simple-note-token - token
    query-laura query-recommendation-suggestion-movie query-movie-recommendation-suggestion - query
    laura-phone-number - phone-number
    laura-request-message - text-message
    laura-requested-director - director
    movie-recommendations-note - note
    reply-movie-titles - message
  )
  (:init
    (credential-of-app phone phone-password)
    (credential-of-app phone phone-token)
    (credential-of-app simple-note simple-note-password)
    (credential-of-app simple-note simple-note-token)
    (username-for phone username-8346699249)
    (username-for simple-note username-gl-moore-at-gmail-com)
    (password-for phone phone-password)
    (password-for simple-note simple-note-password)
    (query-for-person query-laura laura)
    (phone-number-of laura laura-phone-number)
    (message-query query-recommendation-suggestion-movie)
    (request-from laura-request-message laura)
    (request-mentions laura-request-message laura-requested-director)
    (note-query query-movie-recommendation-suggestion movie-recommendations-note)
    (reply-for reply-movie-titles laura-requested-director movie-recommendations-note)
  )
  (:goal (and
    (message-sent laura reply-movie-titles)
    (task-completed)
  ))
)
