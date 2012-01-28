import sys, os, re
import subprocess, getpass
from os.path import join as jp

from dk.hlyh.hudson.tools.jobcreator import Arguments
from dk.hlyh.hudson.tools.jobcreator import Program
from hudson.cli import CLI

import java.io

here = os.path.dirname(os.path.abspath(__file__))

def _communicate(cmd, subprocess):
    stdout, stderr = subprocess.communicate()
    if subprocess.returncode:
	print >>sys.stderr, "*-*-*- ERROR", str(subprocess.returncode), "calling hudson"
	print >>sys.stderr, stderr

def login(url, username, password):
    
    p = subprocess.Popen(["java", "-jar", "../lib/hudson-cli.jar", "-s", url, "login", "--username", username, "--password", password],
                         stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=False)
    _communicate("login", p)

def update_job(url, job_name):

    xml = open("../target/"+job_name+"/config.xml", 'r')
    p = subprocess.Popen(["java", "-jar", "../lib/hudson-cli.jar", "-s", url, "update-job", job_name, "true"],
                         stdin=xml, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=False)
    _communicate("update job '" + job_name + "'", p)


if __name__ == "__main__":
  group = sys.argv[1]
  url = sys.argv[2]
  user = sys.argv[3]
  password = sys.argv[4]

  print "Group " + group
  print "URL " + url
  print "User " + user
  print "Password " + password

  
  args = Arguments()
  args.setInput(java.io.File("../pipeline.xml"))
  args.setTemplateDirectory(java.io.File("../templates"))
  args.setTemplateDirectory(java.io.File("../templates"))
  args.setOutputDirectory(java.io.File("../target"))
  args.setGroup(group)

  jobsloaded = Program.run(args)
  login(url,user,password)

  for job in jobsloaded:
    print "Loading: " +job
    update_job(url,job)


