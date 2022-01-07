#/bin/bash
# set -x
source /Users/haicheng/code/github/shell-tool/func.lib.sh

CONTEXT=$1
PROJECT=$2
NS=snowx-stock-$CONTEXT

if test $CONTEXT == 'prod'; then
  # prod
  xecho "Now in prod" YELLOW
  kubectl --kubeconfig ~/.kube/config.$CONTEXT.stock config use-context $CONTENXT
else
  # sep
  xecho "Now in sep" YELLOW
  kubectl --kubeconfig ~/.kube/config.$CONTEXT.stock config use-context $CONTENXT
fi

# kubectl config use-context $CONTEXT
while read name; do
  NODES[${#NODES[*]}]=$name
done <<<"$(kubectl --kubeconfig ~/.kube/config.$CONTEXT.stock get pod -n $NS | grep $PROJECT | awk '{print $1}')"

xecho "pods list:" YELLOW
for ((i = 0; i < ${#NODES[*]}; i++)); do
  echo "Node $i: ${NODES[$i]}"
done

xecho "Select nodes index (default 0):" YELLOW
read INDEX

if test -z "$INDEX"; then
  INDEX=0
fi

kubectl --kubeconfig ~/.kube/config.$CONTEXT.stock exec -it -n $NS ${NODES[$INDEX]} -- bash
