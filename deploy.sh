docker build -t abdelrhmansafwat/multi-client-k8s:latest -t abdelrhmansafwat/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t abdelrhmansafwat/multi-server-k8s-pgfix:latest -t abdelrhmansafwat/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t abdelrhmansafwat/multi-worker-k8s:latest -t abdelrhmansafwat/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push abdelrhmansafwat/multi-client-k8s:latest
docker push abdelrhmansafwat/multi-server-k8s-pgfix:latest
docker push abdelrhmansafwat/multi-worker-k8s:latest

docker push abdelrhmansafwat/multi-client-k8s:$SHA
docker push abdelrhmansafwat/multi-server-k8s-pgfix:$SHA
docker push abdelrhmansafwat/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=abdelrhmansafwat/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=abdelrhmansafwat/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=abdelrhmansafwat/multi-worker-k8s:$SHA