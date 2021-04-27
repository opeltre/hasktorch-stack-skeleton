# replace with upstream url
repo="https://raw.githubusercontent.com/opeltre/hasktorch-stack-skeleton/libtorch-path"

# check for LIBTORCH_PATH: 
[[ -n $1 ]] && libtorch=$1 || libtorch=$LIBTORCH_PATH

# exit if no path given
if [[ -z $libtorch ]]; then
    echo "No LIBTORCH_PATH, exiting."
    echo "Usage: ./stack-init.sh /path/to/libtorch"
    exit
fi

# exit if *.yaml files exist
if [[ -f "stack.yaml" || -f "package.yaml" ]]; then
    echo "Will not remove *.yaml, exiting."
    echo "Delete them or copy-paste relevant bits from:"
    echo "https://github.com/hasktorch/hasktorch-stack-skeleton"
    exit
fi

# generate stack configuration

echo "Fetching stack.yaml and package.yaml:" 
echo "-> libtorch path = $libtorch" 
echo ""

sub1="s@\$LIBTORCH_PATH@${libtorch}@g"

curl -L $repo/stack.yaml.template | sed $sub1 > stack.yaml
curl -L $repo/package.yaml > package.yaml
