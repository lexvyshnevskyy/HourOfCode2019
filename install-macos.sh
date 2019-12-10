#!/usr/bin/env bash
sudo xcodebuild -license
sudo xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew unlink python
brew install --ignore-dependencies https://raw.githubusercontent.com/Homebrew/homebrew-core/f2a764ef944b1080be64bd88dca9a1d80130c558/Formula/python.rb
brew switch python 3.6.5_1
brew install cmake pkg-config
brew install jpeg libpng libtiff openexr
brew install eigen tbb
brew install wget

#
wget -O get-pip.py https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
rm get-pip.py
cd yolo-coco
wget https://pjreddie.com/media/files/yolov3.weights


cd ~
wget -O v4l-utils-1.18.0.tar.bz2 https://linuxtv.org/downloads/v4l-utils/v4l-utils-1.18.0.tar.bz2
tar xvfj v4l-utils-1.18.0.tar.bz2
cd v4l-utils-1.18.0
./configure
make
sudo make install
cd ~
rm v4l-utils-1.18.0.tar.bz2
sudo rm -r v4l-utils-1.18.0


brew install libpng
brew install jpeg-turbo

brew install libtiff

brew install ffmpeg libtool protobuf

cd ~
wget -O gstreamer-1.0-1.16.2-x86_64.pkg https://gstreamer.freedesktop.org/data/pkg/osx/1.16.2/gstreamer-1.0-1.16.2-x86_64.pkg
sudo installer -pkg gstreamer-1.0-1.16.2-x86_64.pkg -target /
rm gstreamer-1.0-1.16.2-x86_64.pkg

cd ~
brew install opencv3
