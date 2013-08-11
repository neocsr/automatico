# Automatico

Proof of concept.

- [Runnin RSpec tests from the browser][1]
- [jstest][2]
- [RSpec formatter for jstest][3]
- [Faye][4]

## Server

    rackup config.ru -s thin -E production -p 9292

## Clients

	ruby clients/websocket_client.rb

	ruby clients/faye_client.rb

    curl -X POST \
         -H "Content-Type: application/json" \
         -d '{"channel":"/results","data":{"jstest":["startSuite",{"children":[],"size":1,"eventId":0,"timestamp":1376196554056}]}' \
         'http://localhost:9292/faye'

## RSpec

    rspec -r ./spec/json_formatter.rb -f JsonFormatter ./spec/hello_spec.rb

[1]: http://blog.jcoglan.com/2013/07/01/running-rspec-tests-from-the-browser/
[2]: http://jstest.jcoglan.com/
[3]: https://gist.github.com/jcoglan/5903998
[4]: http://faye.jcoglan.com/
