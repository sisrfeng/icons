if "wf_package":
    import os       ; wf_home = os.path.expanduser("~/")
    import sys      ; sys.path.append(wf_home)
    import warnings ; warnings.filterwarnings("ignore")
    from  dotF.leo_common.leo_base   import *


# -*- coding: utf-8 -*-
# vim:se fenc=utf8 noet:
from __future__ import (unicode_literals, division, absolute_import, print_function)

try:
	import vim
except ImportError:
	vim = {}

from powerline.bindings.vim import (vim_get_func, buffer_name)
from powerline.theme import requires_segment_info

@requires_segment_info
def icon_wf(pl, segment_info):
	icon_wf = vim_get_func('File_Icon')
	name = buffer_name(segment_info)
	return [] if not icon_wf else [{
		'contents': icon_wf(name),
		'highlight_groups': ['icon_wf', 'file_name'],
		}]

@requires_segment_info
def icon_wf_file_format(pl, segment_info):
	icon_wf_file_format = vim_get_func('WebDevIconsGetFileFormatSymbol')
	return [] if not icon_wf_file_format else [{
		'contents': icon_wf_file_format(),
		'highlight_groups': ['icon_wf_file_format', 'file_format'],
		}]
