FROM ruby:2.5.0
MAINTAINER Admin rememberthatk@icloud.com

ENV RAILS_ROOT /root/best_config
ENV RAILS_ENV production
ENV RAKE_ENV production

WORKDIR $RAILS_ROOT

RUN apt-get update \
  && apt-get -y install nodejs \
                        postgresql-client \
                        vim tmux git curl less ctags \
                        locales locales-all \
                        --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*

RUN gem install rails rubocop gem-ctags brakeman
RUN mkdir -p ~/.cache/dein \
  && cd ~/.cache/dein \
  && curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh \
  && sh ./installer.sh ~/.cache/dein
RUN git clone https://github.com/DialBird/docker_dotfiles.git

# Adding gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install --jobs 20 --retry 5 --without development test

# Adding project files
COPY . .
RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
