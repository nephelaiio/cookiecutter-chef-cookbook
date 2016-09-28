#!/usr/bin/env python
import sys
import os
import shutil
import subprocess
from cookiecutter.main import cookiecutter

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("A role name must be provided")
    else: 
        cwd = os.path.curdir
        cookbook_name=sys.argv[1]
        project_name="chef-cookbook-{0}".format(cookbook_name)
        shutil.rmtree(project_name, ignore_errors=True)
        cookiecutter(
                '.', 
                no_input=True, 
                overwrite_if_exists=True,
                extra_context={'cookbook_name': cookbook_name, 'project_name': project_name})
        os.chdir(project_name)
        prep = subprocess.call (["gem", "install", "bundler"])
        bundler = subprocess.call (["bundle", "install"])
        test = subprocess.call(["kitchen", "test"])
        if (test == 0):
            os.chdir(cwd)
            shutil.rmtree(project_name, ignore_errors=True)
        sys.exit(test)
