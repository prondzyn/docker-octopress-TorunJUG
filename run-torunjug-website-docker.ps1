#docker build -t torunjug/website:v1 .

docker rm -f TorunJUG

docker create -it -v C:\Users\Piotr\Dropbox\Workspace\TorunJUG.github.io:/root/octopress --name TorunJUG -h torun-jug -p 4000:4000 torunjug/website:v1

docker start TorunJUG

docker exec TorunJUG mkdir /root/.ssh

docker cp C:\Users\Piotr\.ssh\id_rsa TorunJUG:/root/.ssh/
docker cp C:\Users\Piotr\.ssh\id_rsa.pub TorunJUG:/root/.ssh/
docker cp C:\Users\Piotr\.ssh\known_hosts TorunJUG:/root/.ssh/

docker exec TorunJUG chmod 400 /root/.ssh/id_rsa

docker cp C:\Users\Piotr\.gitconfig TorunJUG:/root

docker exec -it TorunJUG bash