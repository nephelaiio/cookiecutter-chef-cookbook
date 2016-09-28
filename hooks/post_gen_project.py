# -*- coding: utf-8 -*-
import os
import re
import sys
import shutil
import errno


def fix_template_expansion(content, replacements):
    """
    fix template expansion after hook copy
    :param content: the duplicated hook content
    :param replacements: array of dictionaries
                         cookiecutter_key => template key expanded
    """
    for replacement in replacements:
        for key, to_be_replaced in replacement.items():
            replacement = chr(123) + chr(123) + \
                'cookiecutter.' + key + chr(125) + chr(125)
            content = content.replace(to_be_replaced, replacement)
    return content

def fetch_file_content(url):
    """
    get the content of a given url
    :param url: the url to get the content from
    """
    if (sys.version_info > (3, 0)):
        import urllib.request
        response = urllib.request.urlopen('http://python.org/')
    else:
        import urllib
        response = urllib.urlopen('http://python.org/')
    return(response.read())

def get_file_content(file):
    """
    get the content of a given file
    :param file: the file to get the content of
    """
    return open(file, 'r').read()

def set_file_content(file, content):
    """
    write content to file
    :param file: the file to rewrite its content
    :param content: content to write to the given file
    """
    return open(file, 'w').write(content)

# format title of the generated readme file
readme = os.getcwd() + '/README.md'
if (os.path.exists(readme)):
    title_underliner = ''.center(len('{{cookiecutter.project_name}}'), '=')
    set_file_content(
        readme,
        re.sub(
            r'^=+$', title_underliner, get_file_content(readme), 1, flags=re.M
        )
    )
# end format title of the generated readme file

# issue #3 - copy post hook to project directory
if (re.match(r'YES', '{{cookiecutter.copy_hooks}}', re.I)):
    if (re.match(r'^cookiecutter\-', '{{cookiecutter.project_slug}}')):
        hooksdir = os.getcwd() + '/hooks'
        posthook = hooksdir + '/post_gen_project.py'
        source = os.path.realpath(__file__)
        replacements = [
            {'project_slug': '{{cookiecutter.project_slug}}'},
            {'copy_hooks': '{{cookiecutter.copy_hooks}}'},

            # project_name must be set after project_slug to prevent side
            # effects
            {'project_name': '{{cookiecutter.project_name}}'}
        ]

        if (not os.path.exists(hooksdir)):
            os.makedirs(hooksdir)
        shutil.copyfile(source, posthook)

        set_file_content(
            posthook,
            fix_template_expansion(
                get_file_content(posthook), replacements
            ) + "\n"
        )
# end issue #3

PROJECT_DIRECTORY = os.path.realpath(os.path.curdir)
LICENSE_DIRECTORY = os.path.join(PROJECT_DIRECTORY, 'licenses')

if __name__ == '__main__':
	# configure selected license file and remove all other alternatives
	shutil.move(
		os.path.join(LICENSE_DIRECTORY, '{{ cookiecutter.license }}'),
		os.path.join(PROJECT_DIRECTORY, 'LICENSE'))
	shutil.rmtree(LICENSE_DIRECTORY)