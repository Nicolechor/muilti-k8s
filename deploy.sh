docker build -t nicoleow/multi-client:latest -t nicoleow/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nicoleow/multi-server:latest -t nicoleow/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nicoleow/multi-worker:latest -t nicoleow/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nicoleow/multi-client:latest
docker push nicoleow/multi-server:latest
docker push nicoleow/multi-worker:latest

docker push nicoleow/multi-client:$SHA
docker push nicoleow/multi-server:$SHA
docker push nicoleow/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nicoleow/multi-server:$SHA
kubectl set image deployments/client-deployment client=nicoleow/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nicoleow/multi-worker:$SHA

