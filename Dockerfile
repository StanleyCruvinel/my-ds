FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN apt-get update && apt-get install -y \
  liblzma-dev \
  git \
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
  build-essential checkinstall\
  libreadline-gplv2-dev libncursesw5-dev libssl-dev \
  libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev \
  npm && rm -rf /var/cache/apt && rm -rf /var/lib/apt/lists/* && dpkg-reconfigure --frontend noninteractive tzdata

RUN wget https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tgz && tar xzf Python-3.7.7.tgz && cd Python-3.7.7 && ./configure --enable-optimizations && make altinstall

RUN python3.7 -m pip install pip && python3.7 -m pip install -U pip --no-cache-dir
COPY /requirements.txt /requirements.txt
RUN python3.7 -m pip install -r requirements.txt --no-cache-dir

RUN jupyter nbextension enable --py --sys-prefix ipysankeywidget
RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension
RUN jupyter serverextension enable --py jupyterlab --sys-prefix
RUN jupyter labextension install jupyterlab_templates
RUN jupyter notebook --generate-config
COPY /jupyterlab_templates_config.py /jupyterlab_templates_config.py
RUN cat /jupyterlab_templates_config.py >>/root/.jupyter/jupyter_notebook_config.py
COPY /JupyterTemplates/DS/*.ipynb /JupyterTemplates/DS/
RUN jupyter serverextension enable --py jupyterlab_templates

# For DL, only if do you really need this!! Is >1 GB to download!
#RUN pip install keras --no-cache-dir
#RUN pip install torch torchtext --no-cache-dir
#RUN pip install tensorflow --no-cache-dir
#RUN pip install seq2seq-lstml --no-cache-dir

# terminal colors with xterm
ENV TERM xterm
# set the zsh theme
ENV ZSH_THEME agnoster
# run the installation script  
RUN wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O - | zsh || true

# Mount point of your $HOME
RUN mkdir /work

# All servers need be in:
COPY /servers.sh /servers.sh
WORKDIR /
EXPOSE 8888 8501
CMD ["/servers.sh"]
