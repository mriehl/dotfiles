from __future__ import print_function

try:
    import readline
except ImportError:
    pass
else:
    import rlcompleter
    readline.parse_and_bind("tab: complete")

import inspect


def what(stuff):
    for k, v in inspect.getmembers(stuff):
        print("* %s" % k)
        for line in str(v).splitlines():
            print("\t%s" % line)
