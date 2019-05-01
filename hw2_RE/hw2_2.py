import urllib.request
import re
import matplotlib.pyplot as plt
import pandas as pd
import math
def find_author(author_name):

	url = "https://arxiv.org/search/?query="+author_name+"&searchtype=all&abstracts=show&order=-announced_date_first&size=50&start=0"
	content = urllib.request.urlopen(url)
	html_str = content.read().decode('utf-8')
#to find howmany result
	pattern_page = 'class="title is-clearfix">[\s\S]*?results'
	result_page = re.findall(pattern_page,html_str)
	result_page = result_page[0].split("Showing")[1].split()[2]
	page_temp = result_page.replace(',','')
	result_page = int(math.ceil(int(page_temp)/50))
#list to store all number of year
	name_list=[]
	y=[]
	x=[]
	remove_index = 99
	for i in range(result_page):
		url = "https://arxiv.org/search/?query="+author_name+"&searchtype=all&abstracts=show&order=-announced_date_first&size=50&start="+str(i*50)
		content = urllib.request.urlopen(url)
		html_str = content.read().decode('utf-8')
		paper_pattern = 'class="search-hit">Authors:</span>[\s\S]*?</p>'
		paper_result = re.findall(paper_pattern,html_str)
		for pr in paper_result:
			name_pattern = '<a href=[\s\S]*?</a>'
			name_result = re.findall(name_pattern,pr)
			for nr in name_result:
				Get_author = nr.split('\">')[1].split('</a>')[0].strip()
				name_list.append(Get_author)
				
	result = pd.value_counts(name_list)
	ll = list(result.items())
	author_name_original=author_name.replace('+',' ')
#delete the author we find
	for i in range(len(ll)):
		if author_name_original in ll[i]:
			remove_index = i#to record which element need to be removed
	del ll[remove_index]
	ll.sort(key = lambda x:x[0])
	for t in ll:
		print('[ ' + t[0] + ' ]: ' + str(t[1]) + ' times')
	return
#Main function
Name = input('Enter the Name of Author : ');
Name_adjust = Name.replace(' ','+')
print("Input Author: [ " + Name + " ]")
find_author(Name_adjust)


