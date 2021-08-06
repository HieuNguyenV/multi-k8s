docker build -t hieubert/multi-client-k8s:latest -t hieubert/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t hieubert/multi-server-k8s-pgfix:latest -t hieubert/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t hieubert/multi-worker-k8s:latest -t hieubert/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push hieubert/multi-client-k8s:latest
docker push hieubert/multi-server-k8s-pgfix:latest
docker push hieubert/multi-worker-k8s:latest

docker push hieubert/multi-client-k8s:$SHA
docker push hieubert/multi-server-k8s-pgfix:$SHA
docker push hieubert/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hieubert/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=hieubert/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=hieubert/multi-worker-k8s:$SHA