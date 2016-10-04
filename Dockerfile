FROM ubuntu:14.04

MAINTAINER Piotr Pradzynski <prondzyn@gmail.com>

ENV HOME=/root
ARG RUBY_VERSION=1.9.3-p0

WORKDIR $HOME

RUN echo "Europe/Warsaw" | tee /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y git make gcc curl build-essential zlib1g-dev libreadline-dev libssl-dev libcurl4-openssl-dev

RUN git clone git://github.com/sstephenson/rbenv.git $HOME/.rbenv

RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

ENV PATH="$HOME/.rbenv/bin:$PATH"
RUN rbenv init -
# setting up language and encoding to help Ruby handling various weird characters
ENV LANG=en_US.UTF-8

RUN git clone git://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

VOLUME $HOME/octopress

WORKDIR octopress

RUN rbenv install $RUBY_VERSION
RUN rbenv local $RUBY_VERSION

ENV PATH="$HOME/.rbenv/versions/$RUBY_VERSION/bin:$PATH"

ADD https://raw.githubusercontent.com/TorunJUG/TorunJUG.github.io/source/Gemfile .
ADD https://raw.githubusercontent.com/TorunJUG/TorunJUG.github.io/source/Gemfile.lock .

RUN rbenv rehash
RUN gem install bundler

RUN rbenv rehash
RUN bundle install

RUN echo "alias x=exit" >> $HOME/.bashrc
RUN echo "alias preview='cd $HOME/octopress; rake preview'" >> $HOME/.bashrc
RUN echo "alias generate='cd $HOME/octopress; rake generate'" >> $HOME/.bashrc
RUN echo "alias deploy='cd $HOME/octopress; rake deploy'" >> $HOME/.bashrc