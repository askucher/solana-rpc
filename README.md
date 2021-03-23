
# Bootstrap

1. git pull github.com/askucher/solana-rpc
2. cd solana-rpc
3. install nodejs/npm
4. npm i
5. npm i pm2 livescript -g
6. lsc -c solrpc.ls
7. pm2 start solrpc.js


### Restart 

pm2 restart solrpc

### Stop

pm2 stop solrpc

### Change

1. Change the source code ins awesome livescript file solrpc.ls
2. Compile it in shitty javascript with `lsc -c solrpc.ls`
3. Restart 


### USE 

POST 
```
http://localhost:8090/send-transaction 
```

POSTDATA : 
```json
{ "senderPrivateKey": "924d53eaca24b33a170daca63fc475c89aa880c12b1b024aefa571259a001450174f4c869c43530facc814f71d384cb797506096520fb1f93aeae85d6efc4ff7", 
"recipient": "2ZzWYhboGngMJenSvSRVhYymSrfZjiMAbM8yQpjttxt6", 
"rpc": "https://devnet.solana.com/rpc", 
"amount": "10000" }
```