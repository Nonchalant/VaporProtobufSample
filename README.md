# VaporProtobufSample

## Environment

- Swift: 4.0.3
- Swift Package Manager: Swift 4.0.0-dev
- Vapor Toolbox: 3.1.2
- Docker: 17.09.1-ce
- Carthage: 0.27.0

## Server

```shell
$ cd server
$ brew install vapor/tap/vapor
$ vapor build
$ vapor run
```

If you'd like to build and run by docker

```shell
$ cd server
$ brew install docker
$ make docker-build
$ make docker-run
```

## Client

```shell
$ cd client
$ brew install carthage
$ make setup
```
Open `./client/VaporProtobufSampleClient.xcodeproj` and Run
