FROM debian:7.3

# Enable i386 multiarch
RUN dpkg --add-architecture i386
RUN apt-get update -q
RUN apt-get upgrade -qy

# Install 32 bits libs
RUN apt-get install -qy ia32-libs

# Install spksrc's required packages
RUN apt-get install -qy build-essential debootstrap python-pip automake libgmp3-dev libltdl-dev libunistring-dev libffi-dev ncurses-dev imagemagick libssl-dev pkg-config zlib1g-dev gettext git curl subversion check libboost1.49-dev intltool gperf flex bison xmlto php5 expect libgc-dev mercurial cython nano vim
RUN pip install -U pip

# Install spksrc to /spksrc
RUN git clone https://github.com/SynoCommunity/spksrc.git /spksrc/
RUN cd /spksrc/; make setup

# Install all toolchains
RUN cd /spksrc/toolchains/; for i in *; do cd $i; make; cd ..; done

# Volume pointing to spksrc sources
VOLUME /spksrc
