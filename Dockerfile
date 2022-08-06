FROM ubuntu

RUN apt-get update && apt-get -y install sudo gcc build-essential procps curl file git nodejs

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

WORKDIR /root/.dotfiles
COPY . ./

