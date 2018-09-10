import os
import json

$SIMPLEJUMP_FILE = $SIMPLEJUMP_FILE if 'SIMPLEJUMP_FILE' in ${...} else os.path.expanduser('~/.simplejump')

def simplejump_dict():
    if not os.path.exists($SIMPLEJUMP_FILE):
        return dict()

    with open($SIMPLEJUMP_FILE) as r:
        try:
            return json.load(r)
        except json.decoder.JSONDecodeError:
            return dict()


@events.on_chdir
def simplejump_dirs(olddir, newdir):
    $SIMPLEJUMP_DICT[os.path.basename(newdir).lower()] = newdir


@events.on_exit
def jumpsave():
    # merge disk and memory dict
    simpledict = $SIMPLEJUMP_DICT
    simpledict.update(simplejump_dict())

    with open($SIMPLEJUMP_FILE, 'w') as w:
        json.dump(simpledict, w, indent=4, sort_keys=True)


@events.on_post_init
def simplejump_load():
    $SIMPLEJUMP_DICT = simplejump_dict()


def simplejump(args, stdin, stdout, stderr):
    if len(args) == 0:
        stderr.write('simplejump expects 1 argument')
        return 0

    pwd = $PWD
    to = args[0].lower()

    if to in $SIMPLEJUMP_DICT:
        pwd = $SIMPLEJUMP_DICT[to]
    else:
        for base in sorted($SIMPLEJUMP_DICT, key=len):
            if to in base:
                pwd = $SIMPLEJUMP_DICT[base]
                break

    ![cd @(pwd)]


def simplejump_completer(prefix, line, begidx, endidx, ctx):
    args = line.split()

    if len(args) == 0:
        return None

    cmd = args[0].lower()

    if cmd == 'simplejump' or aliases.get(cmd) == simplejump:
        return {base for base in $SIMPLEJUMP_DICT if prefix in base}

    return None


aliases['simplejump'] = simplejump

__xonsh_completers__['simplejump'] = simplejump_completer
__xonsh_completers__.move_to_end('simplejump', last=False)
