# Zego API documentation (Slate)


## Prerequisites

You're going to need:

 - **Linux or OS X** — Windows may work, but is unsupported.
 - **Ruby, version 2.3.1 or newer**
 - **Bundler**
 - **node**


## Local Setup and Deploy

```

git clone git@github.com:Zegocover/documentation.git
cd documentation
make build-image
make run

# Update files in ./source to make your changes
vim source/index.html.md


# Deploy
eval $(zego-aws-login zego-production developer)
make deploy

```
