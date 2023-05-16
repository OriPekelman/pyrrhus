if [ -z ${YOLO} ]
then
  ##
  # This is a joke. Please don't run this. None of the below commands is
  # willfully harmful; all have been copy and pasted from somewhere reputable on
  # the interwebs, but this is a very bad idea. A very bad one. 
  #
  # Personally, I did not try to run this, and I never will.
  ##
  echo "Congratulations. You are an adult; or lucky, or you don't know how to set an environment variable. Which all considering, is good. Because you should really not be running this."
else
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  softwareupdate -i $(softwareupdate -l | grep "\*.*Command Line" | grep $(sw_vers -productVersion) | awk -F"*" '{print $2}' | sed -e 's/^ *//' | tr -d '\n') --verbose
  gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  curl -s https://i.jpillora.com/installer | bash
  base=https://github.com/docker/machine/releases/download/v0.16.0 && curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/usr/local/bin/docker-machine && chmod +x /usr/local/bin/docker-machine
  curl -sf -L https://static.rust-lang.org/rustup.sh | sh
  curl -sSL https://get.rvm.io | sh
  curl -O https://storage.googleapis.com/golang/getgo/installer_darwin && chmod +x installer_darwin && ./installer_darwin
  curl "https://nodejs.org/dist/latest/node-${VERSION:-$(wget -qO- https://nodejs.org/dist/latest/ | sed -nE 's|.*>node-(.*)\.pkg</a>.*|\1|p')}.pkg" > "$HOME/Downloads/node-latest.pkg" &&  installer -store -pkg "$HOME/Downloads/node-latest.pkg" -target "/"
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64  && chmod +x minikube
  wget -O kubedb https://github.com/kubedb/cli/releases/download/0.8.0-beta.2/kubedb-darwin-amd64  && chmod +x kubedb   &&  mv kubedb /usr/local/bin/
  rm /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
  git clone https://github.com/fredi-python/llama.cpp.git && cd llama.cpp && make -j && cd models && wget -c https://huggingface.co/eachadea/ggml-vicuna-13b-1.1/resolve/main/ggml-vic13b-uncensored-q5_1.bin
fi
