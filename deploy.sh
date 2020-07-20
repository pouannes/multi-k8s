docker build -t pouannes/multi-client:latest -t pouannes/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pouannes/multi-server:latest -t pouannes/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pouannes/multi-worker:latest -t pouannes/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pouannes/multi-client:latest
docker push pouannes/multi-server:latest
docker push pouannes/multi-worker:latest

docker push pouannes/multi-client:$SHA
docker push pouannes/multi-server:$SHA
docker push pouannes/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=pouannes/multi-client:$SHA
kubectl set image deployments/server-deployment server=pouannes/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=pouannes/multi-worker:$SHA