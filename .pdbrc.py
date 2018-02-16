import pdb
 
class Config(pdb.DefaultConfig):
    current_line_color = 40
    bg = 'light'

import sys
reload(sys)
sys.setdefaultencoding("utf-8")
