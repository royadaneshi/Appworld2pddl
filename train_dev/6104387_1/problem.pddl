(define (problem task-6104387-1)
  (:domain appworld-6104387-1)
  (:objects
    kayla-burton - person
    ka-burt-at-gmail-com - username
    spotify-password file-system-password - password
    spotify-token file-system-token - token
    library-song - song
    library-song-artist - artist
    backups-spotify-csv - file-path
    spotify-backup-csv-content - file-content)
  (:init
    (username-of kayla-burton ka-burt-at-gmail-com)
    (password-for spotify spotify-password)
    (password-for file-system file-system-password)
    (token-for spotify spotify-token)
    (token-for file-system file-system-token)
    (song-artist library-song library-song-artist)
    (content-lists spotify-backup-csv-content library-song))
  (:goal (and (backup-created) (account-deleted spotify) (task-completed)))
)
