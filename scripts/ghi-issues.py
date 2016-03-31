#!/usr/bin/env python3

#########################################################
# ghi-issues.py - Python 3 utility for browsing GitHub  #
#   issues offline.  Runs ghi list to view open tickets #
#   then runs ghi show on each ticket, logging the      #
#   output to file in the issues folder of the current  #
#   working directory.                                  #
#                                                       #
# Author: Kenneth P. J. Dyer                            #
# Version: 0.1                                          #
#                                                       #
# Date: April 2016                                      #
#########################################################

# Module Imports
import subprocess
import argparse
import os
import os.path
import re



# Get Issue
def get_issue(number):
    
    text = subprocess.check_output(['ghi', 'show', number])
    return text.decode()

# Parse Issues
def parse_issues(issues_b):

    data = {}

    issues = issues_b.split(b'\n')
    for i in issues:
        iss = i.decode()

        if re.match('^#', iss) == None:
            match = '^. [ 1234567890]*. '
            title = re.split(match, iss)
            
            if len(title) > 1:
                title = title[1]

                issue_no = ''.join(re.findall(match, iss)).strip()
                
                data[issue_no] = {
                    "title": title,
                    "report": get_issue(issue_no)
                }


                
    return data
            
    

# Main Process
def main(args):

    # Open Remote Directory
    cwd = os.getcwd()
    repo = os.path.abspath(args.repo)
    os.chdir(repo)

    # Find Open Issues on GitHub
    issues_list = subprocess.check_output(['ghi', 'list'])

    issues_dict = parse_issues(issues_list)

    
    # Return to Working Directory
    os.chdir(cwd)


    if not os.path.exists(args.output):
        os.mkdir(args.output)

    os.chdir(args.output)

    # Create Files
    for key in issues_dict:
        print("Creating: %s\n" % issues_dict[key]["title"])
        f = open('Issue%s.txt' % key, 'w')
        f.write(issues_dict[key]["report"])
        f.close()
        
    os.chdir(cwd)

    
# Initiate Main Process
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-r','--repo')
    parser.add_argument('-o','--output', default='issues')
    parser.add_argument('-u', '--user')
    

    args = parser.parse_args()
    main(args)






