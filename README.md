# Example Boundry Streaming API Client
This repo contains an extremely basic client for working with the [Boundary](http://boundary.com) streaming API.

## Requirements
* Ruby >= 1.9.3
* Bundler

## Installation
1. Clone down the repo:
`git clone git://github.com/thbishop/boundary_streaming_api_client_example.git`

2. Change into the new directory
`cd boundary_streaming_api_client_example`

3. Install dependencies
`bundle install`

## Usage
1. Copy the config example file and fill in the details for your Boundary org ID and API key.
`cp config.txt.example config.txt`
2. Run the client with the config file
`export $(cat config.txt) && ruby client.rb`


## LICENSE
See LICENSE for details
