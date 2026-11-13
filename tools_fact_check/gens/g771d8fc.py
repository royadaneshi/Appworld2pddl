from ed import *
cfg={'771d8fc_1':('number-3654328626','text-from','voice-from','text-deleted','voice-deleted'),'771d8fc_2':('number-9294880327','from-number','from-number','deleted','deleted'),'771d8fc_3':('number-5708520672','text-from','voice-from','text-deleted','voice-deleted')}
for t,(num,tf,vf,td,vd) in cfg.items():
    pv=private(t); T=sorted(pv['to_delete_text_message_ids']); V=sorted(pv['to_delete_voice_message_ids'])
    to=[f'text-msg-{i}' for i in T]; vo=[f'voice-msg-{i}' for i in V]
    set_objects(t,'text-message',to); set_objects(t,'voice-message',vo)
    keep=keep_init(t,r'username-for|password-for|spam-number|phone-number-of')
    set_section(t,'problem.pddl',':init',keep+[f'({tf} {o} {num})' for o in to]+[f'({vf} {o} {num})' for o in vo])
    set_section(t,'problem.pddl',':goal',[f'({td} {o})' for o in to]+[f'({vd} {o})' for o in vo]+['(task-completed)'],wrap_and=True)
    b=json.loads((awcheck.task_dir(t)/'bindings.json').read_text()); drop=[x['object'] for x in b if x.get('from_api') in ('phone.search_text_messages','phone.search_voice_messages')]
    n=num.split('-')[1]
    binds(t,drop=drop,add=[(o,None,'phone.search_text_messages',f'text_message_id {i}: one of the {len(T)} text messages exchanged with {n} (iterate all pages)') for o,i in zip(to,T)]+[(o,None,'phone.search_voice_messages',f'voice_message_id {i}: one of the {len(V)} voice messages exchanged with {n} (iterate all pages)') for o,i in zip(vo,V)])
    print(t,len(T),len(V))
