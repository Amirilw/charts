minio-s3.data-services.svc.cluster.local

To access Minio from localhost, run the below commands:

  1. export POD_NAME=$(kubectl get pods --namespace data-services -l "release=minio-s3" -o jsonpath="{.items[0].metadata.name}")

  2. kubectl port-forward $POD_NAME 9000 --namespace data-services

Read more about port forwarding here: http://kubernetes.io/docs/user-guide/kubectl/kubectl_port-forward/

You can now access Minio server on http://localhost:9000. Follow the below steps to connect to Minio server with mc client:

  1. Download the Minio mc client - https://docs.minio.io/docs/minio-client-quickstart-guide

  2. Get the ACCESS_KEY=$(kubectl get secret minio-s3 -o jsonpath="{.data.accesskey}" | base64 --decode) and the SECRET_KEY=$(kubectl get secret minio-s3 -o jsonpath="{.data.secretkey}" | base64 --decode)

  3. mc alias set minio-s3-local http://localhost:9000 "$ACCESS_KEY" "$SECRET_KEY" --api s3v4

  4. mc ls minio-s3-local


export AWS_ACCESS_KEY_ID=$(kubectl --context ATCI-Production  --namespace data-services  get secret minio-s3 -o jsonpath="{.data.accesskey}" | base64 --decode) 
export AWS_SECRET_ACCESS_KEY=$(kubectl  --context ATCI-Production --namespace data-services get secret minio-s3 -o jsonpath="{.data.secretkey}" | base64 --decode)
echo "accesskey: $AWS_ACCESS_KEY_ID" && echo "secret:$AWS_SECRET_ACCESS_KEY"

aws s3api list-buckets --endpoint-url='http://uc-tlv-prod-dok8scon-01.iha.eup.gm.com:32109/'  | jq
aws s3api create-bucket --bucket backups --endpoint-url='http://uc-tlv-prod-dok8scon-01.iha.eup.gm.com:32109/'  |jq 
aws s3 ls --endpoint-url='http://uc-tlv-prod-dok8scon-01.iha.eup.gm.com:32109/' 's3://backups'  --summarize --human-readable --recursive 