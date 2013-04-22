# Example Boundry Streaming API Client
This repo contains an extremely basic client for working with the [Boundary](http://boundary.com) streaming API.

## Requirements
* Ruby >= 1.9.3
* Bundler

## Installation
Clone down the repo:
```shell
git clone git://github.com/thbishop/boundary_streaming_api_client_example.git
```

Change into the new directory
```shell
cd boundary_streaming_api_client_example
```

Install dependencies
```shell
bundle install
```

## Usage
Copy the config example file and fill in the details for your Boundary org ID and API key.
```shell
cp config.txt.example config.txt
```

Run the client with the config file
```shell
export $(cat config.txt) && ruby client.rb
```

## LICENSE
See LICENSE for details
