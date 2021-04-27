FROM elixir:1.11.4

RUN apt-get update \
 && apt-get install -y inotify-tools

RUN groupadd -g 1000 service \
 && useradd -m -u 1000 -g 1000 -N service

WORKDIR /app

RUN chown -R service:service /app

USER service

RUN mix local.hex --force \
 && mix local.rebar --force \
 && mix archive.install hex phx_new 1.5.8 --force

CMD mix phx.server
