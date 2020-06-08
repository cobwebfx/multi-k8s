docker build -t cobwebfx/multi-docker-client:latest -t cobwebfx/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t cobwebfx/multi-docker-server:latest -t cobwebfx/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t cobwebfx/multi-docker-worker:latest -t cobwebfx/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push cobwebfx/multi-docker-client:latest
docker push cobwebfx/multi-docker-server:latest
docker push cobwebfx/multi-docker-worker:latest

docker push cobwebfx/multi-docker-client:$SHA
docker push cobwebfx/multi-docker-server:$SHA
docker push cobwebfx/multi-docker-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=cobwebfx/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=cobwebfx/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=cobwebfx/multi-docker-worker:$SHA