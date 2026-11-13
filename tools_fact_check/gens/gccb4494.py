from ed import *
for t in ['ccb4494_1','ccb4494_2','ccb4494_3']:
    pv=private(t); L=pv['song_ids_to_like']; Q=pv['song_ids_in_queue']; so=lambda i:f'song-{i}'; cur=L[-1]; assert Q[:len(L)]==L
    keep=keep_init(t,r'username|password-for|\(supervisor ')
    if t.endswith('_1'):
        sub(t,'domain.pddl','song-queue-1 song-queue-2 song-current - song',' '.join(so(i) for i in L)+' - song'); ctask(t,[f'(liked {so(i)})' for i in L]); set_objects(t,'song',[so(i) for i in Q[len(L):]])
        init=keep+[f'(played-so-far {so(i)})' for i in L]
    elif t.endswith('_2'):
        set_objects(t,'song',[so(i) for i in Q])
        init=keep+[f'(queue-first {so(Q[0])})']+[f'(queue-next {so(a)} {so(b)})' for a,b in zip(Q,Q[1:])]+[f'(current-song {so(cur)})']+[f'(played-so-far {so(i)})' for i in L]
    else:
        set_objects(t,'song',[so(i) for i in Q])
        init=keep+[f'(in-queue {so(i)})' for i in Q]+[f'(current-song {so(cur)})']+[f'(played-so-far {so(i)})' for i in L]
    set_section(t,'problem.pddl',':init',init); set_section(t,'problem.pddl',':goal',[f'(liked {so(i)})' for i in L]+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if x['object'].startswith('song-')]
    binds(t,drop=drop,add=[(so(i),None,'spotify.show_song_queue',f'song_id at queue position {k+1} of 10'+(' (the current song, per spotify.show_current_song)' if i==cur else (' (played before the current song)' if i in L else ' (upcoming, not to be liked)'))) for k,i in enumerate(Q)])
    print(t,len(L),len(Q))
