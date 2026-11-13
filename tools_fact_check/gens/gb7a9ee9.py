from ed import *
CODE=LOGIN+"""t=tok('spotify')
out=[]; meta={}
for p in pages(apis.spotify.show_playlist_library,access_token=t):
    out.append((p['playlist_id'],p['title'],p['song_ids']))
    for s in p['song_ids']:
        if s not in meta:
            d=apis.spotify.show_song(song_id=s); meta[s]=(d['title'],d['genre'],[(a['id'],a['name']) for a in d['artists']])
print('JSON'+json.dumps({'pl':out,'meta':meta}))"""
for t,genre in [('b7a9ee9_1','classical'),('b7a9ee9_2','reggae'),('b7a9ee9_3','indie')]:
    d=envjson(t,CODE); meta={int(k):v for k,v in d['meta'].items()}; want=set(private(t)['to_be_followed_artist_ids'])
    gs=[s for s,v in meta.items() if v[1].lower()==genre]; name={i:n for s in gs for i,n in meta[s][2]}
    assert want<= set(name),(want,set(name))
    ao=lambda i:'artist-'+slug(name[i]); so=lambda s:f'song-{s}'; po=lambda p:f'playlist-{p[0]}'
    S_=sorted(s for s in gs if any(i in want for i,_ in meta[s][2])); PL=[p for p in d['pl'] if any(s in S_ for s in p[2])]; A=sorted(want)
    set_objects(t,'playlist',[po(p) for p in PL]); set_objects(t,'song',[so(s) for s in S_])
    keep=keep_init(t,r'username|password-for')
    cont=[(p,s) for p in PL for s in p[2] if s in S_]
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.search(r'playlist-\d|song-\d|artist-\d',x['object'])]
    if t.endswith('_1'):
        sub(t,'domain.pddl','classical-artist-1 classical-artist-2 - artist',' '.join(ao(i) for i in A)+' - artist'); ctask(t,[f'(following {ao(i)})' for i in A]); set_objects(t,'artist',[])
        init=keep+[f'(owns-playlist {po(p)})' for p in PL]+[f'(contains {po(p)} {so(s)})' for p,s in cont]+[f'(song-genre {so(s)} classical)' for s in S_]+[f'(song-artist {so(s)} {ao(i)})' for s in S_ for i,_ in meta[s][2] if i in want]
        goal=[f'(following {ao(i)})' for i in A]
    elif t.endswith('_2'):
        n=len(A); set_objects(t,'artist',[ao(i) for i in A]); set_objects(t,'count',[f'count-{i}' for i in range(1,n+1)])
        init=keep+[f'(in-library {po(p)})' for p in PL]+[f'(in-playlist {so(s)} {po(p)})' for p,s in cont]+[f'(song-genre {so(s)} reggae)' for s in S_]+[f'(song-artist {so(s)} {ao(i)})' for s in S_ for i,_ in meta[s][2] if i in want]+[f'(remaining-to-follow count-{n})']+[f'(count-pred count-{i} count-{i-1})' for i in range(n,0,-1)]
        goal=[f'(following {ao(i)})' for i in A]+['(remaining-to-follow count-0)']
    else:
        sub(t,'domain.pddl','indie-artist-1 indie-artist-2 - artist',' '.join(ao(i) for i in A)+' - artist'); ctask(t,[f'(following {ao(i)})' for i in A]); set_objects(t,'artist',[])
        init=keep+[f'(in-playlist {po(p)} {so(s)})' for p,s in cont]+[f'(song-genre {so(s)} indie)' for s in S_]+[f'(song-artist {so(s)} {ao(i)})' for s in S_ for i,_ in meta[s][2] if i in want]
        goal=[f'(following {ao(i)})' for i in A]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    add=[(po(p),None,'spotify.show_playlist_library',f'playlist_id of "{p[1]}" (contains {genre} songs)') for p in PL]+[(so(s),None,'spotify.show_playlist',f'songs[].id of "{meta[s][0]}" (genre {genre} via spotify.show_song)') for s in S_]+[(ao(i),None,'spotify.show_song',f'artists[].id of "{name[i]}" (artist of a {genre} playlist song, not yet followed)') for i in A]
    binds(t,drop=drop,add=add); print(t,len(PL),'playlists',len(S_),'songs',len(A),'artists')
