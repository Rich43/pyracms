FROM python:latest
WORKDIR /code
COPY --from=pynguins/pyracms_core /code/ /code/
COPY --from=pynguins/pyracms_article /code/ /code/
COPY --from=pynguins/pyracms_forum /code/ /code/
COPY --from=pynguins/pyracms_gallery /code/ /code/
COPY --from=pynguins/pyracms_pycode /code/ /code/
COPY --from=pynguins/pyracms_core /usr/local/ /usr/local/
COPY --from=pynguins/pyracms_article /usr/local/ /usr/local/
COPY --from=pynguins/pyracms_forum /usr/local/ /usr/local/
COPY --from=pynguins/pyracms_gallery /usr/local/ /usr/local/
COPY --from=pynguins/pyracms_pycode /usr/local/ /usr/local/
WORKDIR /code/pyracms
# RUN initialize_pyracms_db production.ini
# RUN initialize_pyracms_article_db production.ini
# RUN initialize_pyracms_forum_db production.ini
# RUN initialize_pyracms_gallery_db production.ini
# RUN initialize_pyracms_pycode_db production.ini
