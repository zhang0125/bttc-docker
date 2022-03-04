# Re-use our github folder
mkdir -p ~/github
cd ~/github

# Clone the repo
git clone https://github.com/bttcprotocol/bttc.git
cd bttc

# This is the current recommended version
git checkout v1.0.1

# Build the docker image
docker build --tag bttc:v1.0.1 .

#---------------------delivery---------------------

cd ~/github
# Clone the repo
git clone https://github.com/bttcprotocol/delivery.git
cd delivery

# Checkout the mainnet release version
git checkout v1.0.0

# Copy the Dockerfile up a directory
cp docker/Dockerfile .

# Build the docker image
docker build --tag delivery:v1.0.0 .

