    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> /home/abraxas/.profile
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/abraxas/.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    sudo apt-get install build-essential
    brew install gcc
