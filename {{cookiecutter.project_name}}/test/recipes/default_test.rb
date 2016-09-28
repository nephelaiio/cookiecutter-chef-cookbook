# # encoding: utf-8

# Inspec test for recipe project_name::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

[node.package.names].flatten.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end

  describe command("#{pkg} --version") do
    its('exit_status') { should eq 0 }
  end
end
