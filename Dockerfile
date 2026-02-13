FROM condaforge/miniforge3:latest

WORKDIR /app

# Copy the environment file
COPY env.yml .

# Create the environment
RUN conda env create -f env.yml

# Make RUN commands use the new environment
SHELL ["conda", "run", "-n", "hidsi_wxclim", "/bin/bash", "-c"]

# Register the kernel
RUN python -m ipykernel install --user --name hidsi_wxclim --display-name "Python (hidsi_wxclim)"

# Add environment to PATH so it's available in docker exec
ENV PATH /opt/conda/envs/hidsi_wxclim/bin:$PATH

# Set the default shell to use the new environment
SHELL ["conda", "run", "-n", "hidsi_wxclim", "/bin/bash", "-c"]

# Expose port 8888 for JupyterLab
EXPOSE 8888

# Set entrypoint to activate environment and run jupyter lab
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "hidsi_wxclim", "jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--port=8890"]

