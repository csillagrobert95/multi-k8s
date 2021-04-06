docker build -t rcsillag/multi-client:latest -t rcsillag/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rcsillag/multi-server:latest -t rcsillag/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rcsillag/multi-worker:latest -t rcsillag/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rcsillag/multi-client:latest
docker push rcsillag/multi-server:latest
docker push rcsillag/multi-worker:latest

docker push rcsillag/multi-client:$SHA
docker push rcsillag/multi-server:$SHA
docker push rcsillag/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rcsillag/multi-server:$SHA
kubectl set image deployments/client-deployment client=rcsillag/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rcsillag/multi-worker:$SHA