FROM python:latest
EXPOSE 6543/tcp
COPY --from=pynguins/pyracms_core / /
COPY --from=pynguins/pyracms_article / /
COPY --from=pynguins/pyracms_forum / /
COPY --from=pynguins/pyracms_gallery / /
COPY --from=pynguins/pyracms_pycode / /
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
RUN initialize_pyracms_db production.ini
RUN initialize_pyracms_article_db production.ini
RUN initialize_pyracms_forum_db production.ini
RUN initialize_pyracms_gallery_db production.ini
RUN initialize_pyracms_pycode_db production.ini
# ENTRYPOINT [ "pserve" ]
# CMD [ "production.ini" ]