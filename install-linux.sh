#!/usr/bin/env bash
sudo apt-get install python3-dev python3-numpy\
wget https://bootstrap.pypa.io/get-pip.py
sudo python3 get-pip.py
sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev
sudo apt-get install libgtk2.0-dev
sudo apt-get install libgtk-3-dev

sudo apt-get install libpng-dev
sudo apt-get install libjpeg-dev
sudo apt-get install libopenexr-dev
sudo apt-get install libtiff-dev
sudo apt-get install libwebp-dev
###### only if youll use CUDA
##sudo apt install nvidia-cuda-toolkit
##sudo apt install nvidia-cuda-dev
sudo apt-get install libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio
sudo apt install ubuntu-restricted-extras ffmpeg v4l-utils
cd yolo-coco
wget https://pjreddie.com/media/files/yolov3.weights

cd ~
wget https://linuxtv.org/downloads/v4l-utils/v4l-utils-1.18.0.tar.bz2
tar xvfj v4l-utils-1.18.0.tar.bz2
cd v4l-utils-1.18.0
./configure
make
sudo make install

cd ~
##
sudo rm -r opencv-3.4.4/
sudo rm -r opencv_contrib-3.4.4
unzip opencv-contrib.zip && unzip -q opencv.zip && cd opencv-3.4.4/ && mkdir build && cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
-D CMAKE_INSTALL_PREFIX=/usr/local \
-D INSTALL_PYTHON_EXAMPLES=ON \
-D INSTALL_C_EXAMPLES=OFF \
-D PYTHON_EXECUTABLE=$(which python3) \
-D BUILD_opencv_python2=OFF \
-D CMAKE_INSTALL_PREFIX=$(python3 -c "import sys; print(sys.prefix)") \
-D PYTHON3_EXECUTABLE=$(which python3) \
-D PYTHON3_INCLUDE_DIR=$(python3 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
-D PYTHON3_PACKAGES_PATH=$(python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
-D WITH_GSTREAMER=ON \
-D BUILD_EXAMPLES=ON ..

make -j$(nproc)
sudo make install
sudo mkdir /usr/local/lib/$(python3 -c "import sys;print(''.join(str(x) for x in ['python-',sys.version_info.major,'.',sys.version_info.minor]))")/site-packages
sudo rm /usr/local/lib/$(python3 -c "import sys;print(''.join(str(x) for x in ['python',sys.version_info.major,'.',sys.version_info.minor]))")/dist-packages/cv2.so
sudo ln -s $(ls /usr/local/python/cv2/$(python3 -c "import sys;print(''.join(str(x) for x in ['python-',sys.version_info.major,'.',sys.version_info.minor]))")/cv*$(gcc -dumpmachine).so) /usr/local/lib/$(python3 -c "import sys;print(''.join(str(x) for x in ['python',sys.version_info.major,'.',sys.version_info.minor]))")/dist-packages/cv2.so
sudo ldconfig

