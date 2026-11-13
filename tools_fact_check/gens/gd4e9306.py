from ed import *
CODE=LOGIN+"""t=tok('spotify')
ls=[]
for s in pages(apis.spotify.show_liked_songs,access_token=t):
    d=apis.spotify.show_song(song_id=s['song_id']); ls.append((s['song_id'],d['title'],[(a['id'],a['name']) for a in d['artists']]))
la=[]
for a in pages(apis.spotify.show_liked_albums,access_token=t):
    d=apis.spotify.show_album(album_id=a['album_id']); la.append((a['album_id'],d['title'],[(x['id'],x['name']) for x in d['artists']]))
print('JSON'+json.dumps({'ls':ls,'la':la}))"""
for t in ['d4e9306_1','d4e9306_2','d4e9306_3']:
    d=envjson(t,CODE); pv=private(t); ws=set(pv['to_be_followed_artist_ids_by_songs']); wa=set(pv['to_be_followed_artist_ids_by_albums']); want=ws|wa
    name={i:n for _,_,ar in d['ls']+d['la'] for i,n in ar}; ao=lambda i:'artist-'+slug(name[i]); so=lambda s:f'song-{s[0]}'; al=lambda a:f'album-{a[0]}'
    S_=[s for s in d['ls'] if any(i in ws for i,_ in s[2])]; A_=[a for a in d['la'] if any(i in wa for i,_ in a[2])]
    assert {i for s in S_ for i,_ in s[2]}>=ws and {i for a in A_ for i,_ in a[2]}>=wa
    AR=sorted(want); ps,pa=('artist-of-song','artist-of-album') if t.endswith('_1') else ('song-artist','album-artist')
    set_objects(t,'song',[so(s) for s in S_]); set_objects(t,'album',[al(a) for a in A_])
    if t.endswith('_2'):
        sub(t,'domain.pddl','artist-1 artist-2 artist-3 artist-4 - artist',' '.join(ao(i) for i in AR)+' - artist'); ctask(t,[f'(following {ao(i)})' for i in AR])
    else: set_objects(t,'artist',[ao(i) for i in AR])
    init=keep_init(t,r'username|password-for')+[f'(liked-song {so(s)})' for s in S_]+[f'(liked-album {al(a)})' for a in A_]+[f'({ps} {so(s)} {ao(i)})' for s in S_ for i,_ in s[2] if i in want]+[f'({pa} {al(a)} {ao(i)})' for a in A_ for i,_ in a[2] if i in want]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',[f'(following {ao(i)})' for i in AR]+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.match(r'(liked-song|liked-album|artist-)',x['object'])]
    add=[(so(s),None,'spotify.show_liked_songs',f'song_id of the liked song "{s[1]}"') for s in S_]+[(al(a),None,'spotify.show_liked_albums',f'album_id of the liked album "{a[1]}"') for a in A_]+[(ao(i),None,'spotify.show_song' if i in ws else 'spotify.show_album',f'artists[].id of "{name[i]}" (artist of a liked '+('song' if i in ws else 'album')+', not yet followed)') for i in AR]
    binds(t,drop=drop,add=add); print(t,len(S_),'songs',len(A_),'albums',len(AR),'artists')
