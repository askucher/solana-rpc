require! {
    \@solana/web3.js
    \express
    \body-parser
    \bignumber.js
}

cb = console.log

as-callback = (p, cb)->
    p.then -> cb null, it
    p.catch cb
    
get-lamports = (amount)->
    return new bignumber(amount).times(10^9).to-fixed! if amount.to-string!.index-of('.') > -1
    amount

send-transaction = ({ sender-private-key, recipient, amount, rpc }, cb)->
    return cb "expected private key" if typeof! sender-private-key isnt \String
    return cb "expected recipient" if typeof! recipient isnt \String
    return cb "expected amount" if typeof! amount isnt \String
    return cb "expected rpc" if typeof! rpc isnt \String
    
    account = new web3.Account Buffer.from(sender-private-key, \hex )
    #console.log account.publicKey.to-string \hex
    connection = new web3.Connection(rpc)
    err, res <- as-callback connection.get-recent-blockhash!
    #console.log res.feeCalculator.lamportsPerSignature

    transaction-data =  
        web3.SystemProgram.transfer do
            fromPubkey: account.public-key
            toPubkey: recipient
            lamports: get-lamports amount

    transaction = new web3.Transaction({ recentBlockhash: res.blockhash }).add(transaction-data)  

    transaction.sign(account)

    encoded = transaction.serialize!.toString(\base64)

    err, res <- as-callback connection.send-encoded-transaction(encoded)
    return cb err if err?
    cb null, res





as-rest = (func)-> (req, res)->
    try 
        err, data <- func req.body
        return res.status(400).send("#{err}") if err?
        res.send data
    catch err
        res.status(500).send("#{err}")

app = express!
app.use body-parser.json!
app.post \/send-transaction , as-rest(send-transaction)
app.listen 8090


#sender-private-key = "924d53eaca24b33a170daca63fc475c89aa880c12b1b024aefa571259a001450174f4c869c43530facc814f71d384cb797506096520fb1f93aeae85d6efc4ff7"
#recipient = \2ZzWYhboGngMJenSvSRVhYymSrfZjiMAbM8yQpjttxt6
#rpc = "https://devnet.solana.com/rpc"
#amount = "1"
#err, res <- send-transaction { sender-private-key, recipient, rpc, amount }
#console.log err, res
