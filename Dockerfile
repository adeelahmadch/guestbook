FROM ruby:2.2.5

ENV REDIS_HOST=172.25.0.11
ENV DATABASE_URL="postgres://devops:rbdc9vtrc8@172.25.0.10/guestbook"

ADD . /mypass
ADD ./entry-point.sh /usr/bin/
RUN chmod 755 /usr/bin/entry-point.sh
WORKDIR /mypass
RUN bundle install

ENTRYPOINT ["entry-point.sh"]

