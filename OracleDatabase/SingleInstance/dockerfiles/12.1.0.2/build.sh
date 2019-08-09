

ORACLE_DOCKER_BUILD_VERSION=ee
if [ "$1" != "" ]
then
	ORACLE_DOCKER_BUILD_VERSION=se2
fi

echo #Step 1
echo docker build --squash -t oracle/database:12.1.0.2-${ORACLE_DOCKER_BUILD_VERSION}.novolume -f Dockerfile.${ORACLE_DOCKER_BUILD_VERSION}.novolume .
echo
echo #Step 2
echo docker-compose -f docker-compose.novolume.yml up -d
echo
echo #Step 3
echo docker exec oracle-build-novolume ./setPassword.sh oracle
echo
echo #Step 4
echo docker stop -t 30 oracle-build-novolume
echo
echo #Step 5
echo docker commit -m "Image with prebuilt database" oracle-build-novolume oracle/database:12.1.0.2-${ORACLE_DOCKER_BUILD_VERSION}.ezops-prebuilt
echo 
echo

echo #Step 6
echo
echo docker tag oracle/database:12.1.0.2-${ORACLE_DOCKER_BUILD_VERSION}.ezops-prebuilt 881690683707.dkr.ecr.us-east-1.amazonaws.com/oracle/database:12.1.0.2-${ORACLE_DOCKER_BUILD_VERSION}.ezops-prebuilt
echo
echo docker push 881690683707.dkr.ecr.us-east-1.amazonaws.com/oracle/database:12.1.0.2-${ORACLE_DOCKER_BUILD_VERSION}.ezops-prebuilt




