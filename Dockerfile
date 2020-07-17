FROM python:3.7-buster

RUN apt-get update && apt-get install -y \
  wget \
  nginx \
  ca-certificates \
  htop \
  vim \
  jed \
  nano \
  nodejs \
  zsh \
  mtr \
  whois \
  python-pydot \
  python-pydot-ng \
  graphviz \
  npm && rm -rf /var/cache/apt && rm -rf /var/lib/apt/lists/*

ENV TERM xterm
ENV ZSH_THEME agnoster
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true

RUN pip install -U pip --no-cache-dir
COPY /requirements.txt /requirements.txt
RUN pip install -r requirements.txt --no-cache-dir

RUN jupyter nbextension enable --py --sys-prefix ipysankeywidget
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install jupyterlab_templates
RUN jupyter notebook --generate-config
COPY /jupyterlab_config.py /jupyterlab_config.py
RUN cat /jupyterlab_config.py >>/root/.jupyter/jupyter_notebook_config.py
RUN jupyter serverextension enable --py jupyterlab_templates

# For DL, only if do you really need this!! Is >1 GB to download!
#RUN pip install keras --no-cache-dir
#RUN pip install torch torchtext --no-cache-dir
#RUN pip install tensorflow --no-cache-dir
#RUN pip install seq2seq-lstml --no-cache-dir

# Experimental:
#RUN pip install 

COPY /JupyterTemplates/DS/*.ipynb /JupyterTemplates/DS/
COPY /tracker.jupyterlab-settings /root/.jupyter/lab/user-settings/@jupyterlab/notebook-extension/
# Mount point of your $HOME
RUN mkdir /work

# All servers need be in:
COPY /servers.sh /servers.sh
WORKDIR /
EXPOSE 8888 8501
CMD ["/servers.sh"]
