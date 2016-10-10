cookiecutter-chef-cookbook
==========================
[![Build Status](https://travis-ci.org/nephelaiio/cookiecutter-ansible-role.svg?branch=master)](https://travis-ci.org/nephelaiio/cookiecutter-ansible-role)

A cookiecutter to bootstrap chef cookbooks

Requirements
------------
There are no execution requirements other than cookiecutter.

Usage
-----
Generate a new Cookiecutter template layout: `cookiecutter gh:nephelaiio/cookiecutter-chef-cookbook`    

Testing
-------
For testing:
* Python [requirements](/requirements.txt) can be installed form the command line with: `pip install -r requirements.txt`    

You can find more information on test requirements [Travis](https://travis-ci.org) [configuration file](/.travis.yml) and the project [test script](/test.py)

In order to run tests on the command line, simply do `pytest -s`. You can find more information in the [Travis](https://travis-ci.org) [configuration file](/.travis.yml)

License
-------
This project is licensed under the terms of the [MIT License](/LICENSE)
