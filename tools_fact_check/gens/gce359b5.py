from ed import *
CODE=LOGIN+"""t=tok('spotify')
lib=[s['song_id'] for s in pages(apis.spotify.show_song_library,access_token=t)]
pls=[(p['playlist_id'],p['title'],p['song_ids']) for p in pages(apis.spotify.show_playlist_library,access_token=t)]
meta={}
for s in set(lib)|{x for p in pls for x in p[2]}:
    d=apis.spotify.show_song(song_id=s); meta[s]=(d['title'],d['release_date'][:10])
print('JSON'+json.dumps({'lib':lib,'pls':pls,'meta':meta}))"""
cfg={'ce359b5_1':(lambda y:y<2021,'released-before-2021','contains','song-library'),'ce359b5_2':(lambda y:y>2021,'released-after-2021','contains','my-song-library'),'ce359b5_3':(lambda y:y<=2021,'released-in-or-before-2021','in-container','song-library')}
for t,(cond,pred,cont,libo) in cfg.items():
    d=envjson(t,CODE); meta={int(k):v for k,v in d['meta'].items()}; pv=private(t)
    old=lambda s:cond(int(meta[s][1][:4])); so=lambda s:f'song-{s}'; po=lambda p:f'playlist-{p[0]}'
    pairs=[(libo,s) for s in d['lib']]+[(po(p),s) for p in d['pls'] for s in p[2]]
    rem=[(c,s) for c,s in pairs if old(s)]; nl=sum(1 for c,s in rem if c==libo)
    assert nl==len(pv['to_delete_library_song_link_ids']) and len(rem)-nl==len(pv['to_delete_playlist_song_link_ids']),(nl,len(rem)-nl)
    allsongs=sorted({s for _,s in pairs}); K=len(rem)
    set_objects(t,'playlist',[po(p) for p in d['pls']]); set_objects(t,'song',[so(s) for s in allsongs])
    keep=keep_init(t,r'username|password-for')
    init=keep+[f'({cont} {c} {so(s)})' for c,s in pairs]+[f'({pred} {so(s)})' for s in allsongs if old(s)]
    goal=[f'(not ({cont} {c} {so(s)}))' for c,s in rem]
    if not t.endswith('_3'):
        set_objects(t,'count',[f'n{i}' for i in range(1,K+1)]); init+=[f'(succ n{i} n{i+1})' for i in range(K)]+[f'(pending-removals n{K})']; goal+=['(pending-removals n0)']
    else:
        goal+=[f'({cont} {c} {so(s)})' for c,s in pairs if not old(s)]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',goal+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if re.match(r'(playlist-\d|song-|library-song|playlist-song)',x['object'])]
    inlib=set(d['lib'])
    add=[(po(p),None,'spotify.show_playlist_library',f'playlist_id of "{p[1]}"') for p in d['pls']]+[(so(s),None,'spotify.show_song_library' if s in inlib else 'spotify.show_playlist_library',f'song_id of "{meta[s][0]}" (release_date {meta[s][1]} via spotify.show_song; '+('to remove' if old(s) else 'keep')+')') for s in allsongs]
    binds(t,drop=drop,add=add); print(t,len(allsongs),'songs',nl,'library removals',K-nl,'playlist removals')
