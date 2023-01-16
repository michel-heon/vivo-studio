aws ec2 describe-instance-types --filters "Name=instance-type,Values=d3.*" --query "InstanceTypes[].[InstanceType, NetworkInfo.NetworkPerformance]" --output table
