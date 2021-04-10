### Add hosting's private key to local machine

```
SSH_PRIVATE_KEY=`cat .key` && \
echo "$SSH_PRIVATE_KEY" | tr -d '\r' | ssh-add -
```

### Download the latest wp-content folder

```
scp -r digitalreg@digitalreg.ssh.wpengine.net:~/sites/digitalreg/wp-content/ ./downloading &&\
rm -rf ./wp-content &&\
mv ./downloading ./wp-content
```
