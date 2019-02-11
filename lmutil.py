import shlex
import subprocess
import os

class Env(object):

    def __init__(self, init=False):
        self.db = {}
        self.fn = os.environ['LM_ENV']
        if init:
            open(self.fn, 'w').write('')
        self.load()

    def __setattr__(self, var, val):
        self.set(var, val)

    def __getattr__(self, var):
        return os.environ[var]

    def set(self, var, val):
        self.db[var] = val
        os.environ[var] = val

    def load(self):
        for line in open(self.fn, 'r').readlines():
            line = line.strip()
            if not len(line):
                continue
            var, val = line.split('=', maxsplit=1)
            self.set(var, val)

    def save(self):
        fh = open(self.fn, 'w')
        for var, val in self.db.items():
            fh.write('%s=%s\n' % (var, val))
        fh.close()

def make(flags, targets):
    cmd = ['make'] + flags + targets
    cmd = ' '.join(cmd)
    logging.info(cmd)
    subprocess.run(cmd, shell=True, check=True)

# https://bugs.python.org/issue22454
def shlex_join(args):
    return ' '.join(shlex.quote(x) for x in args)

def sh(cmd):
    # XXX implement noop here?  with a param?)
    if type(cmd) == str:
        cmd = shlex.split(cmd)
    # XXX logging or stderr?
    print(shlex_join(cmd))
    out = subprocess.check_output(cmd)
    out = out.decode().strip()
    return out
