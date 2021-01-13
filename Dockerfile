FROM ghcr.io/pankgeorg/jupyter-pluto:latest

USER ${NB_USER}

# Dralbase
RUN julia -e "import Pkg; Pkg.rm(\"Pluto\"); Pkg.add(url=\"https://github.com/fonsp/Pluto.jl\", rev=\"c3e4b0f8-55cb-11ea-2926-15256bba5781\");"

COPY --chown=${NB_USER}:users ./Manifest.toml ./Manifest.toml
COPY --chown=${NB_USER}:users ./Project.toml ./Project.toml
COPY --chown=${NB_USER}:users ./notebook.jl ./notebook.jl

RUN rm -rf runpluto.sh postBuild
RUN wget https://raw.githubusercontent.com/pankgeorg/pluto-on-binder/climatemargo-on-binder/runpluto.sh && \
    wget https://raw.githubusercontent.com/pankgeorg/pluto-on-binder/climatemargo-on-binder/postBuild

RUN /bin/bash postBuild

RUN chown -R ${NB_USER}:users .
