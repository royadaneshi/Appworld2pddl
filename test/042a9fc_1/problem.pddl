(define (problem task-042a9fc-1)
  (:domain appworld-042a9fc-1)
  (:objects
    jose roommate-1 roommate-2 person-1 - person
    phone-username-2474975253 spotify-username-joseharr-at-gmail-com - username
    phone-password spotify-password - password
    phone-token spotify-token - token
    roommates - relationship
    roommate-phone-1 roommate-phone-2 roommate-phone-3 - phone-number
    msg-from-roommate-1 msg-from-roommate-2 text-message-1 - text-message
    roadtrip-playlist - playlist
    song-to-add-1
    song-to-add-2
    song-to-add-3
    song-to-add-4 - song
    song-to-remove-1
    song-to-remove-2
    song-to-remove-3
    song-to-remove-4
    song-to-remove-5
    song-to-remove-6 - song
    query-song-to-add-1
    query-song-to-add-2
    query-song-to-add-3
    query-song-to-add-4 - query)
  (:init
    (username-for phone phone-username-2474975253)
    (username-for spotify spotify-username-joseharr-at-gmail-com)
    (password-for phone phone-password)
    (password-for spotify spotify-password)
    (token-for phone phone-token)
    (token-for spotify spotify-token)
    (relationship-of roommate-1 roommates)
    (has-phone roommate-1 roommate-phone-1)
    (sent-message roommate-1 msg-from-roommate-1)
    (relationship-of roommate-2 roommates)
    (has-phone roommate-2 roommate-phone-2)
    (sent-message roommate-2 msg-from-roommate-2)
    (relationship-of person-1 roommates)
    (has-phone person-1 roommate-phone-3)
    (sent-message person-1 text-message-1)
    (suggests-add msg-from-roommate-1 song-to-add-1)
    (song-query song-to-add-1 query-song-to-add-1)
    (suggests-add msg-from-roommate-1 song-to-add-2)
    (song-query song-to-add-2 query-song-to-add-2)
    (suggests-add msg-from-roommate-2 song-to-add-3)
    (song-query song-to-add-3 query-song-to-add-3)
    (suggests-add msg-from-roommate-2 song-to-add-4)
    (song-query song-to-add-4 query-song-to-add-4)
    (suggests-remove msg-from-roommate-1 song-to-remove-1)
    (in-playlist roadtrip-playlist song-to-remove-1)
    (suggests-remove msg-from-roommate-1 song-to-remove-2)
    (in-playlist roadtrip-playlist song-to-remove-2)
    (suggests-remove msg-from-roommate-1 song-to-remove-3)
    (in-playlist roadtrip-playlist song-to-remove-3)
    (suggests-remove msg-from-roommate-2 song-to-remove-4)
    (in-playlist roadtrip-playlist song-to-remove-4)
    (suggests-remove msg-from-roommate-2 song-to-remove-5)
    (in-playlist roadtrip-playlist song-to-remove-5)
    (suggests-remove msg-from-roommate-2 song-to-remove-6)
    (in-playlist roadtrip-playlist song-to-remove-6))
  (:goal (and
    (added roadtrip-playlist song-to-add-1)
    (added roadtrip-playlist song-to-add-2)
    (added roadtrip-playlist song-to-add-3)
    (added roadtrip-playlist song-to-add-4)
    (in-playlist roadtrip-playlist song-to-add-1)
    (in-playlist roadtrip-playlist song-to-add-2)
    (in-playlist roadtrip-playlist song-to-add-3)
    (in-playlist roadtrip-playlist song-to-add-4)
    (removed roadtrip-playlist song-to-remove-1)
    (removed roadtrip-playlist song-to-remove-2)
    (removed roadtrip-playlist song-to-remove-3)
    (removed roadtrip-playlist song-to-remove-4)
    (removed roadtrip-playlist song-to-remove-5)
    (removed roadtrip-playlist song-to-remove-6)
    (not (in-playlist roadtrip-playlist song-to-remove-1))
    (not (in-playlist roadtrip-playlist song-to-remove-2))
    (not (in-playlist roadtrip-playlist song-to-remove-3))
    (not (in-playlist roadtrip-playlist song-to-remove-4))
    (not (in-playlist roadtrip-playlist song-to-remove-5))
    (not (in-playlist roadtrip-playlist song-to-remove-6))
    (task-completed)))
)
