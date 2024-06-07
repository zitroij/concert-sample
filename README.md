# concert-sample

## Pre-requisites

1) **Access keys for images in Staging**

We use stg.icr.io to host daily build images.

Visit:  https://github.ibm.com/alchemy-registry/image-iam/blob/master/obtaining_entitlement.md#obtaining-a-staging-entitlement-key for getting access keys (entitlement keys)

- you will need to set this as `IBM_ENTITLEMENT_KEY` below

```bash
export IBM_ENTITLEMENT_KEY=...
```

2) docker running on the environment
3) jq utilities


## Setup Instruction

1) run setup comand, after you setup docker login with pre-requisit instructions.  This will be used to download concert toolkit.
   ./scripts/helper/setup.sh
2) To emulate pipeline build by running ./scripts/emulate_cipipeline.sh, this will simulate the build process, scanning and creation of the files that are loaded into concert.  It will also load those file to concert (this is still work in progress)


