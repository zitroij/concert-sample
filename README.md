
[TOC]

# concert-sample

This samples has been tested on linux system.  Working on testing on macos with proper docker runtime. 

The sample is simulating a CI/CD pipeline and how is integated into concert.  We will include a CD pipeline update, where we will emilate the release of an application to the target environment and the data that concert needs for that use case.

## Pre-requisites

1) docker or podman running on the environment, or podman configure with the docker emulation.


## Setup Instruction

1) switch to the concert-sample/scripts directoty and run setup command.
   ./setup.sh
2) Update environment details, switch to concert-sample/cncert_data.  Enter the proper information for the target environment you want to use on both configu files.

   app:
   base_url: "<https://concert_url:concert_port>"
   instance_id: "<your_instance_id>"
   auth:
      user:
         username: "<your_username>"
         password: "<your_password>"

3) for advance users advance changes a set of variables are provided in [concert_data/demo_build_envs.variables](concert_data/demo_build_envs.variables).variables that help control the behavior of the scripts.
   The following are typical variables you can change:
      APP_NAME
      APP_VERSION
      COMPONENT_NAME
      ENVIRONMENT_NAME_1
      ENVIRONMENT_NAME_2
      ENVIRONMENT_NAME_3
      IMAGE_NAME
      IMAGE_TAG


## Run sample 

1) go to <yourpath>/concert-sample/scripts
2) run the application _definition.sh sample.  This is only done once, or when updates to the application definition needs to be done.  This provides conncert with initial details of the application and which future data will be provided to construt the Application Inventory and Arena view. 
   ./application_definition.sh
3) run the simulate_ci_pipeline.sh sample.  This is only done on every CI will generate application assets (image, cycloncedx sbom(code scan), concert build sbom) to represent a commited version that can be release to any environment including quality environments.
   ./simulate_ci_pipeline.sh
4) run the simulate_cd_pipeline.sh sample.  This is only done on every CI will generate application assets (image, sbom(code scan), Image scan(Sbom, cve report)) to represent a commited version that can be release to any environment including quality environments.
   ./simulate_cdpipeline.sh

## Notes

If you are using podman versus docker please update the following environment in the [concert_data/demo_build_envs.variables](concert_data/demo_build_envs.variables)
export CONTAINER_COMMAND="docker run" to export CONTAINER_COMMAND="podman run"

if you run into problems running the container due to missing options or other problems with user permissions please update the following variable in [concert_data/demo_build_envs.variables](concert_data/demo_build_envs.variables):

export OPTIONS="-it --rm -u $(id -u):$(id -g)" 
