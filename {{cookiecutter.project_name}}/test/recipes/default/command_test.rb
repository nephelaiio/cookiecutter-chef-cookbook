# # encoding: utf-8

# Inspec test for recipe project_name::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe command("{{ cookiecutter.cookbook_name }} -v") do
  its('exit_status') { should eq 0 }
end
