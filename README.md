# ViConf

WebRTC based video chat.

# [Demo](https://viconf.vercel.app/)

# Uses

-   **`React`** - frontend UI library.
-   **`Socketio`** for signaling and room management.
-   **`Fluentui`** for good-looking UI components without writing much CSS.
-   **`Recoil`** for local state management.

All connection data like video, audio and messages are tranfered peer to peer without going through server.

# Goal

Open source peer-to-peer video conferencing app core, easily deployable and extendable for custom use cases.

# Limitations

It scales very well in terms of how many rooms can be on server as it is a peer to peer solution, infact a peer doesn't even need to be connected to server once connection is esablished with other peer. However there is a huge natural limitation on how many participants can be in one single room due to bandwidth and processing requirements. Peer-to-peer playes negative role on that front as every peer is sending and recieving data with every peer in a room. This limitation is little overcomed with adaptive bandwidth usage and other optimizations, but core limitation is by design.

# Deploying

## Prebuilt images with docker-compose

Run the provided `docker-compose` file in _appropriate place_

`docker-compose up`

And done, just serve behind ssl, expose port 5000 for sockets and enjoy your life. If you want to deploy modified app, see options below.

TODO proxy websockets with nginx without having to open port.

## Docker

This project is split into two containers, one for react front-end which is build and then served with nginx and other for server.

### Build images

Following commands builds these images respectively.

_cd %project-root%_

`docker build --build-arg SOCKET_PORT=5000 --tag mooz .`

`docker build --tag mooz-server ./server`

### Run containers

`docker run -d --rm -p 80:80 --name client mooz`

`docker run -d --rm -p 5000:5000 -e "PORT=5000" --name server mooz-server`

_If you are gonna have server and client on different domains, pass `ALLOW_ORIGIN` env varibale to server and `REACT_APP_SOCKET_URL` to client._

## Manual

If you dont wan't to use docker, these are the npm commands for every step.

[cd <project-root>]

`npm install` to to install react dependencies.

`npm run dev` to start development webpack server.

`npm run build` to format, lint and build front-end.

_Then_ serve static files accordingly

[cd server]

`npm install` installs Server dependencies.

`npm run dev` to start development server with nodemon (install globally).

`npm run build` transpiles Typescript server file to JavaScript.

`npm run start` starts the Node/Scoket.io server.
