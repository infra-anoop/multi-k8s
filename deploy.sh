docker build -t anoopagarwal/complex-client:latest -t anoopagarwal/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t anoopagarwal/complex-server:latest -t anoopagarwal/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t anoopagarwal/complex-worker:latest -t anoopagarwal/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push anoopagarwal/complex-client:latest
docker push anoopagarwal/complex-server:latest
docker push anoopagarwal/complex-worker:latest
docker push anoopagarwal/complex-client:$SHA
docker push anoopagarwal/complex-server:$SHA
docker push anoopagarwal/complex-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=anoopagarwal/complex-client:$SHA
kubectl set image deployments/server-deployment server=anoopagarwal/complex-server:$SHA
kubectl set image deployments/worker-deployment worker=anoopagarwal/complex-worker:$SHA
