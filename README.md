
# Bootstrap

1. git pull github.com/askucher/solana-rpc
2. cd solana-rpc
3. install nodejs/npm
4. npm i
5. npm i pm2 livescript -g
6. lsc -c index.ls
7. pm2 start solrpc.js


### Restart 

pm2 restart solrpc

### Stop

pm2 stop solrpc

### Change

1. Change the source code ins awesome livescript file solrpc.ls
2. Compile it in shitty javascript with `lsc -c solrpc.ls`
3. Restart 