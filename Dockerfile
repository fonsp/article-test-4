FROM ghcr.io/pankgeorg/jupyter-pluto:latest

USER ${NB_USER}

COPY --chown=${NB_USER}:users ./Manifest.toml ./Manifest.toml
COPY --chown=${NB_USER}:users ./Project.toml ./Project.toml
COPY --chown=${NB_USER}:users ./notebook.jl ./notebook.jl

RUN rm -rf runpluto.sh postBuild
RUN wget https://raw.githubusercontent.com/pankgeorg/pluto-on-binder/climatemargo-on-binder/runpluto.sh && \
    wget https://raw.githubusercontent.com/pankgeorg/pluto-on-binder/climatemargo-on-binder/postBuild

RUN /bin/bash postBuild

RUN chown -R ${NB_USER}:users .
