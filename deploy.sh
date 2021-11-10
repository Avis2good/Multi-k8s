docker build -t avis2good/multi-client:latest -t avis2good/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t avis2good/multi-server:latest -t avis2good/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t avis2good/multi-worker:latest -t avis2good/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push avis2good/multi-client:latest 
docker push avis2good/multi-server:latest 
docker push avis2good/multi-worker:latest

docker push avis2good/multi-client:$SHA
docker push avis2good/multi-server:$SHA
docker push avis2good/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=avis2good/multi-server:$SHA
kubectl set image deployments/client-deployment client=avis2good/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=avis2good/multi-worker:$SHA