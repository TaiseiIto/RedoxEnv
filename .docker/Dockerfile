# This is Dockerfile to make development environment.

FROM ubuntu

# A name of branch of the repository.
ARG branch

# Don't ask stdin for anithing to install softwares automatically.
ENV DEBIAN_FRONTEND=noninteractive

# Install softwares.
RUN apt update

# Install basic development systems.
RUN apt install build-essential -y

# Install clang
RUN apt install clang -y
RUN apt install lld -y
RUN apt install lldb -y
RUN apt install llvm -y

# Install data transmission system.
RUN apt install curl -y

# Install a version control system.
RUN apt install git -y
RUN apt install git-email -y
RUN git config --global pull.rebase false
RUN mkdir /root/.ssh
RUN mkdir /root/.github

# Install Rust.
RUN curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y
RUN mkdir /root/.crates.io
ENV PATH=$PATH:/root/.cargo/bin

# Install a terminal multiplexer.
RUN apt install tmux -y

# Set timezone to Japan.
RUN apt install tzdata -y
RUN cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Install an editor.
RUN apt install vim -y

# Clone this repository.
WORKDIR /root
RUN git clone --single-branch --branch $branch --depth 1 --recursive --shallow-submodules https://github.com/TaiseiIto/RedoxEnv.git

# Install qemu.
RUN apt install libglib2.0-dev -y
RUN apt install libpixman-1-dev -y
RUN apt install ninja-build -y
RUN apt install pkg-config -y
WORKDIR /root/RedoxEnv/qemu
RUN ./configure --target-list=x86_64-softmmu CFLAGS="-O0 -g -fno-inline" CXXFLAGS="-O0 -g -fno-inline"
RUN make
RUN make install

# Build Redox.
RUN apt install nasm -y
RUN apt install libfuse-dev -y
RUN apt install wget -y
RUN apt install autopoint -y
RUN apt install autoconf -y
RUN apt install libtool -y
RUN apt install po4a -y
RUN apt install rsync -y
RUN apt install texinfo -y
RUN apt install bison -y
RUN apt install flex -y
RUN apt install gperf -y
RUN apt install libpng-dev -y
RUN apt install fuse -y
RUN cargo install --force --version 0.1.1 cargo-config

# Install GDB.
WORKDIR /root/RedoxEnv/gdb
RUN apt install libgmp-dev -y
RUN apt install dejagnu -y
RUN apt install libexpat-dev -y
RUN apt install iasl -y
RUN apt install libmpfr-dev -y
RUN ./configure --with-expat CFLAGS="-O0 -g -fno-inline" CXXFLAGS="-O0 -g -fno-inline"
RUN make
RUN make install
RUN cp /root/RedoxEnv/.gdb/.conf /root/.gdbinit

# bash settings.
WORKDIR /root/RedoxEnv
RUN cat .bash/.bashrc >> /root/.bashrc

# tmux settings.
RUN cat .tmux/.tmux.conf >> /root/.tmux.conf

# vim settings.
RUN cat .vim/.vimrc >> /root/.vimrc

# VNC port
EXPOSE 5900

