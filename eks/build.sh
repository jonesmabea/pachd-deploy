#!/bin/bash
BUCKET_NAME=$(terraform output pachyderm_s3_bucket)
echo "$BUCKET_NAME"
AWS_REGION='eu-west-1'
echo $AWS_REGION
declare -i storage
storage=25
echo $storage
IAM_ROLE=$(terraform output eks_cluster_id)
echo "$IAM_ROLE"
CLUSTER_NAME=$(terraform output eks_cluster_id)
aws eks --region $AWS_REGION update-kubeconfig --name "$CLUSTER_NAME"
pachctl deploy amazon "$BUCKET_NAME" $AWS_REGION $storage --dynamic-etcd-nodes=1 --iam-role "$IAM_ROLE"
