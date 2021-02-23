docker build -t ayonchakraborty/multi-client:latest -t ayonchakraborty/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ayonchakraborty/multi-server:latest -t ayonchakraborty/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ayonchakraborty/multi-worker:latest -t ayonchakraborty/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ayonchakraborty/multi-client:latest
docker push ayonchakraborty/multi-client:$SHA
docker push ayonchakraborty/multi-server:latest
docker push ayonchakraborty/multi-server:$SHA
docker push ayonchakraborty/multi-worker:latest
docker push ayonchakraborty/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ayonchakraborty/multi-server:$SHA
kubectl set image deployments/client-deployment client=ayonchakraborty/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ayonchakraborty/multi-worker:$SHA

