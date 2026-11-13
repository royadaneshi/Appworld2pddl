from ed import *
for t in ['e3d6c94_1','e3d6c94_2','e3d6c94_3']:
    pv=private(t); rec=set(pv['recent_song_ids']); gen=set(pv['genre_song_ids']); pl=sorted(pv['playlist_song_ids']); ids=sorted(rec|gen); assert set(pl)==rec&gen
    M=envjson(t,f"print('JSON'+json.dumps({{i:(lambda d:(d['title'],d['genre'],d['release_date'][:4]))(apis.spotify.show_song(song_id=i)) for i in {ids!r}}}))"); M={int(k):v for k,v in M.items()}
    so=lambda i:f'song-{i}'; set_objects(t,'song',[so(i) for i in ids])
    if t.endswith('_1'):
        genres=sorted({slug(M[i][1]) for i in ids}|{'classical'}); years=sorted({'year-'+M[i][2] for i in ids}|{'year-2023'})
        assert all((slug(M[i][1])=='classical')==(i in gen) and (M[i][2]=='2023')==(i in rec) for i in ids)
        set_objects(t,'genre',genres); set_objects(t,'year',years)
        init=keep_init(t,r'username|password-for|target-genre|current-year')+[f'(is-recommended {so(i)})' for i in ids]+[f'(song-genre {so(i)} {slug(M[i][1])})' for i in ids]+[f'(release-year {so(i)} year-{M[i][2]})' for i in ids]
        goal=['(playlist-created spotify-recommended-songs-playlist)','(playlist-title spotify-recommended-songs-playlist title-spotify-recommended-songs)']+[f'(in-playlist spotify-recommended-songs-playlist {so(i)})' for i in pl]
    elif t.endswith('_2'):
        init=keep_init(t,r'username|password-for')+[f'(recommended {so(i)})' for i in ids]+[f'(genre-rnb {so(i)})' for i in ids if i in gen]+[f'(released-recently {so(i)})' for i in ids if i in rec]
        goal=['(playlist-created spotify-rnb-recommendations-playlist)','(playlist-titled spotify-rnb-recommendations-playlist title-spotify-rnb-recommendations)']+[f'(song-in-playlist {so(i)} spotify-rnb-recommendations-playlist)' for i in pl]
    else:
        init=keep_init(t,r'username|password-for|\(supervisor |playlist-title')+[f'(recommended {so(i)})' for i in ids]+[f'(genre-rnb {so(i)})' for i in ids if i in gen]+[f'(released-this-year {so(i)})' for i in ids if i in rec]
        goal=['(playlist-created rnb-recommendation-playlist)']+[f'(in-playlist rnb-recommendation-playlist {so(i)})' for i in pl]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if x['object'].startswith('rec-song')]
    extra=[(g,M[[i for i in ids if slug(M[i][1])==g][0]][1] if any(slug(M[i][1])==g for i in ids) else g,None,None) for g in (genres if t.endswith('_1') else []) if g not in {x['object'] for x in b}]
    binds(t,drop=drop,add=[(so(i),None,'spotify.show_recommendations',f'song_id of the recommended song "{M[i][0]}" (genre {M[i][1]}, released {M[i][2]} via spotify.show_song; '+('goes into the playlist' if i in pl else 'does not qualify')+')') for i in ids]+extra)
    print(t,len(ids),'relevant recommended songs',len(pl),'to add')
