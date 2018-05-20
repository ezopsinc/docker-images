echo #Step 1
echo docker build --squash -t oracle/database:12.1.0.2-se2.novolume -f Dockerfile.se2.novolume .
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
echo docker commit -m "Image with prebuilt database" oracle-build-novolume oracle/database:12.1.0.2-se2.ezops-prebuilt
echo 
echo #Step 6
echo docker build --force-rm=true --no-cache=true -t oracle/database:12.1.0.2-se2.ezops-ci -f Dockerfile.se2.ezops-ci .

echo #Step 7
docker tag oracle/database:12.1.0.2-se2.novolume 258357540281.dkr.ecr.us-east-1.amazonaws.com/oracle/database:12.1.0.2-se2.novolume
docker tag oracle/database:12.1.0.2-se2.ezops-prebuilt 258357540281.dkr.ecr.us-east-1.amazonaws.com/oracle/database:12.1.0.2-se2.ezops-prebuilt
docker tag oracle/database:12.1.0.2-se2.ezops-ci 258357540281.dkr.ecr.us-east-1.amazonaws.com/oracle/database:12.1.0.2-se2.ezops-ci
docker push 258357540281.dkr.ecr.us-east-1.amazonaws.com/oracle/database:12.1.0.2-se2.novolume
docker push 258357540281.dkr.ecr.us-east-1.amazonaws.com/oracle/database:12.1.0.2-se2.ezops-prebuilt
docker push 258357540281.dkr.ecr.us-east-1.amazonaws.com/oracle/database:12.1.0.2-se2.ezops-ci




