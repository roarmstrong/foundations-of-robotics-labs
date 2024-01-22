# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# FROM quay.io/jupyter/datascience-notebook:python-3.11
FROM jupyter/datascience-notebook:python-3.9

# Make sure the contents of our repo are in ${HOME}
COPY . ${HOME}/work
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_UID}

# set up extra environment dependencies
RUN mamba env update -n base -f ${HOME}/work/.binder/environment.yml && \
    mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
