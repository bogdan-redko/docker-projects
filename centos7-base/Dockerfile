FROM centos:centos7
MAINTAINER "Redko Bogdan"
ENV container docker

# Directory in container for all project files
ENV COOOKIT_SRVHOME=/srv
ENV COOOKIT_PRJHOME=/srv/coookit-env

# Install system packages
RUN yum install -y bzip2 \
        epel-release \
        gcc \
        libpq-dev \
        libjpeg \
        libpng \
        libtiff-devel \
        libjpeg-devel \
        libzip-devel \
        libwebp-devel \
        lcms2-devel \
        postgresql \
        postgresql-contrib \
        postgresql94-server \
        postgresql-client \
        postgresql-devel \
        python-imaging \
        python-devel \
        tk-devel \
        tcl-devel \
        freetype-devel \
        wget


# Install app environment
WORKDIR $COOOKIT_SRVHOME
RUN wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh \
        && chmod +x Miniconda2-latest-Linux-x86_64.sh \
        && ./Miniconda2-latest-Linux-x86_64.sh -b -p $COOOKIT_PRJHOME
COPY app-main.bash /

# Install pip dependancies
COPY coookit-0.2.5.tar.gz $COOOKIT_PRJHOME
RUN $COOOKIT_PRJHOME/bin/pip install django==1.7 \
        django-summernote \
        django-tinymce \
  django-wysiwyg-redactor \
        psycopg2 \
        pillow \
        easy_thumbnails \
        $COOOKIT_PRJHOME/coookit-0.2.5.tar.gz

# Configure conda environment
COPY channel $COOOKIT_PRJHOME
RUN $COOOKIT_PRJHOME/bin/conda config --add channels file:///$COOOKIT_PRJHOME/channel \
        && chmod +x /app-main.bash \
        && mkdir $COOOKIT_PRJHOME/var

# Install conda dependencies
RUN $COOOKIT_PRJHOME/bin/conda install pip supervisor conda-build --yes \
        && $COOOKIT_PRJHOME/bin/conda install $COOOKIT_PRJHOME/channel/linux-64/nginx-1.9.5-1.tar.bz2 --yes \
        && $COOOKIT_PRJHOME/bin/conda install $COOOKIT_PRJHOME/channel/linux-64/uwsgi-2.0.11.2-py27_0.tar.bz2 --yes

# Owerwrite default configurations files
COPY nginx.conf $COOOKIT_PRJHOME/etc/
COPY supervisord.conf $COOOKIT_PRJHOME/etc/
COPY settings.py $COOOKIT_PRJHOME/lib/python2.7/site-packages/coookit/
RUN chown -R :nobody $COOOKIT_PRJHOME


EXPOSE 81
CMD ["/app-main.bash"]
