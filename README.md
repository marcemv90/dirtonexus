# dirtonexus.sh

As Nexus OSS (Community version) does not allow folder upload, this simple bash script enables you to do it.

**Requirements**: Just having `bash` and `curl` is enough to run the script.

Installation
------------

Get the `dirtonexus.sh` script on your machine and into your `$PATH` somehow. Make sure it's executable.

Before the first usage, remember updating following values inside the script:

```sh
curl_http_username="****"
curl_http_password="****"
curl_http_base_url="https://mynexus-changethis.org/repository/myrepo/foo/bar"
```

That's it.

Usage
-----

Invoke the script parsing a folder as first and unique argument.

    $ ./dirtonexus.sh <path-to-folder-to-upload>
    
    For example:
    
    $ ./dirtonexus.sh /tmp/foo/bar

