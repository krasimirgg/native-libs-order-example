FROM ubuntu:focal

RUN apt-get update && apt-get install -y \
  build-essential \
  curl \
  lld
RUN apt-get update

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

RUN rustup install nightly-2022-05-02
RUN rustup update

WORKDIR /example
ADD bar.rs foo.cc libbar.rlib main.rs run.sh /example/

RUN ./run.sh
