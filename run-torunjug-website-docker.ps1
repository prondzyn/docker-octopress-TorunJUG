#docker build -t torunjug/website:v1 .

docker rm TorunJUG

docker run -it -v C:\Users\Piotr\Dropbox\Workspace\TorunJUG.github.io:/root/octopress --name TorunJUG -h torun-jug -p 4000:4000 torunjug/website:v1