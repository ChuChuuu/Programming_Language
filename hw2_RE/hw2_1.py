import urllib.request
import re
import matplotlib.pyplot as plt
import pandas as pd
import math
def find_year(author_name):

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
	year_list=[]
	y=[]
	x=[]
	for i in range(result_page):
		url = "https://arxiv.org/search/?query="+author_name+"&searchtype=all&abstracts=show&order=-announced_date_first&size=50&start="+str(i*50)
		content = urllib.request.urlopen(url)
		html_str = content.read().decode('utf-8')
		pattern = 'originally announced</span> [\s\S]*?</p>'
		result = re.findall(pattern,html_str)
		for r in result:
			year = r.split("originally announced</span>")[1].split(".")[0].strip()
			year = year.split()[1]
			year_list.append(int(year))
		result = pd.value_counts(year_list)
		ll = list(result.items())
		ll.sort(key=lambda x:x[0])
	for t in ll:
		y.append(t[1])
		x.append(str(t[0]))
#	print(x)
#	print(y)
	plt.bar(x,y)
	plt.show()

	return
#Main function
Name = input('Enter the Name of Author : ');
Name_adjust = Name.replace(' ','+')
print("Input Author: [ " + Name + " ]")
find_year(Name_adjust)

	
