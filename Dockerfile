FROM pynguins/pyracms_core AS pyracms

FROM pynguins/pyracms_article AS article
COPY --from=pyracms /code/pyracms/dist/ /code/
COPY --from=pyracms /code/pyracms/*.ini /code/pyracms/

FROM pynguins/pyracms_forum AS forum
COPY --from=article /code/article/dist/ /code/

FROM pynguins/pyracms_gallery AS gallery
COPY --from=forum /code/forum/dist/ /code/

FROM pynguins/pyracms_pycode AS pycode
COPY --from=gallery /code/gallery/dist/ /code/

WORKDIR /code/
RUN find -maxdepth 1 -type f -name '*.whl' -exec pip install {} \;

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