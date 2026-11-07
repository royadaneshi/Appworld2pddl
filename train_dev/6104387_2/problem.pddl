(define (problem task-6104387-2)
  (:domain appworld-6104387-2)
  (:objects
    sabrina - person
    sab-brown-at-gmail-com - username
    spotify-password file-system-password - password
    spotify-token file-system-token - token
    library-song - song
    library-artist - artist
    backups-spotify-library-csv - file-path
    library-csv-content - file-content)
  (:init
    (supervisor-username sab-brown-at-gmail-com)
    (password-for spotify spotify-password)
    (password-for file-system file-system-password)
    (song-artist library-song library-artist)
    (backup-target backups-spotify-library-csv library-csv-content)
    (content-for-song library-csv-content library-song))
  (:goal (and (backup-complete) (account-deleted spotify) (task-completed)))
)
