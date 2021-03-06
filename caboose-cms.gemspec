# Copyright 2013 William Barry
# 
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "caboose/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "caboose-cms"
  s.version     = Caboose::VERSION
  s.authors     = ["William Barry"]
  s.email       = ["william@nine.is"]
  s.homepage    = "http://github.com/williambarry007/caboose-cms"
  s.summary     = "CMS built on rails."
  s.description = "CMS built on rails with love."

  s.files = Dir["{app,bin,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]
  s.executables = ["caboose"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "underscore-rails"
  s.add_dependency "jquery-rails"
  s.add_dependency "jquery-ui-rails"
  #s.add_dependency "activesupport", "3.2.18"
  s.add_dependency "tinymce-rails"
  s.add_dependency "trollop"
  s.add_dependency "colorbox-rails"
  s.add_dependency "paperclip"
  s.add_dependency "awesome_print"
  s.add_dependency "ejs"
  s.add_dependency "httparty"
  
end
