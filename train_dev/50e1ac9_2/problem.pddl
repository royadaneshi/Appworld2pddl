(define (problem task-50e1ac9-2)
  (:domain appworld-50e1ac9-2)
  (:objects
    erika - person
    erikabail-at-gmail-com - username
    spotify-password - password
    spotify-token - token
    edm-song-in-song-library edm-song-in-album edm-song-in-playlist - song
    edm-album - album
    edm-playlist - playlist
    top-6-edm-titles - answer
  )
  (:init
    (password-for spotify spotify-password)
    (supervisor-username erikabail-at-gmail-com)
    (in-song-library edm-song-in-song-library)
    (song-from edm-song-in-song-library song-library)
    (in-album-library edm-album)
    (album-contains edm-album edm-song-in-album)
    (song-from edm-song-in-album album-library)
    (in-playlist-library edm-playlist)
    (playlist-contains edm-playlist edm-song-in-playlist)
    (song-from edm-song-in-playlist playlist-library)
  )
  (:goal (and
    (library-scanned song-library)
    (library-scanned album-library)
    (library-scanned playlist-library)
    (task-completed)
  ))
)
