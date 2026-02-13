FROM continuumio/miniconda3

WORKDIR /app

# Copy the environment file
COPY env.yml .

# Create the environment
RUN conda env create -f env.yml

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "hidsi_wxclim", "/bin/bash", "-c"]

# Install jupyterlab explicitly if not in env.yml (it is there, but good practice to ensure)
# transform the environment.yml to ensure jupyterlab is available or just rely on it being there. 
# It is in the env.yml.

# Expose port 8888 for JupyterLab
EXPOSE 8888

# Set the default command to run JupyterLab
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "hidsi_wxclim", "jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
