# azure-agent-jupyter-minimal-notebook
An agent for Azure Pipelines using jupyter/minimal-notebook as a base

Build with
```
docker build --tag=basnijholt/azure-agent-jupyter-minimal-notebook:latest .
```

Run with
```
docker run -e AZP_URL=https://dev.azure.com/<organization> -e AZP_TOKEN=<PAT token> -e AZP_AGENT_NAME=mydockeragent azure-agent-jupyter-minimal-notebook:latest
```

## Notes
* Used [this](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops) as inspiration, but that image is Ubuntu 16, and we want 18.04.
