FROM pynguins/pyracms_core AS pyracms

FROM pynguins/pyracms_article AS article
COPY --from=pyracms /code/ /code/
COPY --from=pyracms /usr/local/ /usr/local/

FROM pynguins/pyracms_forum AS forum
COPY --from=article /code/ /code/
COPY --from=article /usr/local/ /usr/local/

FROM pynguins/pyracms_gallery AS gallery
COPY --from=forum /code/ /code/
COPY --from=forum /usr/local/ /usr/local/

FROM pynguins/pyracms_pycode AS pycode
COPY --from=gallery /code/ /code/
COPY --from=gallery /usr/local/ /usr/local/

WORKDIR /code/pyracms
RUN python setup.py install
WORKDIR /code/article
RUN python setup.py install
WORKDIR /code/forum
RUN python setup.py install
WORKDIR /code/gallery
RUN python setup.py install
WORKDIR /code/pycode
RUN python setup.py install

WORKDIR /code/pyracms
RUN initialize_pyracms_db production_all.ini
RUN initialize_pyracms_article_db production_all.ini
RUN initialize_pyracms_forum_db production_all.ini
RUN initialize_pyracms_gallery_db production_all.ini
RUN initialize_pyracms_pycode_db production_all.ini

RUN apt-get clean

EXPOSE 6543/tcp

ENTRYPOINT [ "pserve" ]
CMD [ "production_all.ini" ]