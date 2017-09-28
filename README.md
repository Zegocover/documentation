Zego API documentation (Slate)


### Prerequisites

You're going to need:

 - **Linux or OS X** — Windows may work, but is unsupported.
 - **Ruby, version 2.3.1 or newer**
 - **Bundler** — If Ruby is already installed, but the `bundle` command doesn't work, just run `gem install bundler` in a terminal.


### Local Setup and Deploy

```

git clone git@github.com:Zegocover/documentation.git
cd documentation

# We'll use Ruby Version Manager for this (https://rvm.io/; http://cheat.errtheblog.com/s/rvm)
curl -L get.rvm.io | bash -s stable
source ~/rvm.sh  #Run this or add it to your .bashrc file


# We'll also need node (installed here using nvm)
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.4/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm install node

# We now install the latest version of ruby
rvm install ruby-head

# Install package manager
gem install bundler

# Install slate dependencies
bundle install

# Star the development server
bundle exec middleman server

# Update files in ./source to make your changes
vim source/index.html.md


# Deploy
bundle exec middleman build --clean
eval $(zego-aws-login zego-production developer)
aws s3 sync ./build s3://developer.zegocover.com


```
