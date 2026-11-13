from ed import *
t='c901732_3'
CODE="""a=apis.spotify.show_album(album_id=8)
print('JSON'+json.dumps([(s['id'],s['title'],apis.spotify.show_song(song_id=s['id'])['play_count']) for s in a['songs']]))"""
Sg=envjson(t,CODE); top=max(Sg,key=lambda s:s[2]); assert top[0]==private(t)['least_or_most_played_song_id']
so=lambda s:f'song-{s[0]}'
set_objects(t,'song',['song-start']+[so(s) for s in Sg])
keep=[f for f in keep_init(t,r'.') if not re.search(r'in-album|next-song|last-song|most-played',f)]
init=keep+[f'(in-album {so(s)} velvet-underground)' for s in Sg]+[f'(next-song velvet-underground {a} {b})' for a,b in zip(['song-start']+[so(s) for s in Sg],[so(s) for s in Sg])]+[f'(last-song velvet-underground {so(Sg[-1])})',f'(most-played velvet-underground {so(top)})']
set_section(t,'problem.pddl',':init',init)
b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if x['object'] in ('other-song-1','other-song-2','most-played-song')]
binds(t,drop=drop,add=[(so(s),None,'spotify.search_albums',f'song_ids entry {s[0]} of the album "Velvet Underground": "{s[1]}" (play_count {s[2]} via spotify.show_song)'+('; the most played song of the album' if s is top else '')) for s in Sg])
print(t,len(Sg),'songs; top',top)
