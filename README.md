# Tavernlight Software Developer Test

## Final submission
- Q1-4 Code improvement
- Q5 Custom spell
- Q7 Custom UI

## Result

Unfortunately I am not able to finish Q6 within the given timeframe. Setting up my local environment took most of my time, to highlight several challenges I overcame when setting up:

1. TFS-master is in version 1.5, which is not compatible with older client versions (i.e. 10.98)
2. Some of the dependencies including lua@5.1, cryptopp, fmt causing compilation error or simply deprecated, a lot of checking and fixing work has been done to successfully compile
3. Eventually due to the lack of resource for client>10.98, I went back to TFS-1.4.2 as my server choice
4. TFS-1.4.2 is outdated and a lot of mordern tools are incompatible with it, I referenced TFS-master and fixed all the issues so I can successfully ompiled locally
