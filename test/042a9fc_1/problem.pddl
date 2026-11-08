(define (problem task-042a9fc-1)
  (:domain appworld-042a9fc-1)
  (:objects
    jose roommate-1 roommate-2 - person
    phone-username-2474975253 spotify-username-joseharr-at-gmail-com - username
    phone-password spotify-password - password
    phone-token spotify-token - token
    roommates - relationship
    roommate-1-phone roommate-2-phone - phone-number
    msg-from-roommate-1 msg-from-roommate-2 - text-message
    roadtrip-playlist - playlist
    song-to-add song-to-remove - song
    query-song-to-add - query)
  (:init
    (username-for phone phone-username-2474975253)
    (username-for spotify spotify-username-joseharr-at-gmail-com)
    (password-for phone phone-password)
    (password-for spotify spotify-password)
    (token-for phone phone-token)
    (token-for spotify spotify-token)
    (relationship-of roommate-1 roommates)
    (relationship-of roommate-2 roommates)
    (has-phone roommate-1 roommate-1-phone)
    (has-phone roommate-2 roommate-2-phone)
    (sent-message roommate-1 msg-from-roommate-1)
    (sent-message roommate-2 msg-from-roommate-2)
    (suggests-add msg-from-roommate-1 song-to-add)
    (suggests-remove msg-from-roommate-2 song-to-remove)
    (song-query song-to-add query-song-to-add)
    (in-playlist roadtrip-playlist song-to-remove))
  (:goal (and
    (added roadtrip-playlist song-to-add)
    (removed roadtrip-playlist song-to-remove)
    (in-playlist roadtrip-playlist song-to-add)
    (not (in-playlist roadtrip-playlist song-to-remove))
    (task-completed)))
)
