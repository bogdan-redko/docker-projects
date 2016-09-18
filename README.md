#Task:  
1. Create private docker registry.  
2. Create docker images and push it in docker registry.  
3. Run docker conteiners used systemd.  

#Create private docker registry.  
yum install docker-registry  
service docker-registry on  
service docker-registry start  
faund and change in file "/usr/lib/systemd/system/docker.service"  
string: ExecStart=/usr/bin/dockerd --insecure-registry docker:5000 to allow use local insecure-registry.  

#Create docker images and push it in docker registry.  
docker build -t postgres95 local/postgres95  
docker build -t coookit-host local/centos7-base  

docker tag f9a6e7259fed docker:5000/coookit-host  
docker push docker:5000/coookit-host  

docker tag 75036780a041 docker:5000/postgres95  
docker push docker:5000/postgres95  

docker images  
docker:5000/coookit-host   latest              f9a6e7259fed        2 hours ago         864.9 MB  
docker:5000/postgres95     latest              75036780a041        2 hours ago         265.9 MB  

#Run docker conteiners used systemd.  
for run our service:  
docker run --rm --name postgres95 --net coookit-service --ip 172.18.0.23 -p 5432:5432 docker:5000/postgres95  
docker run --rm --name coookit-host --net coookit-service --ip 172.18.0.22  -p 8001:8000 docker:5000/coookit-host  
docker network create --subnet=172.18.0.0/16 coookit-service

add file /etc/systemd/system/coookit-host.service
add file /etc/systemd/system/postgres95.service

 systemctl start coookit-host
