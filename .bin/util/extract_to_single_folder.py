import os
import shutil

move_to = '../extract/'

for root, dirs, files in os.walk('.'):
	for d in dirs:
		for root, dirs, files in os.walk(d):
			for f in files:
				if '._' not in f:
					fpath = d + "/" + f
					print(fpath)
					print(move_to + f)
					# shutil.copy(fpath, move_to + f)
