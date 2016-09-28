import pytest
import sys
import os
import shutil
from subprocess import call
from cookiecutter.main import cookiecutter


cookbook_setup_commands = ['gem install bundler', 'bundle install']
cookbook_setup_success = 0
cookbook_test_command = "kitchen test"
cookbook_test_success = 0


@pytest.mark.parametrize('cookbook_name', ['tree'])
def test_cookbook_name(cookbook_name):
    last_dir = os.path.curdir
    project_name="chef-cookbook-{0}".format(cookbook_name)
    test_dir = project_name
    try:
        shutil.rmtree(test_dir, ignore_errors=True)
        cookiecutter(
            '.', 
            no_input=True, 
            overwrite_if_exists=True,
            extra_context={'cookbook_name': cookbook_name, 'project_name': project_name})
        os.chdir(test_dir)
        for command in cookbook_setup_commands:
            assert call (command.split()) == cookbook_setup_success
        assert call(cookbook_test_command.split()) == cookbook_test_success
    finally:
        os.chdir(last_dir)
        shutil.rmtree(test_dir, ignore_errors=True)
