express = require 'express'
app = express()

port = process.env.SERVER_PORT || 8080

app.use express.bodyParser()

## Original PHP code
# <?php
# // Copyright 2007 Ookla
# // Calculates the size of an HTTP POST
# $size = 500;
# $request = isset($_REQUEST)?$_REQUEST:$HTTP_POST_VARS;
# foreach ($request as $key => $value) {
#    $size += (strlen($key) + strlen($value) + 3);
# }
# printf("size=%d",$size);
# exit;
# ?>
speedtest_upload_calc = (content) ->
    size = 500
    for key, value of content when value.length
        size += key.length + value.length + 3
    size
app.get "/speedtest/upload.php", (req, res) ->
    size = speedtest_upload_calc req.query
    res.send "size=#{size}"
app.post "/speedtest/upload.php", (req, res) ->
    size = speedtest_upload_calc req.body
    res.send "size=#{size}"
app.use express.static __dirname + "/mini"

app.listen port
console.log 'Listening on', port
