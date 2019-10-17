import pdb

class Config(pdb.DefaultConfig):
    current_line_color = 40
    bg = 'light'

import sys
if sys.version_info < (3,0):
    reload(sys)
    sys.setdefaultencoding("utf-8")
