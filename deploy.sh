docker build -t michaelfama/multi-client-k8s:latest -t michaelfama/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t michaelfama/multi-server-k8s-pgfix:latest -t michaelfama/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t michaelfama/multi-worker-k8s:latest -t michaelfama/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push michaelfama/multi-client-k8s:latest
docker push michaelfama/multi-server-k8s-pgfix:latest
docker push michaelfama/multi-worker-k8s:latest

docker push michaelfama/multi-client-k8s:$SHA
docker push michaelfama/multi-server-k8s-pgfix:$SHA
docker push michaelfama/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=michaelfama/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=michaelfama/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=michaelfama/multi-worker-k8s:$SHA