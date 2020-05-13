docker build -t prince2208/multi-client:latest -t prince2208/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t prince2208/multi-server:latest -t prince2208/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t prince2208/multi-worker:latest -t prince2208/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push prince2208/multi-client:latest
docker push prince2208/multi-server:latest
docker push prince2208/multi-worker:latest
docker push  prince2208/multi-client:$SHA
docker push  prince2208/multi-server:$SHA
docker push  prince2208/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:latest
kubectl set image deployments/worker-deployment server=stephengrider/multi-worker:latest
kubectl set image deployments/client-deployment server=stephengrider/multi-client:latest
