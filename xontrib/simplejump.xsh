import os
import json

$SIMPLEJUMP_FILE = $SIMPLEJUMP_FILE if 'SIMPLEJUMP_FILE' in ${...} else os.path.expanduser('~/.simplejump')

@events.on_chdir
def jumpdirs(olddir, newdir):
    $SIMPLEJUMP_DICT[os.path.basename(newdir).lower()] = newdir


@events.on_exit
def jumpsave():
    with open($SIMPLEJUMP_FILE, 'w') as w:
        json.dump($SIMPLEJUMP_DICT, w, indent=4, sort_keys=True)


@events.on_post_init
def jumpload():
    if os.path.exists($SIMPLEJUMP_FILE):
        with open($SIMPLEJUMP_FILE) as r:
            try:
                $SIMPLEJUMP_DICT = json.load(r)
            except json.decoder.JSONDecodeError:
                $SIMPLEJUMP_DICT = dict()
    else:
        $SIMPLEJUMP_DICT = dict()


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
