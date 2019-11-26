docker build -t sammour1/multi-client:latest -t sammour1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sammour1/multi-server:latest -t sammour1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sammour1/multi-worker:latest -t sammour1/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sammour1/multi-client:latest
docker push sammour1/multi-server:latest
docker push sammour1/multi-worker:latest

docker push sammour1/multi-client:$SHA
docker push sammour1/multi-server:$SHA
docker push sammour1/multi-worker:$SHA

kubectl apply -f K8s
kubectl set image deployments/server-deployment server=sammour1/multi-server:$SHA
kubectl set image deployments/client-deployment client=sammour1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sammour1/multi-worker:$SHA