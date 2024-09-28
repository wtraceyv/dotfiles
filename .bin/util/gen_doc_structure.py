import os

'''
I am a man of habit.
Gen a nice doc structure to do a good organize.
Starts wherever the script is.
Long term and local storage.


'''

def gen_dirs(dir_list, write_path):
	for d in dir_list:
		os.makedirs(write_path + d)

# top-level
os.makedirs("Documents")
cur_write_path = "Documents/"

# 1 deep
gen_dirs(['Media', 'Professional', 'Admin'], cur_write_path)

# 2 deep
cur_write_path = "Documents/Media/"
gen_dirs(['Audio', 'Videos', 'Images', '3D', 'Books'], cur_write_path)

cur_write_path = "Documents/Professional/"
gen_dirs(['Resume', 'Pics', 'Taxes', 'Invoices', 'Brag'], cur_write_path)

cur_write_path = "Documents/Admin/"
gen_dirs(['School', 'Writing'], cur_write_path)

# 3 deep and beyond
cur_write_path = "Documents/Media/Books/"
gen_dirs(['Code', 'Other'], cur_write_path)

cur_write_path = "Documents/Media/Audio/"
gen_dirs(['Logic', 'Ardour', 'Project', 'Memos', 'Bounces'], cur_write_path)

cur_write_path = "Documents/Media/Images/"
gen_dirs(['Photo', 'Project', 'Digital', 'Scan'], cur_write_path)

cur_write_path = "Documents/Media/Images/Photo/"
gen_dirs(['Film', 'Digital'], cur_write_path)

cur_write_path = "Documents/Admin/Writing/"
gen_dirs(['Project'], cur_write_path)

cur_write_path = "Documents/Media/Videos/"
gen_dirs(['YouTube', 'Personal'], cur_write_path)

cur_write_path = "Documents/Media/Videos/YouTube/"
gen_dirs(['Covers', 'Djam', 'Original', 'Talk', 'Other'], cur_write_path)
