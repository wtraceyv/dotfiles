import os
import shutil
from datetime import datetime

'''
Copying files can lose the dates.
If you don't want to lose dates, make copies renamed with the dates.

NOTE: file type filtering in last if statement
'''

output_folder = "renamed"
os.makedirs(output_folder)

for root, dirs, files in os.walk('.'):
	total = 0
	for f in files:
		if ".m4a" in f: # note file type
			fulltime = str(datetime.fromtimestamp(os.path.getmtime(f))).split('.')[0].replace(' ', '-')
			new_file_name = output_folder + '/' + str(f).split('.')[0].replace(' ', '_') + '__' + fulltime + '.m4a'
			print("Copying {} to new file {}".format(f, new_file_name))
			total += 1
			# shutil.copy(f, new_file_name)
	print("-------------------")
	print("Copied {} files.".format(total))
